//
//  MatrixView.swift
//  MathCalculator
//
//  Created by Ivan on 20.12.2022.
//

import SwiftUI

struct MatrixView: View {
    
    @Binding var matrix: Matrix
    @State var edit: Bool = false
    @Binding var selection: Matrix.posElement
    
    var copiedMatrix: Binding<Matrix>? = nil
    var savedMatrices: Binding<[Matrix]>? = nil
    
    @FocusState private var focusState: Matrix.posElement?
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.zeroSymbol = ""
        formatter.groupingSeparator = ""
        return formatter
    }()
    
    init(_ matrix: Binding<Matrix>, copiedMatrix: Binding<Matrix>? = nil, savedMatrices: Binding<[Matrix]>? = nil, edit: Bool = false, selection: Binding<Matrix.posElement>? = nil) {
        self._matrix = matrix
        if let copiedMatrix {
            self.copiedMatrix = copiedMatrix
        }
        if let savedMatrices {
            self.savedMatrices = savedMatrices
        }
        self.edit = edit
        self._selection = selection ?? .constant(Matrix.posElement(-1,-1))
        self.focusState = nil
    }
    init(_ matrix: Binding<Matrix>) {
        self._matrix = matrix
        if let copiedMatrix {
            self.copiedMatrix = copiedMatrix
        }
        if let savedMatrices {
            self.savedMatrices = savedMatrices
        }
        self.edit = false
        self._selection = .constant(Matrix.posElement(-1,-1))
        self.focusState = nil
    }
    
    
    @ViewBuilder private var matrixView: some View {
        elementsView
            .contextMenu{
                if let copiedMatrix {
                    Button("Copy") {
                        copiedMatrix.wrappedValue = matrix
                    }
                    Button("Paste") {
                        matrix = copiedMatrix.wrappedValue
                    }
                }
                if let savedMatrices {
                    Button("Save") {
                        savedMatrices.wrappedValue.append(matrix)
                    }
                }
            }
    }
    @ViewBuilder private var buttons: some View {
        VStack {
            if let copiedMatrix {
                HStack {
                    Button("Copy") {
                        copiedMatrix.wrappedValue = matrix
                    }
                    .cornerRadius(40)
                    .shadow(color: .primary.opacity(0.5), radius: 10)
                    
                    Spacer()
                        .frame(width: 30)
                    Button("Paste") {
                        matrix = copiedMatrix.wrappedValue
                    }
                    .foregroundColor(.red)
                    .cornerRadius(40)
                    .shadow(color: .primary.opacity(0.5), radius: 10)
                }
                .font(.headline)
                .padding(.top, 10)
            }
            if let savedMatrices {
                Button("Save") {
                    savedMatrices.wrappedValue.append(matrix)
                }
                .cornerRadius(40)
                .shadow(color: .primary.opacity(0.5), radius: 10)
            }
        }
    }
    @ViewBuilder private var editView: some View {
        VStack{
            Spacer()
            elementsView
            buttons
            Spacer()
            Text("\(matrix.countRows)X\(matrix.countCols)")
            Toggle(isOn: $matrix.isSquare) {
                Text("Is square")
                    .bold()
                    .foregroundColor(.blue)
            }
            .fixedSize()
            
            HStack{
                Stepper("Rows", value: $matrix.countRows, step: 1)
                Stepper("Cols", value: $matrix.countCols, step: 1)
            }
            .tint(.blue)
            .fixedSize()
            
            Button("Clear") {
                matrix.clear()
            }
            .foregroundColor(.red)
            .bold()
            .font(.headline)
            .padding(.vertical)
        }
        .padding(.all, 20)
    }
    @ViewBuilder private func elementField(_ pos: Matrix.posElement) -> some View {
        if edit {
            TextField("0", value: $matrix[pos], formatter: formatter)
                .keyboardType(.numbersAndPunctuation)
                .focused($focusState, equals: pos)
                .fixedSize()
                .autocorrectionDisabled()
                .background(isSelect(pos) ? Color.selectionMatrixElement : nil)
                .cornerRadius(isSelect(pos) ? 10 : 0)
        }
        else {
            Text("\(matrix[pos].clean)")
        }
    }
    
    @ViewBuilder private var elementsView: some View {
        Grid{
            ForEach(matrix.content.indices, id: \.self) { row in
                GridRow {
                    ForEach(matrix.content[row].indices, id: \.self) { col in
                        elementField(Matrix.posElement(row, col))
                    }
                }
            }
        }
        .toolbar{
            if focusState != nil {
                ToolbarItemGroup(placement: .keyboard){
                    HStack{
                        Button {
                            setNextFocus(nextPos: .Prev)
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                        Button{
                            setNextFocus(nextPos: .Up)
                        } label: {
                            Image(systemName: "arrow.up")
                        }
                        Button{
                            setNextFocus(nextPos: .Down)
                        } label: {
                            Image(systemName: "arrow.down")
                        }
                        Spacer()
                        Button{
                            setNextFocus(nextPos: .Next)
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                        Spacer()
                        Button("Clear") {
                            if let pos = focusState {
                                self.matrix.content[pos.row][pos.col] = 0
                            }
                        }
                        .foregroundColor(.red)
                        Button("Done"){
                            focusState = nil
                        }
                        .foregroundColor(.green)
                    }
                }
                
                
            }
        }
    }
    
    var body: some View {
        if edit {
            editView
        }
        else {
            matrixView
        }
    }
    
    enum NextElementPos {
        case Next, Prev
        case Up, Down
    }
    func setNextFocus(nextPos: NextElementPos) {
        if var pos = focusState {
            switch nextPos{
            case .Next:
                pos.col += 1
            case .Prev:
                pos.col -= 1
            case .Down:
                pos.row += 1
            case .Up:
                pos.row -= 1
            }
            matrix.repairPos(&pos)
            focusState = pos
        }
    }
    private func isSelect(_ pos: Matrix.posElement) -> Bool {
        return pos.row == selection.row || pos.col == selection.col
        //        var isHas = false
//        selection.forEach { position in
//            if position.row == pos.row || position.col == pos.col {
//                isHas = true
//                return
//            }
//        }
//        return isHas
    }
}

struct MatrixView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            MatrixView(.constant(Matrix()), copiedMatrix: .constant(Matrix()), savedMatrices: .constant([Matrix()]), edit: true, selection: .constant(Matrix.posElement(1,1)))
            MatrixView(.constant(Matrix()), copiedMatrix: .constant(Matrix()), savedMatrices: .constant([Matrix()]), edit: true, selection: .constant(Matrix.posElement(1,1)))
                .preferredColorScheme(.dark)
        }
    }
}


//struct MatrixView: View {
//
//    @Binding var matrix: Matrix
//    @State var type: TypeMatrix = .matrix
//    @State var edit: Bool = false
//    @Binding var selection: Matrix.posElement
//
//    @Binding var copiedMatrix: Matrix
//    @Binding var savedMatrices: [Matrix]
//
//    @FocusState private var focusState: Matrix.posElement?
//
//    @State private var height: CGFloat
//
//    private let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.zeroSymbol = ""
//        formatter.groupingSeparator = ""
//        return formatter
//    }()
//
//    init(_ matrix: Binding<Matrix>, copiedMatrix: Binding<Matrix>, savedMatrices: Binding<[Matrix]>, type: TypeMatrix = .matrix, edit: Bool = false, selection: Binding<Matrix.posElement>? = nil) {
//        self._matrix = matrix
//        self._copiedMatrix = copiedMatrix
//        self._savedMatrices = savedMatrices
//        self.type = type
//        self.edit = edit
//        self._selection = selection ?? .constant(Matrix.posElement(-1,-1))
//        self.height = 10
//        self.focusState = nil
//    }
//    init(_ matrix: Binding<Matrix>, type: TypeMatrix = .matrix) {
//        self._matrix = matrix
//        self._copiedMatrix = .constant(Matrix())
//        self._savedMatrices = .constant([])
//        self.type = type
//        self.edit = false
//        self._selection = .constant(Matrix.posElement(-1,-1))
//        self.height = 10
//        self.focusState = nil
//    }
//
//    enum TypeMatrix {
//        case matrix
//        case determinator
//        case raw
//    }
//
//    private func getMatrixStr(_ left: Bool) -> String{
//
//        if type == .raw {
//            return ""
//        }
//        else if type == .determinator {
//            return "|"
//        }
//
//        if left{
//            switch type {
//            case .matrix:
//                return "("
//            default:
//                return ""
//            }
//        }
//        else {
//            switch type {
//            case .matrix:
//                return ")"
//            default:
//                return ""
//            }
//        }
//    }
//
//    @ViewBuilder private func matrixParentheses(_ left: Bool) -> some View{
//            Text(getMatrixStr(left))
//                .font(.system(size: height))
//                .frame(height: height)
//                .fontWeight(.ultraLight)
//                .minimumScaleFactor(0.01)
//                .foregroundColor(.gray)
//    }
//
//    @ViewBuilder private var matrixView: some View {
//        VStack{
//            HStack{
//                matrixParentheses(true)
//                elementsView.readSize { h in
//                    height = h.height
//                }
//                matrixParentheses(false)
//            }
//            .fixedSize()
//        }
//    }
//    @ViewBuilder private var editView: some View {
//        VStack{
//            Spacer()
//            VStack {
//                HStack {
//                    matrixParentheses(true)
//                    elementsView.readSize { h in
//                        height = h.height
//                    }
//                    matrixParentheses(false)
//                }
//                VStack {
//                    HStack {
//                        Button("Copy") {
//                            copiedMatrix = matrix
//                        }
//                        .cornerRadius(40)
//                        .shadow(color: .primary.opacity(0.5), radius: 10)
//                        Spacer()
//                            .frame(width: 30)
//                        Button("Paste") {
//                            matrix = copiedMatrix
//                        }
//                        .foregroundColor(.red)
//                        .cornerRadius(40)
//                        .shadow(color: .primary.opacity(0.5), radius: 10)
//                    }
//                    .font(.headline)
//                    .padding(.top, 10)
//                    Button("Save") {
//                        savedMatrices.append(matrix)
//                    }
//                    .cornerRadius(40)
//                    .shadow(color: .primary.opacity(0.5), radius: 10)
//                }
//            }
//            Spacer()
//            Text("\(matrix.countRows)X\(matrix.countCols)")
//            Toggle(isOn: $matrix.isSquare) {
//                Text("Is square")
//                    .bold()
//                    .foregroundColor(.blue)
//            }
//            .fixedSize()
//
//            HStack{
//                Stepper("Rows", value: $matrix.countRows, step: 1)
//                Stepper("Cols", value: $matrix.countCols, step: 1)
//            }
//            .tint(.blue)
//            .fixedSize()
//
//            Button("Clear") {
//                matrix.clear()
//            }
//            .foregroundColor(.red)
//            .bold()
//            .font(.headline)
//            .padding(.vertical)
//        }
//        .padding(.all, 20)
//    }
//
//    @ViewBuilder private func elementField(_ pos: Matrix.posElement) -> some View {
//        if edit {
//            TextField("0", value: $matrix.content[pos.row][pos.col], formatter: formatter)
//                .keyboardType(.numbersAndPunctuation)
//                .focused($focusState, equals: pos)
//                .fixedSize()
//                .autocorrectionDisabled()
//        }
//        else {
//            Text("\(matrix[pos].clean)")
//        }
//    }
//    @ViewBuilder private func elementFieldFinal(_ pos: Matrix.posElement) -> some View {
//        if isSelect(pos) {
//            elementField(pos)
//                .background(Color.selectionMatrixElement)
//                .cornerRadius(10)
//        }
//        else {
//            elementField(pos)
//        }
//    }
//
//    @ViewBuilder private var elementsView: some View {
//        Grid{
//            ForEach(matrix.content.indices, id: \.self) { row in
//                GridRow {
//                    ForEach(matrix.content[row].indices, id: \.self) { col in
//                        elementFieldFinal(Matrix.posElement(row, col))
//                    }
//                }
//            }
//        }
//        .toolbar{
//            if focusState != nil {
//                ToolbarItemGroup(placement: .keyboard){
//                    HStack{
//                        Button {
//                            setNextFocus(nextPos: .Prev)
//                        } label: {
//                            Image(systemName: "arrow.left")
//                        }
//                        Spacer()
//                        Button{
//                            setNextFocus(nextPos: .Up)
//                        } label: {
//                            Image(systemName: "arrow.up")
//                        }
//                        Button{
//                            setNextFocus(nextPos: .Down)
//                        } label: {
//                            Image(systemName: "arrow.down")
//                        }
//                        Spacer()
//                        Button{
//                            setNextFocus(nextPos: .Next)
//                        } label: {
//                            Image(systemName: "arrow.right")
//                        }
//                        Spacer()
//                        Button("Clear") {
//                            if let pos = focusState {
//                                self.matrix.content[pos.row][pos.col] = 0
//                            }
//                        }
//                        .foregroundColor(.red)
//                        Button("Done"){
//                            focusState = nil
//                        }
//                        .foregroundColor(.green)
//                    }
//                }
//
//
//            }
//        }
//    }
//
//    var body: some View {
//        if edit {
//            editView
//        }
//        else {
//            matrixView
//        }
//    }
//
//    enum NextElementPos {
//        case Next, Prev
//        case Up, Down
//    }
//    func setNextFocus(nextPos: NextElementPos) {
//        if var pos = focusState {
//            switch nextPos{
//            case .Next:
//                pos.col += 1
//            case .Prev:
//                pos.col -= 1
//            case .Down:
//                pos.row += 1
//            case .Up:
//                pos.row -= 1
//            }
//            matrix.repairPos(&pos)
//            focusState = pos
//        }
//    }
//    private func isSelect(_ pos: Matrix.posElement) -> Bool {
//        return pos.row == selection.row || pos.col == selection.col
//        //        var isHas = false
////        selection.forEach { position in
////            if position.row == pos.row || position.col == pos.col {
////                isHas = true
////                return
////            }
////        }
////        return isHas
//    }
//}
//
//struct MatrixView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group{
//            MatrixView(.constant(Matrix()), copiedMatrix: .constant(Matrix()), savedMatrices: .constant([Matrix()]), edit: true, selection: .constant(Matrix.posElement(1,1)))
//            MatrixView(.constant(Matrix()), copiedMatrix: .constant(Matrix()), savedMatrices: .constant([Matrix()]), edit: true, selection: .constant(Matrix.posElement(1,1)))
//                .preferredColorScheme(.dark)
//        }
//    }
//}
//
//
