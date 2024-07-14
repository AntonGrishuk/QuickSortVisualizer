//
//  File.swift
//  
//
//  Created by Anton Grishuk on 15.07.2024.
//

import Foundation

protocol QuickSortAlgorithm {
    var array: [CGFloat] { get set }
    var arraySize: Int { get set }
    var arrayMaxElement: Int { get set }
    var leftIndex: Int? { get set }
    var rightIndex: Int? { get set }
    
    mutating func generateArray()
    mutating func sort(low: Int, high: Int)
    func swapPause()
}

extension QuickSortAlgorithm {
    func generateArray() {
        var mutatingSelf = self
        mutatingSelf.leftIndex = nil
        mutatingSelf.rightIndex = nil
        mutatingSelf.array.removeAll()
        for _ in 0...arraySize {
            mutatingSelf.array
                .append(CGFloat.random(in: 0...CGFloat(arrayMaxElement)))
        }
    }

    mutating func sort(low: Int, high: Int) {
        guard low < high else { return }
        let pi = self.partition(low: low, high: high)
        self.sort(low: low, high: pi - 1)
        self.sort(low: pi + 1, high: high)
    }
    
    private mutating func partition(low: Int, high: Int) -> Int {
        leftIndex = low
        rightIndex = high
        let pivot = array[high]
        var i = low - 1
        for j in low..<high {
            if array[j] <= pivot {
                i += 1
                swapAt(i, j)
            }
        }
        
        swapAt(i + 1, high)
        return i + 1
    }
    
    private mutating func swapAt(_ idx1: Int, _ idx2: Int) {
        swapPause()
        self.array.swapAt(idx1, idx2)
    }
}
