//
//  SharedUserDefaults.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/21/25.
//

import Foundation

extension UserDefaults {
    static var groupShared: UserDefaults {
        let appID = "group.SeSAC.sean.swiftui.basicwidget"
        return UserDefaults(suiteName: appID)!
    }
}
