//
//  Math.swift
//  MathCalculator
//
//  Created by Ivan on 20.12.2022.
//

import Foundation
import SwiftUI



struct Vector{
    var content: [Float] = []
    
    init(_ content: [Float]) {
        self.content = content
    }
    
    var size: Int { get {return content.count} }
    
    static func *(lhs: Vector, rhs: Vector) -> Float {
        var result: Float = 0
        for i in lhs.content.indices {
            result += lhs[i] * rhs[i]
        }
        return result
    }
    subscript(index: Int) -> Float {
        return content[index]
    }
    func sameSize(another: Vector) -> Bool {
        return size == another.size
    }
    
}

//protocol Expression {
//    static func *(self: Self, rhs: any Expression) -> any Expression
//    static func /(self: Self, rhs: any Expression) -> any Expression
//    static func +(self: Self, rhs: any Expression) -> any Expression
//    static func -(self: Self, rhs: any Expression) -> any Expression
//}
//extension Expression {
//    func mul(rhs: any Expression) -> any Expression {
//        switch self {
//        case let num as Float:
//            return num*rhs
//        case let mat as Matrix:
//            return mat*rhs
//        case _:
//            return self
//        }
//    }
//    func div(rhs: any Expression) -> any Expression {
//        switch self {
//        case let num as Float:
//            return num/rhs
//        case let mat as Matrix:
//            return mat/rhs
//        case _:
//            return self
//        }
//    }
//    func plus(rhs: any Expression) -> any Expression {
//        switch self {
//        case let num as Float:
//            return num+rhs
//        case let mat as Matrix:
//            return mat+rhs
//        case _:
//            return self
//        }
//    }
//    func minus(rhs: any Expression) -> any Expression {
//        switch self {
//        case let num as Float:
//            return num-rhs
//        case let mat as Matrix:
//            return mat-rhs
//        case _:
//            return self
//        }
//    }
//}
//extension Float: Expression{
//    static func * (self: Self, rhs: any Expression) -> any Expression {
//        if let num = rhs as? Float {
//            return num*self
//        }
//        else if let matrix = rhs as? Matrix {
//            return matrix*self
//        }
//        else {
//            return self
//        }
//    }
//}
