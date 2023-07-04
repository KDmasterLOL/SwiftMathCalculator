//
//  ResultView.swift
//  MathCalculator
//
//  Created by Ivan on 25.12.2022.
//

import SwiftUI

struct ResultView: View {
    var resultOperation: [any ResultOperation]
    @Binding var copiedMatrix: Matrix
    @Binding var savedMatrices: [Matrix]
    
    var body: some View {
        VStack{
            ForEach(Array(resultOperation.enumerated()), id: \.1.hashValue) { index, result in
                HStack {
                    if let computation = result as? OperationData {
                        HStack {
                            Text(String(index+1)+". ")
                                .foregroundColor(.gray)
                            display(computation.lhs)
                            Text(computation.sign)
                            display(computation.rhs)
                        }
                    }
                    if resultOperation.last?.id == result.id {
                        Text("Result:")
                            .font(.title)
                            .foregroundColor(.purple)
                            .bold()
                    }
                    display(result)
                }
            }
        }
    }
    
    @ViewBuilder private func display(_ result: any ResultOperation) -> some View {
        if let scalar = result as? Float {
            Text("\(scalar.clean)")
        }
        else if let matrix = result as? Matrix {
            MatrixView(.constant(matrix), copiedMatrix: $copiedMatrix, savedMatrices: $savedMatrices)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(resultOperation: [OperationData(lhs: Matrix(), rhs: Matrix(), sign: "*"),Matrix()], copiedMatrix: .constant(Matrix()), savedMatrices: .constant([]))
    }
}
