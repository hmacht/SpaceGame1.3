//
//  settings.swift
//  Orbit
//
//  Created by Henry Macht on 2/10/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AudioToolbox

class SettingsScreen: SKScene {
    var menuManager: MenuManager?
    
    var ranPosx = GKRandomDistribution()
    var ranPosy = GKRandomDistribution()
    var posX = CGFloat()
    var posY = CGFloat()
    var timer3 = Timer()
    var differentTwinkles = ["Group 394","Group 398","Group 399"]
    
    var vibrationBtn = SKSpriteNode()
    var soundBtn = SKSpriteNode()
    
    var isSoundOn = UserDefaults.standard.bool(forKey: "soundOn")
    var isvibrationsOn = UserDefaults.standard.bool(forKey: "vibrationOn")
    
    
    func createtwinkle() {
        let twinkleHome = SKSpriteNode(imageNamed: differentTwinkles[Int(arc4random_uniform(3))])
        twinkleHome.alpha = 1
        twinkleHome.position = CGPoint(x: posX, y: posY)
        twinkleHome.zPosition = 200
        twinkleHome.setScale(0)
        self.addChild(twinkleHome)
        twinkleHome.run(SKAction.scale(to: 1.4, duration: 2.5))
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.scale(to: 0, duration: 2.0)])
        twinkleHome.run(sequence)
    }
    
    override func didMove(to view: SKView) {
        
        let BG = SKSpriteNode(imageNamed: "Rectangle 1783")
        BG.setScale(2)
        BG.position = CGPoint(x: 0, y: 0)
        BG.size.width = self.size.width
        BG.size.height = self.size.height
        BG.zPosition = -10
        self.addChild(BG)
        
        let backBtn2 = SKSpriteNode(imageNamed: "backBtn")
        backBtn2.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn2.name = "back2"
        self.addChild(backBtn2)
        
        print(isvibrationsOn)
        
        vibrationBtn = SKSpriteNode(imageNamed: "Group 779")
        vibrationBtn.position = CGPoint(x: 50, y: 0)
        vibrationBtn.name = "vibration"
        if isvibrationsOn{
            vibrationBtn.texture = SKTexture(imageNamed: "Group 779")
        }else{
            vibrationBtn.texture = SKTexture(imageNamed: "Group 781")
        }
        self.addChild(vibrationBtn)
        
        soundBtn = SKSpriteNode(imageNamed: "Group 778")
        soundBtn.position = CGPoint(x: -50, y: 0)
        soundBtn.name = "sound"
        if isSoundOn{
            soundBtn.texture = SKTexture(imageNamed: "Group 778")
        }else{
            soundBtn.texture = SKTexture(imageNamed: "Group 780")
        }
        self.addChild(soundBtn)
        
        timer3 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: "update3", userInfo: nil, repeats: true)
        
    }
    @objc func update3() {
        
        ranPosx = GKRandomDistribution(lowestValue: -280, highestValue: 280)
        ranPosy = GKRandomDistribution(lowestValue: -600, highestValue: 600)
        posX = CGFloat(ranPosx.nextInt())
        posY = CGFloat(ranPosy.nextInt())
        
        createtwinkle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        
        
        if let name = touchedNode.name{
            if name == "back2" {
                //self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                self.playSound(s: "click2.mp3", wait: true)
                if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                    scene.scaleMode = .aspectFill
                    self.menuManager?.didReturnToMainMenu(scene: scene)
                    self.scene?.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                }
            }
            if name == "vibration"{
                self.playSound(s: "click1.mp3", wait: true)
                if isvibrationsOn{
                    vibrationBtn.texture = SKTexture(imageNamed: "Group 781")
                    UserDefaults.standard.set(false, forKey: "vibrationOn")
                    isvibrationsOn = false
                    print(isvibrationsOn)
                }else{
                    vibrationBtn.texture = SKTexture(imageNamed: "Group 779")
                    UserDefaults.standard.set(true, forKey: "vibrationOn")
                    isvibrationsOn = true
                    print("else", isvibrationsOn)
                }
                
            }
            if name == "sound"{
                if isSoundOn{
                    soundBtn.texture = SKTexture(imageNamed: "Group 780")
                    UserDefaults.standard.set(false, forKey: "soundOn")
                    isSoundOn = false
                    self.menuManager?.stopMusic()
                }else{
                    soundBtn.texture = SKTexture(imageNamed: "Group 778")
                    UserDefaults.standard.set(true, forKey: "soundOn")
                    isSoundOn = true
                    self.menuManager?.startMusic()
                }
                self.playSound(s: "click1.mp3", wait: true)
            }
        }
    }
    
    func playSound(s: String, wait: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            self.run(SKAction.playSoundFileNamed(s, waitForCompletion: wait))
        }
    }

}





