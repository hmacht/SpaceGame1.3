//
//  LevelMenuScene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/18/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class LevelMenuScene: SKScene {
    var menuManager: MenuManager?
    
    override func didMove(to view: SKView) {
        let level1Btn = SKLabelNode(text: "Level 1")
        level1Btn.position = CGPoint.zero
        level1Btn.name = "1"
        self.addChild(level1Btn)
        
        let level2Btn = SKLabelNode(text: "Level 2")
        level2Btn.position = CGPoint(x: 0, y: level1Btn.position.y - 75)
        level2Btn.name = "2"
        self.addChild(level2Btn)
        
        let level3Btn = SKLabelNode(text: "Level 3")
        level3Btn.position = CGPoint(x: 0, y: level2Btn.position.y - 75)
        level3Btn.name = "3"
        self.addChild(level3Btn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if name == "1"{
                self.menuManager?.didPressEndless(level: 1)
            } else if name == "2" {
                self.menuManager?.didPressEndless(level: 2)
            } else if name == "3" {
                self.menuManager?.didPressEndless(level: 3)
            }
        }
    }
}
