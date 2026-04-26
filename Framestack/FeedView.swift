//
//  FeedView.swift
//  Framestack
//
//  Created by Matheus  Saar on 25/04/26.
//
import SwiftUI

struct FeedView: View {
    @Binding var termoBusca: String

    var body: some View {
        ZStack {
            Text("Feed em breve...")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
