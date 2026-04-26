//
//  GaleriaView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
import SwiftUI

struct GaleriaView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemBackground).ignoresSafeArea()
                Text("Galeria em breve...")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    GaleriaView()
}
