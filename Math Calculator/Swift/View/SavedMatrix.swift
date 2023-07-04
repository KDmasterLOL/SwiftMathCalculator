//
//  SavedMatrix.swift
//  Math Calculator
//
//  Created by Ivan on 25.01.2023.
//

import SwiftUI

struct SavedMatrix: View {
    @Binding var matrices: [Matrix]
    @Binding var copiedMatrix: Matrix
    var body: some View {
        if matrices.isEmpty {
            Text("List saved matrices is empty")
        }
        else {
            List($matrices, id: \.id) { matrix in
                HStack {
                    Spacer()
                    MatrixView(matrix, copiedMatrix: $copiedMatrix)
                    Spacer()
                }
            }
        }
    }
}

struct SavedMatrix_Previews: PreviewProvider {
    static var previews: some View {
        SavedMatrix(matrices: .constant([Matrix(value: 1),Matrix(value: 2)]), copiedMatrix: .constant(Matrix()))
    }
}
