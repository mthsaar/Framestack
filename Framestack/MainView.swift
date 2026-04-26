//
//  MainView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
import SwiftUI

struct MainView: View {
    @Binding var estaLogado: Bool
    @State private var tabSelecionada = 0
    @State private var termoBusca = ""
    @State private var buscaAtiva = false
    @FocusState private var campoAtivo: Bool

    let verdeClaro = Color(red: 0.11, green: 0.62, blue: 0.46).opacity(0.12)
    let verdeEscuro = Color(red: 0.11, green: 0.62, blue: 0.46)

    var body: some View {
        ZStack {
            // Tela ativa
            Group {
                switch tabSelecionada {
                case 0: FeedView(termoBusca: $termoBusca)
                case 1: GaleriaView()
                case 2: PerfilView()
                default: FeedView(termoBusca: $termoBusca)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .overlay(alignment: .bottom) {

            // Barra de busca expandida
            if buscaAtiva {
                HStack(spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(verdeEscuro)
                            .font(.system(size: 15))

                        ZStack(alignment: .leading) {
                            if termoBusca.isEmpty {
                                Text("Buscar fotos e fotógrafos")
                                    .foregroundStyle(.tertiary)
                                    .font(.system(size: 15))
                            }
                            TextField("", text: $termoBusca)
                                .foregroundStyle(.primary)
                                .font(.system(size: 15))
                                .autocorrectionDisabled()
                                .tint(verdeEscuro)
                                .focused($campoAtivo)
                        }

                        Spacer()

                        // Microfone
                        Button {
                            // busca por voz em breve
                        } label: {
                            Image(systemName: "mic.fill")
                                .font(.system(size: 15))
                                .foregroundStyle(verdeEscuro)
                        }
                    }
                    .padding(.horizontal, 14)
                    .frame(height: 54)
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(verdeEscuro.opacity(0.25), lineWidth: 0.5))

                    // Botão X
                    Button {
                        buscaAtiva = false
                        termoBusca = ""
                        campoAtivo = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(verdeEscuro)
                            .frame(width: 54, height: 54)
                            .background(.regularMaterial)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(verdeEscuro.opacity(0.25), lineWidth: 0.5))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 0)
                .transition(.move(edge: .bottom).combined(with: .opacity))

            } else {
                // Barra normal
                HStack(spacing: 8) {

                    // Pill com abas
                    HStack(spacing: 0) {
                        TabBtn(icone: "house.fill",         label: "Feed",    indice: 0, selecionada: $tabSelecionada, verdeClaro: verdeClaro, verdeEscuro: verdeEscuro)
                        TabBtn(icone: "photo.on.rectangle", label: "Galeria", indice: 1, selecionada: $tabSelecionada, verdeClaro: verdeClaro, verdeEscuro: verdeEscuro)
                        TabBtn(icone: "person.fill",        label: "Perfil",  indice: 2, selecionada: $tabSelecionada, verdeClaro: verdeClaro, verdeEscuro: verdeEscuro)
                    }
                    .padding(.horizontal, 4)
                    .frame(height: 54)
                    .background(.regularMaterial)
                    .clipShape(Capsule())

                    // Botão busca
                    Button {
                        buscaAtiva = true
                        campoAtivo = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(verdeEscuro)
                            .frame(width: 54, height: 54)
                            .background(.regularMaterial)
                            .clipShape(Circle())
                    }

                    // Botão +
                    Button {
                        // upload em breve
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(verdeEscuro)
                            .frame(width: 54, height: 54)
                            .background(.regularMaterial)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 0)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .safeAreaPadding(.bottom, 4)
    }
}

struct TabBtn: View {
    let icone: String
    let label: String
    let indice: Int
    @Binding var selecionada: Int
    let verdeClaro: Color
    let verdeEscuro: Color

    var ativo: Bool { selecionada == indice }

    var body: some View {
        Button {
            selecionada = indice
        } label: {
            VStack(spacing: 8) {
                Image(systemName: icone)
                    .font(.system(size: 16))
                Text(label)
                    .font(.system(size: 9))
            }
            .foregroundStyle(ativo ? verdeEscuro : Color.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(
                Capsule()
                    .fill(ativo ? verdeClaro : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainView(estaLogado: .constant(true))
}
