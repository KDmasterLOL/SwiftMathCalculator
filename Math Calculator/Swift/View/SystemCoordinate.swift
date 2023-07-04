//
//  SystemCoordinate.swift
//  Math Calculator
//
//  Created by Ivan on 23.01.2023.
//

import SwiftUI
import SpriteKit
import Foundation

class CoordinateScene: SKScene {
    let sizeCell: CGFloat = 500
    let space: CGFloat = 25

    override func sceneDidLoad() {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let camera = SKCameraNode()
        camera.position = CGPoint(x: 0, y: 0)
        self.addChild(camera)
        self.camera = camera

        drawCell()
    }

    func drawCell() {
        for x in stride(from: -sizeCell, to: sizeCell+1, by: space){
            self.drawLine(from: CGPoint(x: x, y: -sizeCell), to: CGPoint(x: x, y: sizeCell), width: 1)
            addLabel(position: CGPoint(x: x, y: -10), text: String(Int(x)), size: 10)
        }
        for y in stride(from: -sizeCell, to: sizeCell+1, by: space){
            self.drawLine(from: CGPoint(x: -sizeCell, y: y), to: CGPoint(x: sizeCell, y: y), width: 1)
            addLabel(position: CGPoint(x: -10, y: y), text: String(Int(y)), size: 10)
        }
        self.drawLine(from: CGPoint(x: 0, y: -sizeCell), to: CGPoint(x: 0, y: sizeCell), width: 3)
        self.drawLine(from: CGPoint(x: -sizeCell, y: 0), to: CGPoint(x: sizeCell, y: 0), width: 3)
    }
    func addLabel(position: CGPoint, text: String, size: CGFloat = 10, fontName: String = "Times New Roman"){
        let label = SKLabelNode(fontNamed: fontName)
        label.text = text
        label.fontSize = size
        label.position = position
        self.addChild(label)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
          return
        }
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        camera!.position -= location - previousLocation
        camera!.position.clamp(min: CGPoint(x: -sizeCell, y: -sizeCell), max: CGPoint(x: sizeCell, y: sizeCell))
      }
}
extension CGPoint {
    static func -=(self: inout CGPoint, another: CGPoint) {
        self.x -= another.x
        self.y -= another.y
    }
    static func -(self: CGPoint, another: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - another.x, y: self.y - another.y)
    }
    mutating func clamp(min: CGPoint, max: CGPoint) {
        self.x = self.x.clamp(min: min.x, max: max.x)
        self.y = self.y.clamp(min: min.y, max: max.y)
    }
}
extension CGFloat {
    func clamp(min: CGFloat, max: CGFloat) -> CGFloat {
        if self < min {
            return min
        }
        else if self > max {
            return max
        }
        return self
    }
}
extension SKScene {
    func drawLine(from start: CGPoint, to end: CGPoint, color: UIColor = .gray, width: CGFloat = 1) {
        let line = SKShapeNode()
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)
        line.path = path
        line.strokeColor = color
        line.lineWidth = width
        self.addChild(line)
    }
}

extension UIImage {
    func toSprite(size: CGSize = CGSize(width: 32, height: 32)) -> SKSpriteNode{
        let data = self.pngData()
        let newImage = UIImage(data:data!)
        let texture = SKTexture(image: newImage!)
        let sprite = SKSpriteNode(texture: texture, size: size)
        return sprite
    }
}

struct SystemCoordinate: View {
    let scene: SKScene
    init(){
        let size = CGSize(width: 270, height: 480)
        scene = CoordinateScene(size: size)
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

struct SystemCoordinate_Previews: PreviewProvider {
    static var previews: some View {
        SystemCoordinate()
    }
}
