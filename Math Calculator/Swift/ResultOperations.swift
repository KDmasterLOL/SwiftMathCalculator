//
//  ResultOperations.swift
//  Math Calculator
//
//  Created by Ivan on 31.12.2022.
//

import Foundation

protocol ResultOperation: Equatable, Hashable {
    var id: Int { get }
}
extension Matrix : ResultOperation {
    var id: Int {
        get { self.hashValue }
    }
}
extension Float : ResultOperation {
    var id: Int {
        get { self.hashValue }
    }
}
struct OperationData: ResultOperation {
    func hash(into hasher: inout Hasher) {
        hasher.combine(lhs)
        hasher.combine(sign)
        hasher.combine(rhs)
    }
    
    static func == (lhs: OperationData, rhs: OperationData) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int = UUID().hashValue
    
    var lhs: any ResultOperation
    var rhs: any ResultOperation
    
    var sign: String
}
