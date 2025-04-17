//
//  TamagochiUpgradeView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/17/25.
//

import SwiftUI
import Combine

struct TamagochiUpgradeView: View {
    @StateObject private var viewModel = TamagochiUpgradeViewModel()
    var body: some View {
        Text("밥알: \(viewModel.output.rice)개, 물방울 \(viewModel.output.water)개")
        HStack {
            TextField("밥알을 입력해주세요",
                      text: $viewModel.input.riceField)
            Button("밥알") {
                viewModel.action(.addRice)
            }
        }
        .padding()
        HStack {
            TextField("물방울을 입력해주세요",
                      text: $viewModel.input.waterField)
            Button("물방울") {
//                viewModel.input.waterTapped.send(())
                viewModel.action(.addWater)
            }
        }
        .padding()
    }
}

/*
 input output
 
 
 */

final class TamagochiUpgradeViewModel: ViewModel {
    
    var input = Input()
    @Published var output = Output()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        transform()
    }
    
}

// MARK: Input/Output
extension TamagochiUpgradeViewModel {
    
    struct Input {
        var riceTapped = PassthroughSubject<Void, Never>()
        var waterTapped = PassthroughSubject<Void, Never>()
        var riceField = ""
        var waterField = ""
        
    }
    
    struct Output {
        var rice: Double = 0
        var water = 0
    }
    
    func transform() {
        input.riceTapped
            .sink { [weak self] _ in
                self?.addRice()
            }
            .store(in: &cancellables)
        
        input.waterTapped
            .sink { [weak self] _ in
                self?.addWater()
            }
            .store(in: &cancellables)
    }
        
    private func addRice() {
        if let count = Double(input.riceField) {
            output.rice += count
        } else {
            output.rice *= 1.03
        }
    }
    
    private func addWater() {
        if let count = Int(input.waterField) {
            output.water += count
        } else {
            output.water += 1
        }
    }
}

// MARK: Action
extension TamagochiUpgradeViewModel {
    enum Action {
        case addRice
        case addWater
    }

    func action(_ action: Action) {
        switch action {
        case .addRice:
            input.riceTapped.send(())
        case .addWater:
            addWater()
            input.riceTapped.send(())
        }
    }
}

#Preview {
    TamagochiUpgradeView()
}
