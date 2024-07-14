//
//  AnimatedQuickSortViewModel.swift
//  AnimatedQuickSort
//
//  Created by Anton Grishuk on 16.06.2024.
//

import Foundation

public protocol QSortInput {
    var arraySize: Int { get set }
    var arrayMaxElement: Int { get set }

    func start()
}

public protocol QSortState {
    var isRunning: Bool { get }
}

public protocol QSortOutput: Observable  {
    var array: [CGFloat] { get }
    var leftIndex: Int? { get }
    var rightIndex: Int? { get }
}

public protocol QSortViewModelType: QSortInput & QSortOutput & QSortState {}

@Observable public class QSortViewModel: QSortViewModelType {
    public var array: [CGFloat]
    public var arraySize: Int {
        didSet {
            generateArray()
        }
    }
    
    public var arrayMaxElement: Int {
        didSet {
            generateArray()
        }
    }
    public var isRunning: Bool = false
    @ObservationIgnored
    public var leftIndex: Int?
    @ObservationIgnored
    public var rightIndex: Int?
    
    private var workItem: DispatchWorkItem?

    private let workQueue = DispatchQueue(
        label: "com.sort.queue",
        qos: .userInitiated,
        attributes: .concurrent
    )
    
    public init(
        array: [CGFloat] = [CGFloat](),
        arraySize: Int = 100,
        arrayMaxElement: Int = 500
    ) {
        self.array = array
        self.arraySize = arraySize
        self.arrayMaxElement = arrayMaxElement
        generateArray()
    }
    
    public func start() {
        guard self.array != self.array.sorted() else {
            return
        }
        self.isRunning = true
        workItem = .init(block: { [unowned self] in
            var mutatingSelf = self
            mutatingSelf.sort(low: 0, high: mutatingSelf.array.count - 1)
            assert(self.array == self.array.sorted(), "The array is not sorted")
            self.leftIndex = 0
            for i in 0...self.arraySize {
                self.rightIndex = i
                self.array = self.array
                _ = self.workItem?.wait(timeout: .now() + .milliseconds(3))
            }
            self.isRunning = false
            self.leftIndex = nil
            self.rightIndex = nil
        })
        workItem.map(workQueue.async(execute:))
    }
}

extension QSortViewModel: QuickSortAlgorithm {
    func swapPause() {
        _ = workItem?.wait(timeout: .now() + .milliseconds(3))
    }
}
