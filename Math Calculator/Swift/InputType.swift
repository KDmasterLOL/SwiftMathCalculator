//
//  InputViews.swift
//  MathCalculator
//
//  Created by Ivan on 24.12.2022.
//

import Foundation
import SwiftUI

enum InputType{
    case scalar
    case matrix, secondMatrix, extendedMatrix
    case equation
    case posElement
}

class Values: ObservableObject{
    @Published var matrix = Matrix()
    @Published var secondMatrix = Matrix()
    @Published var extendMatrix = Matrix()
    @Published var copiedMatrix = Matrix()
    @Published var scalar: Float = 0
    @Published var posElement = Matrix.posElement(1,1)
    @Published var savedMatices: [Matrix] = []
}
