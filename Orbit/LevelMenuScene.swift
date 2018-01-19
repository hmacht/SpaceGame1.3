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
        
        /*
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
 */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            
            if name == "1"{
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 1)
            } else if name == "2" {
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 2)
            } else if name == "3" {
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 3)
            } else if name == "4" {
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 4)
            } else if name == "5" {
                self.run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 5)
            }
            
            if name == "locked"{
                print("Locked: Buy?")
            }
            
            
        }
    }
}
