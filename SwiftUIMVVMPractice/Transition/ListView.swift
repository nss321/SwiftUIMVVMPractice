//
//  ListView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/21/25.
//

import SwiftUI

struct ListView: View {
    let array = ["고래밥", "아메리카노", "호올스", "칙촉"]
    @Namespace private var sean
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(array, id: \.self) { item in
                        NavigationLink(value: item) {
                            list(title: item)
                        }
                    }
                }
            }
            .navigationTitle("title")
            .navigationDestination(for: String.self) { item in
                ListDetailView(name: item)
                    .navigationTransition(.zoom(sourceID: item, in: sean))
            }
        }
        
    }
    
    func list(title: String) -> some View {
        HStack {
            Image(systemName: "star")
            Text(title)
        }
        .background(.gray.opacity(0.3))
    }
}

struct ListDetailView: View {
    let name: String
    var body: some View {
        Text(name)
            .font(.largeTitle)
    }
}

#Preview {
    ListView()
}
