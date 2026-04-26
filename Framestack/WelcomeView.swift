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
            Color(UIColor.systemBackground).ignoresSafeArea()

            VStack(spacing: 32) {

                Spacer()

                VStack(spacing: 12) {
                    Image(systemName: "camera.aperture")
                        .font(.system(size: 56))
                        .foregroundColor(.white)

                    Text("Framestack")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .foregroundColor(.white)

                    Text("A galeria profissional dos fotógrafos.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                VStack(spacing: 12) {
                    Button("Criar conta") {
                        estaLogado = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.11, green: 0.62, blue: 0.46))
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    Button("Entrar") {
                        estaLogado = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .foregroundColor(.white)
                    .cornerRadius(12)

                    Text("Ao continuar, você concorda com os Termos de Uso do Framestack")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WelcomeView(estaLogado: .constant(false))
}
