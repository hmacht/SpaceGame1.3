//
//  TutorialScene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/13/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class TutorialScene: SKScene {
    
    let ship = SKSpriteNode(imageNamed: "myShip")
    var menuManager: MenuManager?
    var countTouches = [Int]()
    
    override func didMove(to view: SKView) {
        self.setupScene()
    }
    
    func setupScene() {
        ship.position = CGPoint(x: 0, y: 0)
        ship.setScale(1.5)
        self.addChild(ship)
        
        let backBtn = SKSpriteNode(imageNamed: "backBtn")
        backBtn.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn.name = "back"
        self.addChild(backBtn)
        
        let titleLabel = SKLabelNode(text: "Tutorial")
        titleLabel.position = CGPoint(x: 0, y: 230)
        titleLabel.fontSize = 50
        titleLabel.fontName = "Bebas Neue"
        titleLabel.fontColor = SKColor(red: 21/255.0, green: 31/255.0, blue: 56/255.0, alpha: 1)
        titleLabel.verticalAlignmentMode = .center
        titleLabel.horizontalAlignmentMode = .center
        self.addChild(titleLabel)
        
        let fingerTap = SKSpriteNode(imageNamed: "FingerTap")
        fingerTap.position = CGPoint(x: self.size.width/4, y: -self.size.height/4)
        fingerTap.alpha = 0
        fingerTap.setScale(0)
        self.addChild(fingerTap)
        
        let fingerTap2 = SKSpriteNode(imageNamed: "FingerTap2")
        fingerTap2.position = CGPoint(x: -self.size.width/4, y: -self.size.height/4)
        fingerTap2.alpha = 0
        fingerTap2.setScale(0)
        self.addChild(fingerTap2)
        
        
        let f1Scale: CGFloat = 0.2
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.55)
        let scaleUp = SKAction.scale(to: 1.3 * f1Scale, duration: 0.5)
        let scaleRegular = SKAction.scale(to: f1Scale, duration: 0.3)
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.3)
        let scaleDown = SKAction.scale(to: 0, duration: 0.3)
        let groupIn = SKAction.group([fadeIn, scaleUp])
        let groupOut = SKAction.group([fadeOut, scaleDown])
        let wait = SKAction.wait(forDuration: 0.5)
        let tap = SKAction.sequence([groupIn, scaleRegular, wait, groupOut])
        
        fingerTap.run(SKAction.repeatForever(SKAction.sequence([tap, SKAction.wait(forDuration: 4), tap, SKAction.wait(forDuration: 1)])))
        
        fingerTap2.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 3), tap, SKAction.wait(forDuration: 1), tap, SKAction.wait(forDuration: 1)])))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "back" {
                self.playSound(s: "click2.mp3", wait: true)
                if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                    scene.scaleMode = .aspectFill
                    self.menuManager?.didReturnToMainMenu(scene: scene)
                    self.scene?.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                }
            }
        }
        
        let location = touch.location(in: self.scene!)
        
        ship.texture = SKTexture(imageNamed: "myShip2")
        ship.size.height = (ship.texture?.size().height)! * ship.xScale
        
        if location.x < 0 {
            ship.run(SKAction.rotate(toAngle: CGFloat(Double.pi / 4), duration: 0.4))
        } else {
            ship.run(SKAction.rotate(toAngle: CGFloat(-Double.pi / 4), duration: 0.4))
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        

        self.countTouches.append((event?.allTouches!.count)!)
        
        if countTouches[countTouches.count - 1] == 2 && ship.action(forKey: "forward") == nil {
            ship.removeAllActions()
            let angle = ship.zRotation
            let radius: Double = 75
            let x = cos(Double.pi/2 + Double(angle)) * radius
            let y = sin(Double.pi/2 + Double(angle)) * radius
            ship.run(SKAction.move(to: CGPoint(x: x, y: y), duration: 0.7), withKey: "forward")
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ship.removeAllActions()
        ship.run(SKAction.rotate(toAngle: 0, duration: 0.3))
        ship.run(SKAction.move(to: CGPoint.zero, duration: 0.3))
        ship.texture = SKTexture(imageNamed: "myShip")
        ship.size.height = (ship.texture?.size().height)! * ship.xScale
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        ship.removeAllActions()
        ship.run(SKAction.rotate(toAngle: 0, duration: 0.3))
        ship.run(SKAction.move(to: CGPoint.zero, duration: 0.3))
        ship.texture = SKTexture(imageNamed: "myShip2")
        ship.size.height = (ship.texture?.size().height)! * ship.xScale
    }
    
    func playSound(s: String, wait: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            self.run(SKAction.playSoundFileNamed(s, waitForCompletion: wait))
        }
    }

}
