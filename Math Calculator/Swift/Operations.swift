//
//  Operations.swift
//  MathCalculator
//
//  Created by Ivan on 25.12.2022.
//

import Foundation

enum Operations: String, Equatable, Identifiable, CaseIterable{
    case MatrixScalarMultiplying
    case MatrixMultiplying
    case MinorMatrix
    var id: String  {self.rawValue}
}

protocol Operation {
    var name: String { get }
    var inputType: [InputType] { get }
    
    func Compute(values: Values) -> [any ResultOperation]
}

struct MatrixScalarMultiplying: Operation {
    public var name: String = "Matrix multiplied by scalar"
    public var inputType: [InputType] = [.scalar, .matrix]
    
    public func Compute(values: Values) -> [any ResultOperation]{
        return [OperationData(lhs: values.matrix, rhs: values.scalar, sign: "*"), values.matrix * values.scalar]
    }
}

struct MatrixMultiplying: Operation {
    var name: String = "Matrix multiply by matrix"
    
    var inputType: [InputType] = [.matrix, .secondMatrix]
    
    func Compute(values: Values) -> [any ResultOperation] {
        return [OperationData(lhs: values.matrix, rhs: values.secondMatrix, sign: "*"), values.matrix * values.secondMatrix]
    }
}
//class FindDeterminant: Operation {
//    var name: String = "Find matrix determinant"
//
//    var inputType: [InputType] = [.matrix]
//
//    func Compute(values: Values) -> [any ResultOperation] {
//        if values.matrix.isSquare {
//
//        }
//    }
//
//
//}

struct MinorElement: Operation {
    var name: String = "Get minor of element"
    
    var inputType: [InputType] = [.matrix, .posElement]
    
    func Compute(values: Values) -> [any ResultOperation] {
        return [values.matrix.minor(values.posElement)]
    }
    
    
}
