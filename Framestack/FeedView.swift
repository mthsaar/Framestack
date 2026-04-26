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
            Color(UIColor.systemBackground).ignoresSafeArea()
            Text("Feed em breve...")
                .foregroundColor(.gray)
        }
    }
}
