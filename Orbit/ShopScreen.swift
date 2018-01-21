//
//  shopScreen.swift
//  Orbit
//
//  Created by Henry Macht on 1/20/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class ShopScreen: SKScene {
    var menuManager: MenuManager?
    
    var baseBox = SKSpriteNode()
    var openBox = SKSpriteNode()
    var purchaseBtn = SKSpriteNode()
    
    var boxIsReadyToOpen = false
    
    func shakeCamera(layer:SKSpriteNode, duration:Float) {
        let amplitudeX:Float = 10;
        let amplitudeY:Float = 6;
        let numberOfShakes = duration / 0.04;
        var actionsArray:[SKAction] = [];
        for index in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveBy(x: CGFloat(moveX), y: CGFloat(moveY), duration: 0.02);
            shakeAction.timingMode = SKActionTimingMode.easeOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversed());
        }
        
        let actionSeq = SKAction.sequence(actionsArray);
        layer.run(actionSeq);
    }
    
    override func didMove(to view: SKView) {
        
        
        baseBox = SKSpriteNode(imageNamed: "Group 439")
        baseBox.position = CGPoint(x: 0, y: 0)
        baseBox.zPosition = 5
        self.addChild(baseBox)
        
        openBox = SKSpriteNode(imageNamed: "Group 440")
        openBox.position = CGPoint(x: 70, y: 115)
        openBox.zPosition = 5
        self.addChild(openBox)
        
        purchaseBtn = SKSpriteNode(imageNamed: "Group 441")
        purchaseBtn.position = CGPoint(x: 0, y: -200)
        purchaseBtn.zPosition = 5
        purchaseBtn.name = "purchase"
        self.addChild(purchaseBtn)
        
        let backBtn2 = SKSpriteNode(imageNamed: "backBtn")
        backBtn2.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn2.name = "back2"
        self.addChild(backBtn2)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if name == "purchase" {
                self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                openBox.run(SKAction.move(to: CGPoint(x: 0, y: 0) , duration: 1.0))
                openBox.run(SKAction.scale(to: 2, duration: 1.0))
                purchaseBtn.run(SKAction.scale(to: 0, duration: 0.8))
                baseBox.run(SKAction.scale(to: 0, duration: 0.8))
                let delayInSeconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.boxIsReadyToOpen = true
                }
                
            }
            if name == "back2" {
                self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                    scene.scaleMode = .aspectFill
                    self.menuManager?.didReturnToMainMenu(scene: scene)
                    self.scene?.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                }
            }
        }
        if boxIsReadyToOpen{
            
            shakeCamera(layer: openBox, duration: 1.0)
            
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.run(SKAction.playSoundFileNamed("DeathSound.wav", waitForCompletion: true))
                self.openBox.removeFromParent()
                let boxExplotion = SKEmitterNode(fileNamed: "AsteroidDie")!
                boxExplotion.targetNode = self.scene
                boxExplotion.zPosition = 20
                self.addChild(boxExplotion)
                self.boxIsReadyToOpen = false
            }
            
        }
    }
}
