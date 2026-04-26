//
//  WelcomeView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
import SwiftUI

struct WelcomeView: View {
    @Binding var estaLogado: Bool

    var body: some View {
        ZStack {
            // Fundo adaptativo
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                Spacer()

                // Logo e título
                VStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 0.11, green: 0.62, blue: 0.46).opacity(0.12))
                            .frame(width: 72, height: 72)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.11, green: 0.62, blue: 0.46).opacity(0.25), lineWidth: 0.5)
                                )

                        Image(systemName: "camera.aperture")
                            .font(.system(size: 32, weight: .light))
                            .foregroundStyle(.primary)
                    }

                    Text("Framestack")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundStyle(.primary)

                    Text("A galeria profissional\ndos fotógrafos")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }

                Spacer()

                // Card glass com botões
                VStack(spacing: 10) {

                    // Botão criar conta
                    Button {
                        estaLogado = true
                    } label: {
                        Text("Criar conta")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 0.11, green: 0.62, blue: 0.46))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)

                    // Botão entrar
                    Button {
                        estaLogado = true
                    } label: {
                        Text("Entrar")
                            .font(.system(size: 16))
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 0.11, green: 0.62, blue: 0.46).opacity(0.12))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.primary.opacity(0.12), lineWidth: 0.5)
                            )
                    }
                    .buttonStyle(.plain)

                    Divider()
                        .padding(.vertical, 4)

                    Text("Ao continuar, você concorda com os Termos de Uso do Framestack")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                }
                .padding(20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    WelcomeView(estaLogado: .constant(false))
}
