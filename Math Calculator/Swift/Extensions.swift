//
//  Extensions.swift
//  MathCalculator
//
//  Created by Ivan on 25.12.2022.
//

import Foundation
import SwiftUI

extension Int {
    public mutating func range(start: Int = 0, end: Int) {
        if self < start{
            self = end
        }
        else if self > end{
            self = start
        }
    }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }   
}

extension Color {
    static let selectionMatrixElement = Color("SelectionMatrixElement")
}
