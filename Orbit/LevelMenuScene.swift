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
    var cPosX = -120
    var cPosY = 100
    var levelNum = 1
    var levelsUnlocked = 3
    var background = SKSpriteNode()
    var levelColors = ["Ellipse 8533", "Ellipse 8534", "Ellipse 8535", "Ellipse 8538"]
    
    func createBG(){
        background = SKSpriteNode(imageNamed: "Rectangle 1806")
        background.size.width = self.size.width
        background.size.height = self.size.height
        background.zPosition = 0
        self.addChild(background)
    }
    
    func createAllLevels(){
        for j in 1...5{
            for i in 1...4{
                if levelNum <= levelsUnlocked{
                    let levelBtn = SKSpriteNode(imageNamed: levelColors[Int(arc4random_uniform(4))])
                    levelBtn.position = CGPoint(x: cPosX, y: cPosY)
                    levelBtn.name = "\(levelNum)"
                    levelBtn.setScale(1.4)
                    print(levelBtn.name)
                    self.addChild(levelBtn)
                    let levelLab = SKLabelNode(text: "\(levelNum)")
                    levelLab.position = CGPoint(x: cPosX, y: cPosY - 15)
                    levelLab.isUserInteractionEnabled = false
                    levelLab.fontName = "Bebas Neue"
                    levelLab.fontSize = 40
                    self.addChild(levelLab)
                } else {
                    let levelBtnLocked = SKSpriteNode(imageNamed: "Group 423")
                    levelBtnLocked.position = CGPoint(x: cPosX, y: cPosY)
                    levelBtnLocked.name = "locked"
                    levelBtnLocked.setScale(1.4)
                    self.addChild(levelBtnLocked)
                }
                cPosX = cPosX + 80
                levelNum = levelNum + 1
            }
            cPosY = cPosY - 80
            cPosX = -120
        }
    }
    
    
    
    
    override func didMove(to view: SKView) {
        createBG()
        createAllLevels()
        
        let levelSelection = SKLabelNode(text: "Level Selection")
        levelSelection.position = CGPoint(x: 0, y: 250)
        levelSelection.fontSize = 50
        levelSelection.fontName = "Bebas Neue"
        levelSelection.color = UIColor(red: 21/255.0, green: 31/255.0, blue: 56/255.0, alpha: 1)
        self.addChild(levelSelection)
        
        let backBtn = SKSpriteNode(imageNamed: "Path 978")
        backBtn.zRotation = CGFloat(M_PI)
        backBtn.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn.name = "back"
        self.addChild(backBtn)
        
        let levelsTitle = SKLabelNode(text: "Levels")
        levelsTitle.position = CGPoint(x: 0, y: self.size.height/2 - 150)
        levelsTitle.fontSize = 50
        levelsTitle.fontColor = .black
        levelsTitle.horizontalAlignmentMode = .center
        self.addChild(levelsTitle)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if let n = Int(name) {
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
            }
            
            if name == "1"{
                //self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 1)
            } else if name == "2" {
                //self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 2)
            } else if name == "3" {
                //self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 3)
            } else if name == "4" {
                //self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 4)
            } else if name == "5" {
                //self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 5)
            } else if name == "back" {
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                    scene.scaleMode = .aspectFill
                    self.menuManager?.didReturnToMainMenu(scene: scene)
                    self.scene?.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                }
            }
            
            if name == "locked" {
                self.run(SKAction.playSoundFileNamed("wood-5.wav", waitForCompletion: true))
            }
            
            
        }
    }
}
