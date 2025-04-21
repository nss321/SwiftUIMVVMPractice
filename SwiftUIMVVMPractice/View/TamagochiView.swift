//
//  TamagochiView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/17/25.
//

import SwiftUI

struct TamagochiView: View {
    @StateObject private var viewModel = TamagochiViewModel()
    var body: some View {
        Text("밥알: \(viewModel.rice)개, 물방울 \(viewModel.water)개")
        HStack {
            TextField("밥알을 입력해주세요",
                      text: $viewModel.riceField)
            Button(action: {
                viewModel.addRice()
            }) {
                ZStack {
                    // 배경 그라디언트
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [.white.opacity(0.4), .yellow.opacity(0.1)]),
                                center: .center,
                                startRadius: 10,
                                endRadius: 60
                            )
                        )
                        .blur(radius: 8)
                    
                    // 밥알 본체
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .yellow.opacity(0.7), .orange.opacity(0.5)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            // 유광 효과 (하이라이트)
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [.white.opacity(0.8), .clear]),
                                        center: UnitPoint(x: 0.3, y: 0.3),
                                        startRadius: 10,
                                        endRadius: 40
                                    )
                                )
                        )
                        .overlay(
                            // 테두리 하이라이트
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.white.opacity(0.6), .clear]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                    
                    // 텍스트 또는 아이콘
                    Image(systemName: "circle.fill") // 밥알 모양 대체
                        .font(.system(size: 30))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .yellow.opacity(0.9)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(radius: 2, x: 1, y: 1)
                }
                .frame(width: 100, height: 100)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 4, y: 4)
                .shadow(color: .white.opacity(0.5), radius: 8, x: -4, y: -4)
            }
            .scaleEffect(viewModel.riceTapped ? 0.92 : 1.0)
            .rotation3DEffect(
                .degrees(viewModel.riceTapped ? 5 : 0),
                axis: (x: 1, y: -1, z: 0)
            )
            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: viewModel.riceTapped)
            .onLongPressGesture(minimumDuration: 0.01, pressing: { isPressing in
                viewModel.riceTapped = isPressing
            }, perform: {})
        }
        .padding()
        HStack {
            TextField("물방울을 입력해주세요",
                      text: $viewModel.waterField)
            Button(action: {
                viewModel.addWater()
            }) {
                ZStack {
                    // 배경 그라디언트
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [.cyan.opacity(0.3), .blue.opacity(0.1)]),
                                center: .center,
                                startRadius: 10,
                                endRadius: 60
                            )
                        )
                        .blur(radius: 8)
                    
                    // 물방울 본체
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.cyan, .blue.opacity(0.8), .teal]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            // 유광 효과 (하이라이트)
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [.white.opacity(0.7), .clear]),
                                        center: UnitPoint(x: 0.3, y: 0.3),
                                        startRadius: 10,
                                        endRadius: 40
                                    )
                                )
                        )
                        .overlay(
                            // 테두리 하이라이트
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.white.opacity(0.5), .clear]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                    
                    // 텍스트 또는 아이콘
                    Image(systemName: "drop.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .cyan.opacity(0.8)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(radius: 2, x: 1, y: 1)
                }
                .frame(width: 100, height: 100)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 4, y: 4)
                .shadow(color: .white.opacity(0.5), radius: 8, x: -4, y: -4)
            }
            .scaleEffect(viewModel.waterTapped ? 0.92 : 1.0)
            .rotation3DEffect(
                .degrees(viewModel.waterTapped ? 5 : 0),
                axis: (x: 1, y: -1, z: 0)
            )
            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: viewModel.waterTapped)
            .onLongPressGesture(minimumDuration: 0.01, pressing: { isPressing in
                viewModel.waterTapped = isPressing
            }, perform: {})
        }
        .padding()
    }
}

final class TamagochiViewModel: ObservableObject {
    @Published var riceTapped = false
    @Published var waterTapped = false
    @Published var riceField = ""
    @Published var rice = 0
    @Published var waterField = ""
    @Published var water = 0
    
    func addRice() {
        if let count = Int(riceField) {
            rice += count
        } else {
            rice += 1
        }
    }
    
    func addWater() {
        if let count = Int(waterField) {
            water += count
        } else {
            water += 1
        }
    }
    
    
}

#Preview {
    TamagochiView()
}
