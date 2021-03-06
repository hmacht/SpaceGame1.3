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
    var startTouchY: CGFloat = 0
    var cam = SKCameraNode()
    var easyText = SKLabelNode()
    var normalText = SKLabelNode()
    var count = 0
    let selectColor = UIColor(red: 47/255, green: 170/255, blue: 64/255, alpha: 1)
    var modeTab = SKShapeNode()
    var mode = GameMode.normal
    
    func createBG(){
        background = SKSpriteNode(imageNamed: "Rectangle 1783")
        background.size.width = self.size.width
        background.size.height = self.size.height
        background.zPosition = 0
        self.addChild(background)
        
        let background2 = SKSpriteNode(imageNamed: "Rectangle 1783")
        background2.size.width = self.size.width
        background2.size.height = self.size.height
        background2.zPosition = 0
        background2.position = CGPoint(x: 0, y: -self.size.height)
        self.addChild(background2)
    }
    
    func createAllLevels(){
        for j in 1...8 {
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
                        crown.setScale(0.85)
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
            if j == 5 {
                let downArrow = SKSpriteNode(imageNamed: "backBtn")
                downArrow.position = CGPoint(x: 0, y: cPosY - 70)
                downArrow.zRotation = CGFloat.pi/2
                downArrow.name = "downArrow"
                self.addChild(downArrow)
                
                let upArrow = SKSpriteNode(imageNamed: "backBtn")
                upArrow.position = CGPoint(x: 0, y: -self.size.height/2 - 50)
                upArrow.zRotation = -CGFloat.pi/2
                upArrow.name = "upArrow"
                self.addChild(upArrow)
                
                cPosY -= 375
            } else {
                cPosY = cPosY - 85
            }
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
        self.count = 0
        
        createBG()
        createAllLevels()
        openScene(durationScale: self.durationToOpen)
        
        let levelSelection = SKLabelNode(text: "Galaxy One")
        levelSelection.position = CGPoint(x: 0, y: 230)
        levelSelection.fontSize = 50
        levelSelection.fontName = "Bebas Neue"
        levelSelection.fontColor = SKColor(red: 21/255.0, green: 31/255.0, blue: 56/255.0, alpha: 1)
        self.addChild(levelSelection)
        
        let levelSelection2 = SKLabelNode(text: "Galaxy Two")
        levelSelection2.position = CGPoint(x: 0, y: -self.size.height/2 - 150)
        levelSelection2.fontSize = 50
        levelSelection2.fontName = "Bebas Neue"
        levelSelection2.fontColor = SKColor(red: 21/255.0, green: 31/255.0, blue: 56/255.0, alpha: 1)
        self.addChild(levelSelection2)
        
        let backBtn = SKSpriteNode(imageNamed: "backBtn")
        backBtn.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn.name = "back"
        self.addChild(backBtn)
        
        modeTab = SKShapeNode(rectOf: CGSize(width: 175, height: 25), cornerRadius: 8)
        modeTab.position = CGPoint(x: self.size.width/2 - 95, y: self.size.height/2 - 50)
        modeTab.strokeColor = UIColor.black
        modeTab.lineWidth = 4
        modeTab.name = "modeTab"
        self.addChild(modeTab)
        
        easyText = SKLabelNode(text: "Easy")
        easyText.position = CGPoint(x: modeTab.frame.size.width/4, y: 0)
        easyText.fontSize = 25
        easyText.fontName = "Bebas Neue"
        easyText.fontColor = UIColor.black
        easyText.verticalAlignmentMode = .center
        easyText.name = "modeTab"
        modeTab.addChild(easyText)
        
        normalText = SKLabelNode(text: "Normal")
        normalText.position = CGPoint(x: -modeTab.frame.size.width/4, y: 0)
        normalText.fontSize = 25
        normalText.fontName = "Bebas Neue"
        normalText.fontColor = UIColor.black
        normalText.verticalAlignmentMode = .center
        normalText.name = "modeTab"
        normalText.fontColor = self.selectColor
        modeTab.addChild(normalText)
        
        let dividingBar = SKShapeNode(rectOf: CGSize(width: 1, height: 25), cornerRadius: 2)
        dividingBar.position = CGPoint(x: normalText.frame.size.width/2 + 10, y: 0)
        dividingBar.strokeColor = .black
        dividingBar.fillColor = .black
        dividingBar.lineWidth = 4
        normalText.addChild(dividingBar)
        
        self.cam.position = CGPoint.zero
        self.addChild(self.cam)
        self.camera = self.cam
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        self.startTouchY = positionInScene.y
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if let n = Int(name) {
                //self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                self.playSound(s: "click1.mp3", wait: true)
                self.menuManager?.setMode(mode: self.mode)
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
            if name == "modeTab" {
                let pos = touch.location(in: self.modeTab)
                if pos.x < -self.modeTab.frame.size.width/2 + self.normalText.frame.size.width + 5 {
                    // Normal mode
                    normalText.fontColor = self.selectColor
                    easyText.fontColor = UIColor.black
                    self.mode = GameMode.normal
                } else {
                    // Easy mode
                    self.count += 1
                    if count > 14 {
                        self.easyText.text = "Izzi"
                    }
                    easyText.fontColor = self.selectColor
                    normalText.fontColor = UIColor.black
                    self.mode = GameMode.easy
                }
            }
            
            if name == "downArrow" {
                if self.cam.position.y > -self.size.height {
                    let moveAction = SKAction.move(to: CGPoint(x: 0, y: -self.size.height), duration: 0.35)
                    self.cam.run(moveAction)
                }
            }
            if name == "upArrow" {
                if self.cam.position.y < 0 {
                    let moveAction = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.35)
                    self.cam.run(moveAction)
                }
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let touchedNode = self.atPoint(pos)
            
            /*
            if self.startTouchY - pos.y > 150 || touchedNode.name == "down" {
                // Swipe down
                if self.cam.position.y < 0 {
                    let moveAction = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.35)
                    self.cam.run(moveAction)
                }
            } else if self.startTouchY - pos.y < -150 || touchedNode.name == "up" {
                // Swipe up
                if self.cam.position.y > -self.size.height {
                    let moveAction = SKAction.move(to: CGPoint(x: 0, y: -self.size.height), duration: 0.35)
                    self.cam.run(moveAction)
                }
            }*/
        }
        
    }
    
    func playSound(s: String, wait: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            self.run(SKAction.playSoundFileNamed(s, waitForCompletion: wait))
        }
    }
}
