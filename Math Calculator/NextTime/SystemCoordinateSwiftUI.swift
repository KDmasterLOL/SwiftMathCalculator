////
////  SystemCoordinate.swift
////  Math Calculator
////
////  Created by Ivan on 23.01.2023.
////
//
//import SwiftUI
//import Charts
//
//struct SystemCoordinate: View {
//    let size = 100000
//    let end: Int
//    let start: Int
//    let mid: Int
//    let cellWide: Int
//    @State var currentScale: CGFloat = 1
//    
//    init() {
//        self.end = size
//        self.start = 0
//        self.mid = size/2
//        self.cellWide = 25
//    }
//    
//    var body: some View {
//        ScrollView([.vertical, .horizontal]){
//            ZStack{
////                Rectangle()
////                    .fill(.white)
////                    .frame(width: CGFloat(width), height: CGFloat(height))
//                Path(){ path in
//                    for x in stride(from: start, to: end, by: cellWide) {
//                        path.move(to: CGPoint(x: x, y: start))
//                        path.addLine(to: CGPoint(x: x, y: end))
//                    }
//                    for y in stride(from: start, to: end, by: cellWide) {
//                        path.move(to: CGPoint(x: start, y: y))
//                        path.addLine(to: CGPoint(x: end, y: y))
//                    }
//                }
//                .stroke(.gray, lineWidth: CGFloat(1))
//                .frame(width: CGFloat(size), height: CGFloat(size))
//                Path(){ path in
//                    path.move(to: CGPoint(x: mid, y: start))
//                    path.addLine(to: CGPoint(x: mid, y: end))
//                    path.move(to: CGPoint(x: start, y: mid))
//                    path.addLine(to: CGPoint(x: end, y: mid))
//                }
//                .stroke(.black, lineWidth: CGFloat(2))
//                .frame(width: CGFloat(size), height: CGFloat(size))
//            }
//            .scaleEffect(currentScale)
//            .gesture(MagnificationGesture()
//                .onChanged { newScale in
//                    currentScale = newScale
//                }
//                .onEnded { scale in
//                    
//                })
//            .drawingGroup()
//        }
//        
//    }
//}
//
//struct SystemCoordinate_Previews: PreviewProvider {
//    static var previews: some View {
//        SystemCoordinate()
//    }
//}
