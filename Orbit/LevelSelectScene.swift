//
//  LevelSelectScene.swift
//  Orbit
//
//  Created by Henry Macht on 1/18/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LevelSelectScene: SKScene {
    
    var menuManager: MenuManager?
    
    var planetPath = SKSpriteNode()
    var moonHelper = SKSpriteNode()
    var twinkleHome = SKSpriteNode()
    var differentTwinkles = ["Group 394","Group 398","Group 399"]
    var ranPosx = GKRandomDistribution()
    var ranPosy = GKRandomDistribution()
    var posX = CGFloat()
    var posY = CGFloat()
    var timer3 = Timer()
    
    
    // For home screen
    var homeMoon = SKSpriteNode()
    var orbitLab = SKSpriteNode()
    var playBtn = SKSpriteNode()
    var AboutBtn = SKSpriteNode()
    var settingsBtn = SKSpriteNode()
    var homeShip = SKSpriteNode()
    var homeBackground = SKSpriteNode()
    var aboutInfo = SKSpriteNode()
    var closeBtn1 = SKSpriteNode()
    var creatorsLab = SKSpriteNode()
    var shareTestImg = SKSpriteNode()
    var LBButton = SKSpriteNode()
    var endlessBtn = SKSpriteNode()
    var planetHome = SKSpriteNode()
    var shopBtn = SKSpriteNode()
    
    func createtwinkle() {
        let twinkleHome = SKSpriteNode(imageNamed: differentTwinkles[Int(arc4random_uniform(3))])
        twinkleHome.alpha = 1
        twinkleHome.position = CGPoint(x: posX, y: posY)
        twinkleHome.zPosition = 200
        twinkleHome.setScale(0)
        self.addChild(twinkleHome)
        twinkleHome.run(SKAction.scale(to: 1.8, duration: 2.5))
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.scale(to: 0, duration: 2.0)])
        twinkleHome.run(sequence)
    }
    
    func createPlanetPath() {
        planetPath = SKSpriteNode(imageNamed: "Group 206")
        planetPath.setScale(1.7)
        planetPath.position = CGPoint(x: 0, y: 0)
        planetPath.zPosition = 15
        planetPath.physicsBody = SKPhysicsBody(circleOfRadius: planetPath.size.width / 2.0)
        planetPath.physicsBody?.categoryBitMask = physicsCatagory.planetPath
        planetPath.physicsBody?.collisionBitMask = physicsCatagory.planetPath
        planetPath.physicsBody?.contactTestBitMask = physicsCatagory.planetPath | physicsCatagory.asteroid
        planetPath.physicsBody?.affectedByGravity = false
        planetPath.physicsBody?.isDynamic = false
        self.addChild(planetPath)
    }
    
    func createHelper() {
        moonHelper.position = CGPoint(x: Int(self.size.width / 2) - 180, y: (-1 * Int(self.size.height / 2)) + 150)
        self.addChild(moonHelper)
        moonHelper.run(SKAction.repeatForever(SKAction.rotate(byAngle: 10, duration: 5)))
    }
    
    func createTheHomeScreen(){
        homeBackground = SKSpriteNode(imageNamed: "Rectangle 1783")
        homeBackground.size.width = self.size.width
        homeBackground.size.height = self.size.height
        homeBackground.zPosition = 0
        self.addChild(homeBackground)
        
        
        playBtn = SKSpriteNode(imageNamed: "play")
        playBtn.setScale(2)
        playBtn.position = CGPoint(x: -107, y: 180)
        playBtn.zPosition = 300
        playBtn.name = "play"
        self.addChild(playBtn)
        
        endlessBtn = SKSpriteNode(imageNamed: "endless")
        endlessBtn.setScale(2)
        endlessBtn.position = CGPoint(x: -62, y: 100)
        endlessBtn.zPosition = 300
        endlessBtn.name = "endless"
        self.addChild(endlessBtn)
        
        LBButton = SKSpriteNode(imageNamed: "leaderboard")
        LBButton.setScale(2)
        LBButton.position = CGPoint(x: 0, y: 20)
        LBButton.zPosition = 300
        LBButton.name = "LB"
        self.addChild(LBButton)
        
        shopBtn = SKSpriteNode(imageNamed: "shop")
        shopBtn.setScale(2)
        shopBtn.position = CGPoint(x: -107, y: -60)
        shopBtn.zPosition = 300
        shopBtn.name = "LB"
        self.addChild(shopBtn)
        
        settingsBtn = SKSpriteNode(imageNamed: "settings")
        settingsBtn.setScale(2)
        settingsBtn.position = CGPoint(x: -55, y: -140)
        settingsBtn.zPosition = 300
        settingsBtn.name = "settings"
        self.addChild(settingsBtn)
        
        homeShip = SKSpriteNode(imageNamed: "Group 133")
        homeShip.setScale(2)
        homeShip.position = CGPoint(x: -135, y: 90)
        homeShip.zPosition = 2
        //self.addChild(homeShip)
        
        createPlanetPath()
        planetPath.position = CGPoint(x: Int(self.size.width / 2) - 180, y: (-1 * Int(self.size.height / 2)) + 150)
        planetPath.zRotation = 250
        
        createHelper()
        planetHome = SKSpriteNode(imageNamed: "planet")
        planetHome.setScale(2)
        planetHome.zPosition = 500
        planetHome.position = CGPoint(x: -1 * planetPath.size.width / 2, y: 0)
        moonHelper.addChild(planetHome)
        
    }
    
    override func didMove(to view: SKView) {
        createTheHomeScreen()
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
            if name == "endless"{
                self.menuManager?.didPressEndless(level: 0)
            } else if name == "play" {
                self.menuManager?.didPressPlay()
            }
        }
    }
}
