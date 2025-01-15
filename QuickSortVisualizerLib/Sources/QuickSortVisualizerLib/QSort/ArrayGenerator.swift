//
//  ArrayGenerator.swift
//  QuickSortVisualizerLib
//
//  Created by Anton Grishuk on 14.01.2025.
//
import Foundation

struct ArrayGenerator {
    static func generateArrayWith(size: Int, maxElement: Int) -> [CGFloat] {
        var array: [CGFloat] = []
        for _ in 0...size {
            array
                .append(CGFloat.random(in: 0...CGFloat(maxElement)))
        }
        return array
    }
}
