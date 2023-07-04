////
////  EquationView.swift
////  Math Calculator
////
////  Created by Ivan on 26.01.2023.
////
//
//import SwiftUI
//
//struct EquationView: View {
//    var equation: Equation
//    var body: some View {
//        ForEach(equation.tokens, id: \.self){ token in
//            switch token {
//            case .constant(let val):
//                Text(String(val))
//            case _:
//                Text(" ")
////            case .variable(let val):
//////                Text(String(val))
////            case .oper(let val):
//////                Text(String(val))
//            }
//        }
//    }
//}
//
//struct EquationView_Previews: PreviewProvider {
//    static var previews: some View {
//        EquationView(equation: Equation(equation: "3+4+5"))
//    }
//}
