//
//  InputView.swift
//  MathCalculator
//
//  Created by Ivan on 26.12.2022.
//

import SwiftUI

struct InputView: View {
    var input: [InputType]
    @ObservedObject var values: Values
    var operation: Operations
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    var body: some View {
        VStack{
            if input.contains(.secondMatrix) {
                matrices
            }
            else if input.contains(.matrix) {
                matrix
            }
            
            if input.contains(.scalar) != false {
                scalar
            }
            
            if input.contains(.posElement) != false {
                posElement
            }
        }
    }
    
    @ViewBuilder var matrix: some View {
        if input.contains(.posElement) {
            MatrixView($values.matrix, copiedMatrix: $values.copiedMatrix, savedMatrices: $values.savedMatices,  edit: true, selection: $values.posElement)
        }
        else {
            MatrixView($values.matrix, copiedMatrix: $values.copiedMatrix, savedMatrices: $values.savedMatices, edit: true)
        }
    }
    @ViewBuilder var matrices: some View {
        TabView {
            matrix
                .tabItem{
                    Label("First", systemImage: "tray.and.arrow.down.fill")
                }
            MatrixView($values.secondMatrix, copiedMatrix: $values.copiedMatrix, savedMatrices: $values.savedMatices, edit: true)
                .tabItem{
                    Label("Second", systemImage: "tray.and.arrow.down.fill")
                }
        }
    }
    @ViewBuilder var scalar: some View {
        HStack{
            Text("Input scalar:")
                .fontWeight(.heavy)
                .foregroundColor(.blue)
                .font(.headline)
            TextField("0", value: $values.scalar, formatter: formatter)
                .fixedSize()
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
                .autocorrectionDisabled()
        }
    }
    
    @ViewBuilder var posElement: some View {
        HStack{
                Picker("Row:", selection: $values.posElement.row){
                    ForEach(0..<values.matrix.countRows, id: \.self){ num in
                        Text("\(num)")
                    }
                    
                }
                .pickerStyle(.wheel)
                .frame(width: 40, height: 100)
            
                Picker("Col:", selection: $values.posElement.col){
                    ForEach(0..<values.matrix.countCols, id: \.self){ num in
                        Text("\(num)")
                    }

                }
                .pickerStyle(.wheel)
                .frame(width: 40, height: 100)
        }
        .autocorrectionDisabled()
        .fixedSize()
        .textFieldStyle(.roundedBorder)
        .onChange(of: values.posElement) { newValue in
            if values.matrix.elementIsExist(newValue - 1) == false{
                values.matrix.repairPos(&values.posElement)
            }
        }
        .keyboardType(.numbersAndPunctuation)
    }
    
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(input: [.matrix, .scalar], values: Values(), operation: .MatrixMultiplying)
    }
}
