//
//  AnimatedQuickSortApp.swift
//  AnimatedQuickSort
//
//  Created by Anton Grishuk on 16.06.2024.
//

import SwiftUI
import QuickSortVisualizerLib

@main
struct QuickSortVisualizerApp: App {
    let qSortViewModel = QSortViewModel(algorithm: .init())
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: qSortViewModel)
        }
    }
}
