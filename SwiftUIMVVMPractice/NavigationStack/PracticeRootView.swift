//
//  PracticeRootView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/22/25.
//

import SwiftUI

struct PracticeRootView: View {
    let model = PracticeModel.mock
    var body: some View {
        NavigationStack {
            List {
                ForEach(model, id: \.id) { item in
                    NavigationLink(value: item) {
                        Text(item.name)
                    }
                }
            }
            .navigationDestination(for: PracticeModel.self) { item in
                PracticeChileView(item: item)
            }
        }
    }
}

struct PracticeChileView: View {
    let item: PracticeModel
    var body: some View {
        ZStack {
            item.color
            VStack {
                Text(item.id.uuidString)
                Text(item.name)
                Text(item.date.description)
                NavigationLink(value: item.name) {
                    Text("Next")
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            print(item)
        }
        .navigationDestination(for: String.self) { name in
            PracticeChildChildView(name: name)
        }
    }
}

struct PracticeChildChildView: View {
    let name: String
    var body: some View {
        Text("Hello, \(name)")
    }
}

struct PracticeModel: Hashable, Equatable {
    let id = UUID()
    let name: String
    let color: Color
    let date: Date
    
    static let mock = [
        PracticeModel(name: "first", color: .accentColor, date: .now),
        PracticeModel(name: "jack", color: .red, date: .now),
        PracticeModel(name: "hue", color: .orange, date: .now),
        PracticeModel(name: "bran", color: .yellow, date: .now),
        PracticeModel(name: "den", color: .green, date: .now),
        PracticeModel(name: "sean", color: .blue, date: .now),
        PracticeModel(name: "moana", color: .indigo, date: .now),
        PracticeModel(name: "musk", color: .purple, date: .now),
        PracticeModel(name: "greed", color: .gray, date: .now),
        PracticeModel(name: "LIV", color: .pink, date: .now),
        PracticeModel(name: "mya", color: .brown, date: .now),
        PracticeModel(name: "moro", color: .cyan, date: .now),
        PracticeModel(name: "mango", color: .mint, date: .now),
        PracticeModel(name: "jigu", color: .teal, date: .now),
    ]
}

#Preview {
    PracticeRootView()
}
