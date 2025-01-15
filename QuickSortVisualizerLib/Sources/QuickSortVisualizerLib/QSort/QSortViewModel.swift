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
    var outputArray: [CGFloat] { get }
    var leftIndex: Int? { get }
    var rightIndex: Int? { get }
}

public protocol QSortViewModelType: QSortInput & QSortOutput & QSortState {}

@Observable public class QSortViewModel: QSortViewModelType {
    public var outputArray: [CGFloat]
    public var arraySize: Int {
        didSet {
            self.array = ArrayGenerator.generateArrayWith(size: arraySize, maxElement: arrayMaxElement)
            DispatchQueue.main.async {
                self.outputArray = self.array
            }
        }
    }
    
    public var arrayMaxElement: Int {
        didSet {
            self.array = ArrayGenerator.generateArrayWith(size: arraySize, maxElement: arrayMaxElement)
            DispatchQueue.main.async {
                self.outputArray = self.array
            }
        }
    }
    public var isRunning: Bool = false
    @ObservationIgnored
    public var leftIndex: Int?
    @ObservationIgnored
    public var rightIndex: Int?
    
    private var array: [CGFloat]
    private var workItem: DispatchWorkItem?
    private let workQueue = DispatchQueue(
        label: "com.sort.queue",
        qos: .userInitiated,
        attributes: .concurrent
    )
    private let algorithm: QuickSortAlgorithm
    
    public init(
        array: [CGFloat] = [CGFloat](),
        arraySize: Int = 100,
        arrayMaxElement: Int = 500,
        algorithm: QuickSortAlgorithm
    ) {
        self.array = array
        self.arraySize = arraySize
        self.arrayMaxElement = arrayMaxElement
        self.array = ArrayGenerator.generateArrayWith(size: arraySize, maxElement: arrayMaxElement)
        self.outputArray = array
        self.algorithm = algorithm
        DispatchQueue.main.async {
            self.outputArray = self.array
        }
    }
    
    public func start() {
        guard self.array != self.array.sorted() else {
            return
        }
        self.isRunning = true
        workItem = .init(block: { [unowned self] in
            algorithm.quickSort(&self.array) { [unowned self] leftidx, rightIdx in
                self.leftIndex = leftidx
                self.rightIndex = rightIdx
                DispatchQueue.main.async {
                    self.outputArray = self.array
                }

                _ = self.workItem?.wait(timeout: .now() + .milliseconds(3))
            }
            assert(self.array == self.array.sorted(), "The array is not sorted")
            self.leftIndex = 0
            for i in 0...self.arraySize {
                self.rightIndex = i
                self.outputArray = self.array
                _ = self.workItem?.wait(timeout: .now() + .milliseconds(3))
            }
            self.isRunning = false
            self.leftIndex = nil
            self.rightIndex = nil
        })
        workItem.map(workQueue.async(execute:))
    }
}
