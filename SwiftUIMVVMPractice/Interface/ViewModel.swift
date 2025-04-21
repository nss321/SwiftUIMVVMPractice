//
//  ViewModel.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/17/25.
//

import Foundation
import Combine

protocol ViewModel: AnyObject, ObservableObject {
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get set }
    
    var input: Input { get set }
    var output: Output { get set }
    
    func transform()
}
