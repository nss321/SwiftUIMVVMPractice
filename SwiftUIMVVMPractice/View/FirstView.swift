//
//  FirstView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/21/25.
//

import SwiftUI

struct FirstView: View {
    @State var isPresented = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                NavigationLink("PUSH") {
                    SecondView()
                }
                .padding()
                
                NavigationLink("Second Way", isActive: $isPresented) {
                    DetailView(isPush: $isPresented)
                }
                .padding()
            }
            .navigationTitle("Navi")
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) private var dismiss // iOS15+
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("POP") {
            dismiss()
        }
    }
}

struct DetailView: View {
    @Binding var isPush: Bool
    var body: some View {
        Text("Detail View")
        Button("POP") {
            isPush = false
        }
    }
}

#Preview {
    FirstView()
}
