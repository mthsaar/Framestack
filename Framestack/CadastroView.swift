//
//  CadastroView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
import SwiftUI
import FirebaseAuth

struct CadastroView: View {
    @Binding var estaLogado: Bool
    @Environment(\.dismiss) var dismiss

    @State private var nome = ""
    @State private var email = ""
    @State private var senha = ""
    @State private var confirmarSenha = ""
    @State private var erro = ""
    @State private var carregando = false

    let verdeEscuro = Color(red: 0.11, green: 0.62, blue: 0.46)
    let verdeClaro = Color(red: 0.11, green: 0.62, blue: 0.46).opacity(0.12)

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {

                    Spacer().frame(height: 60)

                    // Logo
                    VStack(spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(verdeClaro)
                                .frame(width: 64, height: 64)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(verdeEscuro.opacity(0.25), lineWidth: 0.5)
                                )
                            Image(systemName: "camera.aperture")
                                .font(.system(size: 28, weight: .light))
                                .foregroundStyle(verdeEscuro)
                        }

                        Text("Criar conta")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)

                        Text("Junte-se à comunidade\nde fotógrafos")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }

                    Spacer().frame(height: 40)

                    // Campos
                    VStack(spacing: 10) {
                        CampoTexto(icone: "person", placeholder: "Nome completo", texto: $nome)
                        CampoTexto(icone: "envelope", placeholder: "Email", texto: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        CampoSenha(placeholder: "Senha", texto: $senha)
                        CampoSenha(placeholder: "Confirmar senha", texto: $confirmarSenha)

                        // Mensagem de erro
                        if !erro.isEmpty {
                            Text(erro)
                                .font(.caption)
                                .foregroundStyle(.red)
                                .multilineTextAlignment(.center)
                                .padding(.top, 4)
                        }
                    }

                    Spacer().frame(height: 24)

                    // Botões
                    VStack(spacing: 10) {
                        Button {
                            criarConta()
                        } label: {
                            if carregando {
                                ProgressView()
                                    .tint(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(verdeEscuro)
                                    .clipShape(Capsule())
                            } else {
                                Text("Criar conta")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(verdeEscuro)
                                    .clipShape(Capsule())
                            }
                        }
                        .buttonStyle(.plain)
                        .disabled(carregando)

                        Button {
                            dismiss()
                        } label: {
                            Text("Já tenho conta")
                                .font(.system(size: 16))
                                .foregroundStyle(verdeEscuro)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(verdeClaro)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(verdeEscuro.opacity(0.25), lineWidth: 0.5))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(verdeEscuro)
                }
            }
        }
    }

    func criarConta() {
        // Validações
        guard !nome.isEmpty else { erro = "Insira seu nome."; return }
        guard !email.isEmpty else { erro = "Insira seu email."; return }
        guard senha == confirmarSenha else { erro = "As senhas não coincidem."; return }
        guard senha.count >= 6 else { erro = "A senha deve ter pelo menos 6 caracteres."; return }

        carregando = true
        erro = ""

        Auth.auth().createUser(withEmail: email, password: senha) { resultado, error in
            carregando = false
            if let error = error {
                erro = error.localizedDescription
                return
            }
            // Salvar o nome no perfil
            let req = Auth.auth().currentUser?.createProfileChangeRequest()
            req?.displayName = nome
            req?.commitChanges(completion: nil)

            estaLogado = true
        }
    }
}

// Campo de texto reutilizável
struct CampoTexto: View {
    let icone: String
    let placeholder: String
    @Binding var texto: String

    let verdeEscuro = Color(red: 0.11, green: 0.62, blue: 0.46)

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icone)
                .foregroundStyle(verdeEscuro)
                .frame(width: 20)
            TextField(placeholder, text: $texto)
                .foregroundStyle(.primary)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(verdeEscuro.opacity(0.15), lineWidth: 0.5))
        .padding(.horizontal, 24)
    }
}

// Campo de senha reutilizável
struct CampoSenha: View {
    let placeholder: String
    @Binding var texto: String
    @State private var mostrar = false

    let verdeEscuro = Color(red: 0.11, green: 0.62, blue: 0.46)

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "lock")
                .foregroundStyle(verdeEscuro)
                .frame(width: 20)
            if mostrar {
                TextField(placeholder, text: $texto)
                    .foregroundStyle(.primary)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
            } else {
                SecureField(placeholder, text: $texto)
                    .foregroundStyle(.primary)
            }
            Button {
                mostrar.toggle()
            } label: {
                Image(systemName: mostrar ? "eye.slash" : "eye")
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(verdeEscuro.opacity(0.15), lineWidth: 0.5))
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack {
        CadastroView(estaLogado: .constant(false))
    }
}
