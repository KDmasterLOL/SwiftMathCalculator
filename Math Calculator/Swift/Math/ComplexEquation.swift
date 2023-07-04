////
////  ComplexEquation.swift
////  Math Calculator
////
////  Created by Ivan on 01.01.2023.
////
//
//import SwiftUI
//import Foundation
//
//struct Sign {
//    var description: Character
//    var precedence: Int {
//        return Sign.signPrecedence[description]!
//    }
//    var pos: Int
//    static var signPrecedence: [Character:Int] = [
//        "+": 10,
//        "-": 10,
//        "*": 20,
//        "/": 20,
//    ]
//}
//struct ComplexEquation {
//    var equation: String
//    var equationArray: [Character] {
//        get{
//            return Array(equation)
//        }
//    }
//    var dict: [Unicode.Scalar: any Expression]
//    
//    var operation: [String] = []
//    
//    private var matrixId = 0
//    private var numberId = 0
//    
//    init(){
//        self.equation = ""
//        dict = [:]
//    }
//    
//    init(equation: String, dict: [Unicode.Scalar : any Expression]) {
//        self.equation = equation
//        self.dict = dict
//    }
//    
//    mutating func AddVariable(_ exp: any Expression){
//        let name = getFreeName()
//        dict[name] = exp
//    }
//    func getFreeName() -> Unicode.Scalar {
//        for char in Unicode.Scalar("A").value...UnicodeScalar("Z").value {
//            if let name = Unicode.Scalar(char) {
//                if dict[name] == nil {
//                    return name
//                }
//            }
//        }
//        return "0"
//    }
//    @ViewBuilder func parse() -> some View{
//        ForEach(equationArray, id: \.hashValue) { char in
//            Text(String(char))
//        }
//    }
//    enum Token {
//        case constant(Float)
//        case variable(String)
//    }
//    func compute() -> any Expression {
//        var result: any Expression = Float(0.0)
//        var sign = "+"
//        for (i, el) in equation.enumerated() {
//            if el.isNumber {
//                let countNumbers = equation.countNextCharacters(after: i) { c in
//                    c.isNumber
//                }
//            }
//        }
//        return result
//    }
//    private func nextLetter(_ letter: Unicode.Scalar) -> Unicode.Scalar {
//        switch letter {
//        case "A" ..< "Z", "a"..<"z":
//            return Unicode.Scalar(letter.value + 1)!
//        default:
//            return "0"
//        }
//    }
//    
////    static func *(lhs: ComplexEquation, rhs: ComplexEquation) -> ComplexEquation {
////        return standardEquationStrWithSign("*", lhs: lhs, rhs: rhs)
////    }
////
////    static func +(lhs: ComplexEquation, rhs: ComplexEquation) -> ComplexEquation {
////        return standardEquationStrWithSign("+", lhs: lhs, rhs: rhs)
////    }
////
////    static func standardEquationStrWithSign(_ sign: String, lhs: ComplexEquation, rhs: ComplexEquation) -> ComplexEquation {
////        var newDict = lhs.dict
////        newDict.merge(rhs.dict) {(current, _) in current}
////
////        return ComplexEquation(equation: "(\(lhs.equation) \(sign) \(rhs.equation)", dict: newDict)
////    }
//}
//
////extension String {
////    func countNextCharacters(after: Int, condition: (Character)->Bool) -> Int{
////        return countNextCharacters(after: self.indexOf(after), condition: condition)
////    }
////    func countNextCharacters(after: String.Index, condition: (Character) -> Bool) -> Int{
////        var count = 0
////        for c in self[after...] {
////            if condition(c) == false {
////                break
////            }
////            count += 1
////        }
////        return count
////    }
////    private func indexOf(_ index: Int) -> String.Index {
////        return self.index(self.startIndex, offsetBy: index)
////    }
////    func range(_ start: Int, _ end: Int) -> Substring {
////        return range(self.indexOf(start), self.indexOf(end))
////    }
////    func range(_ start: String.Index, _ end: String.Index) -> Substring {
////        return self[start...end]
////    }
////}
