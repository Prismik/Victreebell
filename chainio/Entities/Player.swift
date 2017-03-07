//
//  Player.swift
//  chainio
//
//  Created by Francis Beauchamp on 2017-03-06.
//  Copyright © 2017 Francis Beauchamp. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    private(set) var isSelected: Bool = false
    private(set) var pullForce: CGFloat = 0
    init() {
        let texture = SKTexture(imageNamed: "Spaceship")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 25, height: 25) /*texture.size()*/)
        self.zRotation = -CGFloat.pi / 2
        self.isUserInteractionEnabled = true
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5) // Center the anchor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isSelected {
            self.isSelected = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.isSelected {
            guard let touch = touches.first else {
                return
            }
            
            let touchLocation: CGPoint = touch.location(in: self.parent!)
            self.pullForce = abs(self.position.y - touchLocation.y)
            if self.pullForce > 25 {
                self.position = CGPoint(x: self.position.x, y: touchLocation.y)
                self.isSelected = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isSelected = false
    }
}