//
//  ContentView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var estaLogado = false

    var body: some View {
        if estaLogado {
            MainView(estaLogado: $estaLogado)
        } else {
            WelcomeView(estaLogado: $estaLogado)
        }
    }
}

#Preview {
    ContentView()
}
