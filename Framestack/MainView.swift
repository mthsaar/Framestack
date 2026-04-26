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

    var body: some View {
        ZStack(alignment: .bottom) {

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

            // Barra de busca expandida
            if buscaAtiva {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
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
                            .tint(.accentColor)
                    }

                    Spacer()

                    Button {
                        buscaAtiva = false
                        termoBusca = ""
                    } label: {
                        Text("Cancelar")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.accentColor)
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 54)
                .background(.regularMaterial)
                .clipShape(Capsule())
                .padding(.horizontal, 16)
                .padding(.bottom, 24)

            } else {
                HStack(spacing: 8) {

                    // Pill com abas
                    HStack(spacing: 0) {
                        TabBtn(icone: "house.fill",         label: "Feed",    indice: 0, selecionada: $tabSelecionada)
                        TabBtn(icone: "photo.on.rectangle", label: "Galeria", indice: 1, selecionada: $tabSelecionada)
                        TabBtn(icone: "person.fill",        label: "Perfil",  indice: 2, selecionada: $tabSelecionada)
                    }
                    .padding(.horizontal, 4)
                    .frame(height: 54)
                    .background(.regularMaterial)
                    .clipShape(Capsule())

                    // Botão busca
                    Button {
                        buscaAtiva = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.primary)
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
                            .foregroundStyle(Color.accentColor)
                            .frame(width: 54, height: 54)
                            .background(.regularMaterial)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TabBtn: View {
    let icone: String
    let label: String
    let indice: Int
    @Binding var selecionada: Int

    var ativo: Bool { selecionada == indice }

    var body: some View {
        Button {
            selecionada = indice
        } label: {
            VStack(spacing: 3) {
                Image(systemName: icone)
                    .font(.system(size: 16))
                Text(label)
                    .font(.system(size: 9))
            }
            .foregroundStyle(ativo ? Color.accentColor : Color.secondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .background(
                Capsule()
                    .fill(ativo ? Color.accentColor.opacity(0.15) : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainView(estaLogado: .constant(true))
}
