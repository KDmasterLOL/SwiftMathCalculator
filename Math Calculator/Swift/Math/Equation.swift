////
////  Equation.swift
////  Math Calculator
////
////  Created by Ivan on 24.01.2023.
////
//
//import Foundation
//
//protocol Expression{}
//extension Matrix: Expression{}
//extension Float: Expression{}
//struct Equation {
//    
//    enum Token {
//        case variable(Character)
//        case constant(Float)
//        case matrix(Matrix)
//        case oper(Operator)
//        
//        func eval(_ vars: [Character:any Expression]) -> any Expression {
//            switch self {
//            case .constant(let c):
//                return c
//            case .variable(let c):
//                return vars[c]!
//            case _:
//                return Float(0)
//            }
//            
//            func hash(into hasher: inout Hasher) {
//                switch self{
//                case .constant(let val):
//                    hasher.combine(val)
//                case .variable(let val):
//                    hasher.combine(val)
//                case .oper(let val):
//                    hasher.combine(val)
//                case .matrix(let val):
//                    hasher.combine(val)
//                }
//            }
//        }
//    }
//    
//    
//    var equation: String
//    
//    var vars: [Character:any Expression]
//    var tokens: [Token] = []
//    
//    init(equation: String, vars: [Character:any Expression] = [:]) {
//        self.equation = equation
//        self.vars = vars
//        parse()
//    }
//    
//    mutating func parse() {
//        var index = equation.startIndex
//        while index < equation.endIndex {
//            let char = equation[index]
//            var buf: Token? = nil
//            if char.isNumber {
//                let endIndex = equation.endNextCharacters(after: index) { c in
//                    c.isNumber
//                }
//                buf = .constant(Float(equation[index..<endIndex])!)
//                index = equation.index(before: endIndex)
//            }
//            else if char.isOperator {
//                buf = .oper(Operator(char))
//            }
//            else if vars.keys.contains(char) {
//                buf = .variable(char)
//            }
//            
//            
//            if let token = buf {
//                tokens.append(token)
//            }
//            index = equation.index(after: index)
//        }
//    }
//    func compute() -> (any Expression)? {
//        var result: (any Expression)? = nil
//        while tokens.count != 1 {
//            var operat: Operator
//            var operator_invoke: (Operator,Int) = (Operator(),0)
//            for (i,t) in tokens.enumerated() {
//                if case let .oper(oper) = t {
//                    if oper.precedence >  operator_invoke.0.precedence {
//                        operator_invoke = (oper, i)
//                    }
//                }
//            }
//            if case let .oper(oper) = tokens[operator_invoke.1]{
//                var res: Token
//                
//                var lhs = tokens[operator_invoke.1-1].eval(vars)
//                var rhs = tokens[operator_invoke.1+1].eval(vars)
//                
//                switch (lhs,rhs) {
//                case (let l as Float, let r as Float):
//                    res = .constant(oper.invoke(l, r))
//                case (let l as Matrix, let r as Float), (let r as Float, let l as Matrix):
//                    res = .matrix(oper.invoke(l, r))
//                case (let l as Matrix, let r as Matrix):
//                    res = .matrix(oper.invoke(l, r))
//                }
////                var lhs_token = tokens[operator_invoke.1-1]
////                var rhs_token = tokens[operator_invoke.1+1]
//                
////                switch (lhs_token, rhs_token) {
////                case (let .constant(c), let .variable(v)), (let .variable(v), let .constant(c)):
////                    res = .constant( oper.invoke(vars[v] as! Float, c))
////                case (let .constant(f), let .constant(s)):
////                    res = .constant(oper.invoke(f, s))
////                case (let .variable(f), let .variable(s)):
////                    res = oper.invoke(vars[f] as! Float, vars[s] as! Float)
////                case (let .matrix(m), let .variable(v)), (let .variable(v), let .matrix(m)):
////
////                case _:
////                    return Float(-1)
////                }
//                
//            }
//        }
//        return result
//    }
//}
//struct Operator: Hashable {
//    let str: Character
//    init(_ str: Character = "0") {
//        self.str = str
//    }
//    var precedence: Int {
//        switch str {
//        case "+", "-": return 1
//        case "*","/": return 2
//        case _: return 0
//        }
//    }
//    func invoke(_ lhs: Float, _ rhs: Float) -> Float {
//        switch str {
//        case "+": return lhs + rhs
//        case "-": return lhs - rhs
//        case "*": return lhs * rhs
//        case "/": return lhs / rhs
//        case _: return lhs
//        }
//    }
//    func invoke(_ lhs: Matrix, _ rhs: Float) -> Matrix {
//        switch str {
//        case "+": return lhs + rhs
//        case "-": return lhs - rhs
//        case "*": return lhs * rhs
//        case "/": return lhs / rhs
//        case _: return lhs
//        }
//    }
//    func invoke(_ lhs: Matrix, _ rhs: Matrix) -> Matrix {
//        switch str {
//        case "+": return lhs + rhs
//        case "-": return lhs - rhs
//        case "*": return lhs * rhs
//        case "/": return lhs / rhs
//        case _: return lhs
//        }
//    }
//}
//
//extension Character {
//    var isOperator: Bool {
//        return ["+","-","/","*"].contains(self)
//    }
//}
//extension String {
//    func countNextCharacters(after: Int, condition: (Character)->Bool) -> Int{
//        return countNextCharacters(after: self.indexOf(after), condition: condition)
//    }
//    func countNextCharacters(after: String.Index, condition: (Character) -> Bool) -> Int{
//        var count = 0
//        for c in self[after...] {
//            if condition(c) == false {
//                break
//            }
//            count += 1
//        }
//        return count
//    }
//    func endNextCharacters(after: String.Index, condition: (Character) -> Bool) -> String.Index {
//        for i in self[after...].indices {
//            if condition(self[i]) == false {
//                return i
//            }
//        }
//        return self.endIndex
//    }
//    private func indexOf(_ index: Int) -> String.Index {
//        return self.index(self.startIndex, offsetBy: index)
//    }
//    func range(_ start: Int, _ end: Int) -> Substring {
//        return range(self.indexOf(start), self.indexOf(end))
//    }
//    func range(_ start: String.Index, _ end: String.Index) -> Substring {
//        return self[start...end]
//    }
//}
