//
//  ContentView.swift
//  MathCalculator
//
//  Created by Ivan on 20.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State var input: InputType = .matrix
          
    @State var currentOperation: Operations = .MatrixScalarMultiplying
    let operationMap: [Operations: Operation] = [
        .MatrixScalarMultiplying: MatrixScalarMultiplying(),
        .MatrixMultiplying: MatrixMultiplying(),
        .MinorMatrix : MinorElement(),
    ]

    @StateObject var values = Values()
    
    init() {
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                InputView(input: operationMap[currentOperation]!.inputType, values: values, operation: currentOperation)
                HStack {
                    Picker(selection: $currentOperation, label: EmptyView()){
                        ForEach(Operations.allCases){ operation in
                            Text(operationMap[operation]!.name).tag(operation)
                            
                        }
                    }
                }
                NavigationLink("Compute") {
                    NavigationLazyView(ResultView(resultOperation: operationMap[currentOperation]!.Compute(values: values), copiedMatrix: $values.copiedMatrix, savedMatrices: $values.savedMatices))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                Spacer()
                NavigationLink(destination: SavedMatrix(matrices: $values.savedMatices, copiedMatrix: $values.copiedMatrix)){
                    Text("Saved matrices")
                        .foregroundColor(.mint)
                }
            }
            .padding(.bottom, 10)
        }
        .environmentObject(values)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
