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
    var cPosX = -135
    var cPosY = 150
    var levelNum = 1
    var levelsUnlocked = 1
    var background = SKSpriteNode()
    var levelColors = ["Ellipse 8533", "Ellipse 8534", "Ellipse 8535", "Ellipse 8538"]
    var allTheLevels = [SKSpriteNode()]
    var allTheLevelsLabs = [SKLabelNode()]
    var durationToOpen: TimeInterval = 1
    
    func createBG(){
        background = SKSpriteNode(imageNamed: "Rectangle 1783")
        background.size.width = self.size.width
        background.size.height = self.size.height
        background.zPosition = 0
        self.addChild(background)
    }
    
    func createAllLevels(){
        for j in 1...5{
            for i in 1...4 {
                var unlockedGems = [0, 0, 0]
                if let g = UserDefaults.standard.array(forKey: "Level\(levelNum)") as? [Int] {
                    unlockedGems = g
                    levelsUnlocked = levelNum + 1
                }
                if levelNum <= levelsUnlocked{
                    let levelBtn = SKSpriteNode(imageNamed: levelColors[Int(arc4random_uniform(4))])
                    levelBtn.position = CGPoint(x: cPosX, y: cPosY)
                    levelBtn.name = "\(levelNum)"
                    levelBtn.setScale(0)
                    allTheLevels.append(levelBtn)
                    
                    /*
                    let angleOfGemPos = [Double.pi * 3 / 2 - 2 / 3 * Double.pi, Double.pi * 3 / 2 + 2 / 3 * Double.pi, Double.pi * 3 / 2]
                    
                    for a in 0...angleOfGemPos.count-1 {
                        let emptyGem = SKSpriteNode(imageNamed: "EmptyGem")
                        emptyGem.position = CGPoint(x: CGFloat(cos(angleOfGemPos[a])) * 25, y: CGFloat(sin(angleOfGemPos[a])) * 25)
                        emptyGem.setScale(0.4)
                        levelBtn.addChild(emptyGem)
                        
                        if unlockedGems[a] == 1 {
                            emptyGem.texture = SKTexture(imageNamed: "gem")
                        }
                    }*/
                    if unlockedGems.reduce(0, +) == 3 {
                        let crown = SKSpriteNode(imageNamed: "crown")
                        let x = cos(Double.pi / 2)
                        let y = sin(Double.pi / 2)
                        crown.setScale(1.1)
                        crown.position = CGPoint(x: x * 32, y: y * 32)
                        crown.zRotation = CGFloat(Double.pi * 0)
                        levelBtn.addChild(crown)
                    }
                    
                    
                    //print(levelBtn.name)
                    self.addChild(levelBtn)
                    let levelLab = SKLabelNode(text: "\(levelNum)")
                    //levelLab.position = CGPoint(x: cPosX, y: cPosY - 15)
                    levelLab.position = CGPoint(x: 0, y: -0.75 * 15)
                    levelLab.isUserInteractionEnabled = false
                    levelLab.name = "\(levelNum)"
                    levelLab.fontName = "Bebas Neue"
                    //levelLab.setScale(0)
                    levelLab.fontSize = 30
                    //allTheLevelsLabs.append(levelLab)
                    levelBtn.addChild(levelLab)
                } else {
                    let levelBtnLocked = SKSpriteNode(imageNamed: "Group 423")
                    levelBtnLocked.position = CGPoint(x: cPosX, y: cPosY)
                    levelBtnLocked.name = "locked"
                    levelBtnLocked.setScale(0)
                    allTheLevels.append(levelBtnLocked)
                    self.addChild(levelBtnLocked)
                }
                cPosX = cPosX + 90
                levelNum = levelNum + 1
            }
            cPosY = cPosY - 100
            cPosX = -135
        }
    }
    
    func openScene(durationScale: TimeInterval) {
        for i in 1...allTheLevelsLabs.count {
          allTheLevelsLabs[i - 1].run(SKAction.scale(to: 1, duration: 0.4 * durationScale))
        
        }
        for i in 1...allTheLevels.count {
            allTheLevels[i - 1].run(SKAction.scale(to: 1.4, duration: 0.32 * durationScale))
            
        }
        
    }
    
    
    
    
    override func didMove(to view: SKView) {
        
        cPosX = -135
        cPosY = 150
        self.levelNum = 1
        self.levelsUnlocked = 1
        
        createBG()
        createAllLevels()
        openScene(durationScale: self.durationToOpen)
        
        let levelSelection = SKLabelNode(text: "Galaxy One")
        levelSelection.position = CGPoint(x: 0, y: 230)
        levelSelection.fontSize = 50
        levelSelection.fontName = "Bebas Neue"
        levelSelection.fontColor = SKColor(red: 21/255.0, green: 31/255.0, blue: 56/255.0, alpha: 1)
        self.addChild(levelSelection)
        
        let backBtn = SKSpriteNode(imageNamed: "backBtn")
        backBtn.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn.name = "back"
        self.addChild(backBtn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if let n = Int(name) {
                //self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                self.playSound(s: "click1.mp3", wait: true)
                self.menuManager?.didPressEndless(level: n)
            }
            
            if name == "back" {
                //self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                self.playSound(s: "click2.mp3", wait: true)
                if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                    scene.scaleMode = .aspectFill
                    self.menuManager?.didReturnToMainMenu(scene: scene)
                    self.scene?.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                }
            }
            
            if name == "locked" {
                //self.run(SKAction.playSoundFileNamed("wood-5.wav", waitForCompletion: true))
                self.playSound(s: "wood-5.wav", wait: true)
            }
            
            
        }
    }
    
    func playSound(s: String, wait: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            self.run(SKAction.playSoundFileNamed(s, waitForCompletion: wait))
        }
    }
}
