//
//  File.swift
//  
//
//  Created by Anton Grishuk on 15.07.2024.
//

import Foundation

public final class QuickSortAlgorithm {
    public init() {}

    func quickSort(
        _ array: inout [CGFloat],
        swapCompletion: (Int, Int) -> Void
    ) {
        guard array.isEmpty == false else { return }
        partition(&array, low: 0, high: array.count - 1, swapCompletion: swapCompletion)
    }
    
    private func partition(
        _ array: inout [CGFloat],
        low: Int,
        high: Int,
        swapCompletion: (Int, Int) -> Void
    ) {
        guard low < high else { return }
        var leftIdx = low - 1
        var rightIdx = low
        let pivot = array[high]
        
        while rightIdx <= high {
            if array[rightIdx] <= pivot {
                leftIdx += 1
                swapCompletion(leftIdx, rightIdx)
                array.swapAt(leftIdx, rightIdx)
            }
            rightIdx += 1
        }
        
        partition(&array, low: low, high: leftIdx - 1, swapCompletion: swapCompletion)
        partition(&array, low: leftIdx + 1, high: high, swapCompletion: swapCompletion)
    }
}
