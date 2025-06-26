//
//  CatViewModel.swift
//  PetCombine
//
//  Created by 仲優樹 on 2025/06/26.
//

import SwiftUI
import Combine

class CatViewModel: ObservableObject {
    // 猫の状態：空腹度（0〜100）
    private let hungerSubject = CurrentValueSubject<Int, Never>(50)
    
    // 猫の状態：元気度（0〜100）
    private let energySubject = CurrentValueSubject<Int, Never>(50)
    
    // 総合状態
    @Published var statusMessage: String = "こんにちは、にゃー！"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // combineLatestで猫の状態を統合判定
        hungerSubject
            .combineLatest(energySubject)
            .map { hunger, energy -> String in
                switch (hunger, energy) {
                case (80...100, 80...100):
                    return "すごく元気にゃ！"
                case (50..<80, 50..<80):
                    return "まぁまぁ元気にゃ"
                case (..<50, _), (_, ..<50):
                    return "元気がにゃい…"
                default:
                    return "ようすをみているにゃ"
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$statusMessage)
    }
    
    // MARK: - ユーザー操作
    
    func feedCat() {
        hungerSubject.value = min(hungerSubject.value + 20, 100)
    }
    
    func playWithCat() {
        energySubject.value = min(energySubject.value + 20, 100)
    }
    
    func decreaseStats() {
        // 時間経過で減少（手動呼び出し or Timerで定期実行）
        hungerSubject.value = max(hungerSubject.value - 5, 0)
        energySubject.value = max(energySubject.value - 5, 0)
    }
    
    var hunger: Int { hungerSubject.value }
    var energy: Int { energySubject.value }
}

