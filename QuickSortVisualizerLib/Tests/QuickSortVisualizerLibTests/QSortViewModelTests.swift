//
//  QSortViewModelTests.swift
//  QuickSortVisualizerLib
//
//  Created by Anton Grishuk on 14.01.2025.
//

import XCTest
@testable import QuickSortVisualizerLib

final class QSortViewModelTests: XCTestCase {
    
    private var sut: QSortViewModel!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSortArrayMithMultipleElements() throws {
        makeSut(array: [], arraySize: 100, arrayMaxElement: 100)
        sut.start()
        
        let expectation = XCTestExpectation(description: "Finished")

        @Sendable func observe() {
            withObservationTracking {
                if sut.isRunning == false {
                    expectation.fulfill()
                }
            } onChange: {
                DispatchQueue.main.async(execute: observe)
            }
        }
        observe()
        
        wait(for: [expectation], timeout: 3)
        
        let arr = sut.outputArray
        let sortedArr = arr.sorted()
        
        XCTAssertEqual(sut.outputArray, sortedArr)
        XCTAssertFalse(sut.outputArray.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func makeSut(array: [CGFloat], arraySize: Int, arrayMaxElement: Int) {
        sut = QSortViewModel(
            array: array,
            arraySize: arraySize,
            arrayMaxElement: arrayMaxElement,
            algorithm: .init()
        )
    }

}
