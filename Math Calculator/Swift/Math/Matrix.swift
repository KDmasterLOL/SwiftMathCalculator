//
//  Matrix.swift
//  MathCalculator
//
//  Created by Ivan on 25.12.2022.
//

import Foundation
import SwiftUI
struct Matrix {
    public struct posElement : Hashable, AdditiveArithmetic, Comparable {
        
        public static var zero: Matrix.posElement = posElement(0,0)
        
        public static func + (lhs: Matrix.posElement, rhs: Matrix.posElement) -> Matrix.posElement {
            var newPos = lhs
            newPos.col+=rhs.col
            newPos.row+=rhs.row
            return newPos
        }
        
        public static func - (lhs: Matrix.posElement, rhs: Matrix.posElement) -> Matrix.posElement {
            var newPos = lhs
            newPos.col-=rhs.col
            newPos.row-=rhs.row
            return newPos
        }
        
        static func -(pos: posElement, scalar: Int) -> posElement {
            var newPos = pos
            newPos.col-=scalar
            newPos.row-=scalar
            return newPos
        }
        static func -=(pos: inout posElement, scalar: Int){
            pos = pos - scalar
        }
        
        public static func < (lhs: Matrix.posElement, rhs: Matrix.posElement) -> Bool {
            if lhs.row < rhs.row {
                return true
            }
            else if lhs.row == rhs.row {
                return lhs.col < rhs.col
            }
            else {
                return false
            }
        }
        
        var row: Int, col: Int
        init(_ row: Int = 0, _ col: Int = 0) {
            self.row = row
            self.col = col
        }
    }
    public func repairPos(_ pos: inout posElement){
        pos.row.range(end: countRows-1)
        pos.col.range(end: countCols-1)
    }
    
    public struct Iterator: Sequence, IteratorProtocol {
        public typealias Element = posElement
        var current: Element = Element(0,-1)
        var end: Element
        init(_ matrix: Matrix) {
            end = Element(matrix.countRows, matrix.countCols)
        }
        public mutating func next() -> Element? {
            current.col+=1
            if current.col == end.col {
                current.row+=1
                if current.row == end.row {
                    return nil
                }
                current.col=0
            }
            return current
                
        }
    }
    
    var content: [[Float]]
    
    public var isSquare: Bool {
        get {
            return countCols == countRows
        }
        set {
            if newValue == true && isSquare == false {
                toSquare()
            }
        }
    }
    public var countRows: Int{
        get {
            return content.count
        }
        set {
            changeSize(row: newValue - countRows)
        }
    }
    public var countCols: Int{
        get {
            return content[0].count
        }
        set {
            changeSize(col: newValue - countCols)
        }
    }
    
    public func elementIsExist(_ pos: posElement) -> Bool {
        if (pos.row < 0 || pos.col < 0) || (pos.row > countRows-1 || pos.col > countCols-1){
            return false
        }
        return true
    }
    
    init(row: Int = 3, col: Int = 3, value: Float = 0) {
        self.content = Array(repeating: Array(repeating: value, count: col), count: row)
        self.content.reserveCapacity(100)
    }
    init(_ matrix: Matrix) {
        self.content = matrix.content
    }
    
    subscript(row: Int, column: Int) -> Float {
        get {
            return content[row][column]
        }
        set(newValue) {
            content[row][column] = newValue
        }
    }
    subscript(pos: posElement) -> Float {
        get {
            return self[pos.row, pos.col]
        }
        set(newValue) {
            self[pos.row, pos.col] = newValue
        }
    }
    
    public mutating func clear() {
        for row in content.indices {
            for col in content[0].indices {
                content[row][col] = 0
            }
        }
    }
    private mutating func toSquare() {
        let diff = countRows - countCols
        
        if diff < 0 {
            changeSize(row: abs(diff))
        }
        else {
            changeSize(col: diff)
        }
    }
    private mutating func changeSize(row: Int = 0, col: Int = 0){
        if col > 0 {
            for rowIndex in content.indices{
                content[rowIndex].append(contentsOf: Array(repeating: 0, count: col))
            }
        }
        else if col < 0 && countCols != 1 {
            for rowIndex in content.indices{
                content[rowIndex].removeLast(abs(col))
            }
        }
        if row > 0 {
            content.append(contentsOf: Array(repeating: Array(repeating: 0, count: countCols), count: row))
        }
        else if row < 0 && countRows != 1{
            content.removeLast(abs(row))
        }
    }
}

extension Matrix: Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
    static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.content == rhs.content
    }
}

// Help
extension Matrix {
}

// Operations
extension Matrix {
    public func minor(_ pass: posElement) -> Matrix {
        var minor = Matrix(row: countRows-1, col: countCols-1)
        var elementPos = posElement(0,0)
        for r in content.indices {
            if r == pass.row {
                continue
            }
            elementPos.col = 0
            for c in content[0].indices {
                if c == pass.col {
                    continue
                }
                minor[elementPos] = self[r,c]
                elementPos.col += 1
            }
            elementPos.row += 1
        }
        return minor
    }
}

// Arithmetic operations
extension Matrix {
    static func /(lhs: Matrix, rhs: Matrix) -> Matrix {
        var result = Matrix(row: lhs.countRows, col: rhs.countCols)
        for row_lhs in lhs.content.indices {
            for pos_r in Iterator(rhs) {
                result[row_lhs, pos_r.col] += lhs[row_lhs,pos_r.row]/rhs[pos_r]
            }
//            for col_rhs in rhs.content[0].indices {
//                for row_rhs in rhs.content.indices {
//                    result.content[row_lhs][col_rhs] += lhs[row_lhs,row_rhs]/rhs[row_rhs,col_rhs]
//                }
//            }
        }
        return result
    }
    
    static func /(lhs: Matrix, rhs: Float) -> Matrix {
        return lhs*pow(rhs,-1)
                    
    }
    
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix{
        var result = Matrix(row: lhs.countRows, col: rhs.countCols)
        for row_lhs in lhs.content.indices {
            for pos_r in Iterator(rhs) {
                result[row_lhs, pos_r.col] += lhs[row_lhs,pos_r.row]*rhs[pos_r]
            }
        }
        return result
    }

    static func *(matrix: Matrix, scalar: Float) -> Matrix{
        var newMatrix = Matrix(matrix)
        for pos in Iterator(matrix) {
            newMatrix[pos] *= scalar
        }
        return newMatrix
    }
    
    static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        var result = Matrix(lhs)
        for i in Iterator(lhs) {
            result[i] += rhs[i]
        }
        return result
    }
    
    static func +(lhs: Matrix, rhs: Float) -> Matrix {
        var result = Matrix(lhs)
        for pos in Iterator(lhs) {
            result[pos] += rhs
        }
        return result
    }
    
    static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        var result = Matrix(lhs)
        for i in Iterator(lhs) {
            result[i] -= rhs[i]
        }
        return result
    }
    
    static func -(lhs: Matrix, rhs: Float) -> Matrix {
        return lhs + (-rhs)
    }
}
