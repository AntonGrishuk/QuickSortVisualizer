//
//  ControlPanelView.swift
//  AnimatedQuickSort
//
//  Created by Anton Grishuk on 20.06.2024.
//

import SwiftUI

public struct ControlPanelView: View {
    public init(
        arrayCountSliderValue: Binding<Double>,
        arrayRangeSliderValue: Binding<Double>,
        controlPanel: QSortInput & QSortState
    ) {
        self.arrayCountSliderValue = arrayCountSliderValue
        self.arrayRangeSliderValue = arrayRangeSliderValue
        self.controlPanel = controlPanel
    }
    
    private var arrayCountSliderValue: Binding<Double>
    private var arrayRangeSliderValue: Binding<Double>

    var controlPanel: QSortInput & QSortState
    public var body: some View {
        Spacer()
        
        VStack {
            Text("Array size")
            HStack {
                Spacer()
                Slider(
                    value: self.arrayCountSliderValue,
                    in: 10...1000,
                    step: 10) {
                        Text(String(format: "%.0f",
                                    self.arrayCountSliderValue.wrappedValue))
                    } minimumValueLabel: {
                        Text("10")
                    } maximumValueLabel: {
                        Text("1000")
                    }
                Spacer()
            }
            .disabled(controlPanel.isRunning)
            
            Text("Array generation range")
            
            HStack {
                Spacer()
                Slider(
                    value: self.arrayRangeSliderValue,
                    in: 50...500,
                    step: 10) {
                        Text(String(format: "%.0f",
                                    self.arrayRangeSliderValue.wrappedValue))
                    } minimumValueLabel: {
                        Text("50")
                    } maximumValueLabel: {
                        Text("500")
                    }
                Spacer()
            }
            .disabled(controlPanel.isRunning)
            
            HStack {
                Spacer()
                Button("Start") {
                    controlPanel.start()
                }
                Spacer()
            }
            .disabled(controlPanel.isRunning)
            
        }
        Spacer()
    }
}
