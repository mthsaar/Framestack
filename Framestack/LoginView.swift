//
//  LoginView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var estaLogado: Bool
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var senha = ""
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

                        Text("Entrar")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)

                        Text("Bem-vindo de volta")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer().frame(height: 40)

                    // Campos
                    VStack(spacing: 10) {
                        CampoTexto(icone: "envelope", placeholder: "Email", texto: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        CampoSenha(placeholder: "Senha", texto: $senha)

                        // Esqueci a senha
                        Button {
                            // em breve
                        } label: {
                            Text("Esqueci minha senha")
                                .font(.caption)
                                .foregroundStyle(verdeEscuro)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 24)

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
                            fazerLogin()
                        } label: {
                            if carregando {
                                ProgressView()
                                    .tint(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                                    .background(verdeEscuro)
                                    .clipShape(Capsule())
                            } else {
                                Text("Entrar")
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
                            Text("Criar conta")
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

    func fazerLogin() {
        guard !email.isEmpty else { erro = "Insira seu email."; return }
        guard !senha.isEmpty else { erro = "Insira sua senha."; return }

        carregando = true
        erro = ""

        Auth.auth().signIn(withEmail: email, password: senha) { resultado, error in
            carregando = false
            if let error = error {
                erro = error.localizedDescription
                return
            }
            estaLogado = true
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(estaLogado: .constant(false))
    }
}
