//
//  MainView.swift
//  AnimatedQuickSort
//
//  Created by Anton Grishuk on 20.06.2024.
//

import SwiftUI
import QuickSortVisualizerLib

struct MainView: View {
    @State
    var viewModel: QSortViewModelType
    var body: some View {
        VStack {
            ControlPanelView(
                arrayCountSliderValue: .init(
                    get: {
                        Double(viewModel.arraySize)
                    },
                    set: {
                        viewModel.arraySize = Int($0)
                    }
                ),
                arrayRangeSliderValue: .init(
                    get: {
                        Double(viewModel.arrayMaxElement)
                    },
                    set: {
                        viewModel.arrayMaxElement = Int($0)
                    }
                ),
                controlPanel: viewModel)
            Divider()
            QSortView(viewModel: viewModel).clipped()
        }
    }
}

#Preview {
    MainView(viewModel: QSortViewModel(algorithm: .init()))
}
