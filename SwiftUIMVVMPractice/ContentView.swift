//
//  ContentView.swift
//  SwiftUIMVVMPractice
//
//  Created by BAE on 4/17/25.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @State private var nickname: String = "" // SoT
    @State private var age = 0
//    @AppStorage
    var body: some View {
        VStack {
            TextField("닉네임을 입력해보세요.", text: $nickname)
                .padding(.vertical, 40)
                .padding(.horizontal, 40)
                .border(.black, width: 1)
            
            Button("저장") {
                UserDefaults.standard.set(nickname, forKey: "nickname")
                UserDefaults.groupShared.set(nickname, forKey: "nickname")
                
                /*
                 1. 저장 버튼 클릭 시 위젯이 바로 렌더링
                 2. UserDefaults jack이 Widget에 안보임
                    - 앱은 앱컨테이너, 확장 번들들은 확장 컨테이너를 사용함(Keyboard, Widget 등)
                    - 공유하기 위해선 쉐어 컨테이너를 사용해야함. -> App Group
                 
                 ===> 위젯만들때 App Group이 무조건 필요한건 X
                 ===> App Group은 위젯에서만 사용하는거 X
                 */
                WidgetCenter.shared.reloadTimelines(ofKind: "BasicWidget")
                WidgetCenter.shared.getCurrentConfigurations { widget in
                    switch widget {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
            Text(UserDefaults.groupShared.string(forKey: "nickname") ?? "N/A")
                .padding()
            CountView()
        }
        .padding()
    }
}

/*
 ObservableObject
 - 클래스의 인스턴스를 관찰하고 있다가, @Published로 선언된 데이터가 변경이 되면 신호를 보내준다!
 
 StateObject
 - @Published로 선언된 데이터가 변경되면 신호를 받음.
 - 이걸로 선언된 인스턴스는 생성 시점에 한번만 초기화 되고, 이후 뷰의 렌더링 여부와 상관 없이 뷰 내에서 재사용됨
 
 ObservedObject
 - 뷰가 렌더링 되면 인스턴스가 새롭게 생성되어서 기존 값이 날아감
 */
struct CountView: View {
//    @State private var age = 0
    @StateObject private var viewModel = CountViewModel()
    var body: some View {
        Text("나이: \(viewModel.age)")
        Button("클릭") {
            viewModel.addAge()
        }
    }
}

class CountViewModel: ObservableObject {
    @Published var age = 0
    
    func addAge() {
        age += 1
    }
}

#Preview {
    ContentView()
}
