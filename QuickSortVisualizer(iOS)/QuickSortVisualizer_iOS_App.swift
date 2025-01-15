//
//  QuickSortVisualizer_iOS_App.swift
//  QuickSortVisualizer(iOS)
//
//  Created by Anton Grishuk on 13.07.2024.
//

import SwiftUI
import QuickSortVisualizerLib

@main
struct QuickSortVisualizer_iOS_App: App {
    let qSortViewModel = QSortViewModel(algorithm: .init())
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: qSortViewModel)
        }
    }
}
