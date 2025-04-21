//
//  AnimationView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/17/25.
//

import SwiftUI

struct AnimationView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            topTitle()
            Spacer()
            Button("Animation On") {
                withAnimation {
                    isExpanded = true
                }
            }
            
            Button("Animation Off") {
                withAnimation {
                    isExpanded = false
                }
            }
            
            Button("Toggle") {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            List {
                ForEach([Color.red, Color.green, Color.blue], id: \.self) {
                    $0
                }
            }
            .listStyle(.plain)
        }
    }

    func topTitle() -> some View {
        Text("Hello, World")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: isExpanded ? .leading : .center)
            .overlay(alignment: .trailing) {
                topOverlay()
            }
            .padding()
    }
    
    func topOverlay() -> some View {

        Button {
            withAnimation {
                isExpanded.toggle()
            }

        } label: {
            Image(systemName: "plus")
                .bold()
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())
                .rotationEffect(.degrees(isExpanded ? 720 : 45))
                .scaleEffect(isExpanded ? 30 : 1)
                .opacity(isExpanded ? 0 : 1)
            
        }

        
    }
}

#Preview {
    AnimationView()
}
