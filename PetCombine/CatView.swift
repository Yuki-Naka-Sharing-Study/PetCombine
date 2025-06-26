//
//  CatView.swift
//  PetCombine
//
//  Created by 仲優樹 on 2025/06/26.
//

import Foundation
import SwiftUI

struct CatView: View {
    @StateObject private var viewModel = CatViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            Text("🐱 猫の育成ゲーム")
                .font(.title)
            
            Text("空腹度: \(viewModel.hunger)")
            Text("元気度: \(viewModel.energy)")
            Text(viewModel.statusMessage)
                .padding()
                .foregroundColor(.blue)
            
            HStack {
                Button("🍚 ごはんをあげる") {
                    viewModel.feedCat()
                }
                Button("🏀 遊ぶ") {
                    viewModel.playWithCat()
                }
            }
            
            Button("⏳ 時間経過") {
                viewModel.decreaseStats()
            }
        }
        .padding()
    }
}
