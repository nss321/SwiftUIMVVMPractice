//
//  MyRootView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/21/25.
//

import SwiftUI

struct MyRootView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello")
                NavigationLink("push") {
                    MyChiledView(number: 3)
                }
                NavigationLink("Second", value: 2)
            }
            .navigationTitle("NavigationStack")
            .navigationDestination(for: Int.self) { value in
                MyChiledView(number: value)
            }
        }
    }
}

struct MyChiledView: View {
    var number: Int
    var body: some View {
        Text("ChildView")
    }
}

#Preview {
    MyRootView()
}
