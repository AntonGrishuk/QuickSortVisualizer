import SwiftUI

public struct QSortView: View {
    @State var viewModel: QSortOutput
    
    public init(viewModel: QSortOutput) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        GeometryReader(content: { geometry in
            let step = geometry.size.width /
            CGFloat(viewModel.outputArray.count)
            let windowHeight = geometry.size.height
            if !viewModel.outputArray.isEmpty {
                Path({ path in
                    path.move(to: .init(
                        x: CGFloat(0) * step,
                        y: windowHeight
                    ))
                    var height = viewModel.outputArray[0]
                    for i in 0..<viewModel.outputArray.count {
                        
                        path.addLine(to: .init(
                            x: CGFloat(i) * step,
                            y: windowHeight - height
                        ))
                        
                        height = viewModel.outputArray[i]
                        path.addLine(to: .init(
                            x: CGFloat(i) * step,
                            y: windowHeight - height
                        ))
                    }
                    
                    path.addLine(to: .init(
                        x: CGFloat(viewModel.outputArray.count - 1) * step,
                        y: windowHeight
                    ))
                    
                    path.addLine(to: .init(
                        x: CGFloat(0) * step,
                        y: windowHeight
                    ))
                }).fill(
                    Color.red
                )
                
                if let leftIndex = viewModel.leftIndex,
                   let rightIndex = viewModel.rightIndex {
                    
                    Path({ path in
                        path.move(to: .init(
                            x: CGFloat(leftIndex) * step,
                            y: windowHeight
                        ))
                        var height = viewModel.outputArray[leftIndex]
                        for i in leftIndex...rightIndex {
                            
                            path.addLine(to: .init(
                                x: CGFloat(i) * step,
                                y: windowHeight - height
                            ))
                            
                            height = viewModel.outputArray[i]
                            
                            path.addLine(to: .init(
                                x: CGFloat(i) * step,
                                y: windowHeight - height
                            ))
                        }
                        
                        path.addLine(to: .init(
                            x: CGFloat(rightIndex) * step,
                            y: windowHeight
                        ))
                        
                        path.addLine(to: .init(
                            x: CGFloat(leftIndex) * step,
                            y: windowHeight
                        ))
                    })
                    .fill(
                        Color.green
                    )
                }
            }
        })
    }
}

#Preview {
    QSortView(viewModel: QSortViewModel(
        array: [],
        arraySize: 30,
        arrayMaxElement: 30,
        algorithm: .init()
    ))
}
