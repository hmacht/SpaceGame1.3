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
import AudioToolbox

class LevelSelectScene: SKScene {
    
    var menuManager: MenuManager?
    var playBgMusic = false
    
    var planetPath = SKSpriteNode()
    var moonHelper = SKSpriteNode()
    var twinkleHome = SKSpriteNode()
    var differentTwinkles = ["Group 394","Group 398","Group 399"]
    var ranPosx = GKRandomDistribution()
    var ranPosy = GKRandomDistribution()
    var posX = CGFloat()
    var posY = CGFloat()
    var timer3 = Timer()
    
    
    var hasTaped = false
    var clickedPlay = false
    
    
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
    var gemsText = SKLabelNode()
    
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
        planetPath = SKSpriteNode(imageNamed: "Ellipse 8996")
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
        moonHelper.position = planetPath.position
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
        shopBtn.name = "shop"
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
        planetPath.position = CGPoint(x: self.size.width / 2 - 180, y: -self.size.height / 2 + 150)
        planetPath.zRotation = 250
        
        createHelper()
        planetHome = SKSpriteNode(imageNamed: "Ellipse 8969")
        planetHome.setScale(2)
        planetHome.zPosition = 500
        planetHome.position = CGPoint(x: -1 * planetPath.size.width / 2, y: 0)
        moonHelper.addChild(planetHome)
        
        let titleLabel = SKLabelNode(text: "rbit")
        titleLabel.position = CGPoint(x: 145, y: playBtn.position
        .y + 115)
        titleLabel.fontSize = 75
        titleLabel.setScale(2)
        titleLabel.fontName = "Bebas Neue"
        titleLabel.fontColor = SKColor(red: 21/255.0, green: 31/255.0, blue: 56/255.0, alpha: 1)
        //self.addChild(titleLabel)
        
        let nGems = String(UserDefaults.standard.integer(forKey: "Gems"))
        gemsText = SKLabelNode(text: nGems)
        gemsText.fontColor = .black
        gemsText.fontName = "Bebas Neue"
        gemsText.fontSize = 50
        gemsText.verticalAlignmentMode = .center
        gemsText.horizontalAlignmentMode = .left
        gemsText.position = CGPoint(x: -self.size.width/2 + 130, y: self.size.height/2 - 75)
        self.addChild(gemsText)
        
        let gemsImage = SKSpriteNode(imageNamed: "Group 677")
        gemsImage.position = CGPoint(x: -20, y: 0)
        gemsImage.setScale(2)
        gemsText.addChild(gemsImage)
        
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint(x: self.size.width/4, y: -self.size.height/3 - 75)
        //self.addChild(sun)
    }
    
    
    
    var homeLogo = SKSpriteNode()
    var about = SKSpriteNode()
    var leaderboard = SKSpriteNode()
    var settings = SKSpriteNode()
    var tapToStart = SKSpriteNode()
    var shipShop = SKSpriteNode()
    var addGems = SKSpriteNode()
   
    
    
    
    func createTheHomeScreen2(){
        
        let BG = SKSpriteNode(imageNamed: "BGGame")
        BG.setScale(2)
        BG.position = CGPoint(x: 0, y: 0)
        BG.size.width = self.size.width
        BG.size.height = self.size.height
        BG.zPosition = -10
        self.addChild(BG)
        
        homeLogo = SKSpriteNode(imageNamed: "Group 680")
        homeLogo.setScale(2)
        homeLogo.position = CGPoint(x: 0, y: 0)
        homeLogo.zPosition = 300
        self.addChild(homeLogo)
        
        createHelper()
        planetHome = SKSpriteNode(imageNamed: "Ellipse 8969")
        planetHome.setScale(2)
        planetHome.zPosition = 500
        planetHome.position = CGPoint(x: -230, y: 0)
        moonHelper.addChild(planetHome)
        
        tapToStart = SKSpriteNode(imageNamed: "TAP TO START")
        tapToStart.setScale(2)
        tapToStart.position = CGPoint(x: 0, y: -300)
        tapToStart.zPosition = 300
        self.addChild(tapToStart)
        
        about = SKSpriteNode(imageNamed: "Group 654")
        about.setScale(2)
        about.position = CGPoint(x: -130, y: -450)
        about.zPosition = 300
        self.addChild(about)
        
        leaderboard = SKSpriteNode(imageNamed: "Group 655")
        leaderboard.setScale(2)
        leaderboard.position = CGPoint(x: 0, y: -450)
        leaderboard.zPosition = 300
        self.addChild(leaderboard)
        
        settings = SKSpriteNode(imageNamed: "Group 656")
        settings.setScale(2)
        settings.position = CGPoint(x: 130, y: -450)
        settings.zPosition = 300
        self.addChild(settings)
        
        
        let nGems = String(UserDefaults.standard.integer(forKey: "Gems"))
        gemsText = SKLabelNode(text: nGems)
        gemsText.fontColor = .black
        gemsText.fontName = "Bebas Neue"
        gemsText.fontSize = 50
        gemsText.verticalAlignmentMode = .center
        gemsText.position = CGPoint(x: -self.size.width/2 + 230, y: self.size.height/2 - 75)
        self.addChild(gemsText)
        
        let gemsImage = SKSpriteNode(imageNamed: "Group 677")
        gemsImage.position = CGPoint(x: -130, y: 0)
        gemsImage.setScale(2)
        gemsText.addChild(gemsImage)
        
        shipShop = SKSpriteNode(imageNamed: "Group 679")
        shipShop.setScale(2)
        shipShop.position = CGPoint(x: self.size.width/2 - 130, y: self.size.height/2 - 75)
        shipShop.zPosition = 300
        shipShop.setScale(1.8)
        shipShop.name = "shop"
        self.addChild(shipShop)
        
    }
    
    var endless = SKSpriteNode()
    var divider = SKSpriteNode()
    var levels = SKSpriteNode()
    
    func creatOptions(){
        
        
        endless = SKSpriteNode(imageNamed: "ENDLESS-1")
        endless.setScale(2)
        endless.position = CGPoint(x: -100, y: -300)
        endless.zPosition = 300
        endless.setScale(2)
        endless.name = "endlessMode"
        endless.alpha = 0
        self.addChild(endless)
        
        divider = SKSpriteNode(imageNamed: "Rectangle 1953")
        divider.setScale(2)
        divider.position = CGPoint(x: 0, y: -300)
        divider.zPosition = 300
        divider.size.height = 0
        divider.setScale(2)
        divider.name = "endlessMode"
        self.addChild(divider)
        
        levels = SKSpriteNode(imageNamed: "LEVELS")
        levels.setScale(2)
        levels.position = CGPoint(x: 100, y: -300)
        levels.zPosition = 300
        levels.setScale(2)
        levels.name = "endlessMode"
        levels.alpha = 0
        self.addChild(levels)
        
        
        
        divider.run(SKAction.resize(toHeight: 80, duration: 1))
        endless.run(SKAction.fadeAlpha(to: 1, duration: 1))
        levels.run(SKAction.fadeAlpha(to: 1, duration: 1))
        
        
        
    }
    
    override func didMove(to view: SKView) {
        UserDefaults.standard.set(99999999, forKey: "Gems")
        hasTaped = false
        //levels.removeFromParent()
        //endless.removeFromParent()
        //divider.removeFromParent()
        self.addChild(tapToStart)
        let musicAction = SKAction.repeatForever(SKAction.playSoundFileNamed("bgMusic3.mp3", waitForCompletion: true))
        if self.playBgMusic {
            self.run(musicAction, withKey: "bgMusic")
        }
        createTheHomeScreen()
        timer3 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: "update3", userInfo: nil, repeats: true)
        
        if let _ = UserDefaults.standard.string(forKey: "selectedShip") {
            
        } else {
            UserDefaults.standard.set("myShip", forKey: "selectedShip")
        }
        
    }
    
    @objc func update3() {
            
            ranPosx = GKRandomDistribution(lowestValue: -280, highestValue: 280)
            ranPosy = GKRandomDistribution(lowestValue: -600, highestValue: 600)
            posX = CGFloat(ranPosx.nextInt())
            posY = CGFloat(ranPosy.nextInt())
            
            //createtwinkle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        /*
        if hasTaped == false{
            tapToStart.removeFromParent()
            creatOptions()
            let delayInSeconds = 0.1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.hasTaped = true
            }
            
        }
        if hasTaped{
            if positionInScene.y > -400 && positionInScene.y < -200{
                if positionInScene.x < 0{
                    self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                    self.menuManager?.didPressEndless(level: 0)
                }else{
                    self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                    playBtn.run(SKAction.scale(to: 1.5, duration: 0.2))
                    clickedPlay = true
                }
            }
        }
 */
        
        
        
        if let name = touchedNode.name{
            if name == "endless"{
                self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                self.menuManager?.didPressEndless(level: 0)
            }
            if name == "play" {
                self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                playBtn.run(SKAction.scale(to: 1.5, duration: 0.2))
                clickedPlay = true
                
            }
            if name == "shop"{
                let sound = SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true)
                self.run(SKAction.sequence([sound, SKAction.run {
                    if let scene = SKScene(fileNamed: "shop") as? ShopScreen {
                        scene.menuManager = self.menuManager
                        self.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                    }
                }]))
            }
            
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playBtn.run(SKAction.scale(to: 2.0, duration: 0.3))
        if clickedPlay == true{
            self.menuManager?.didPressPlay()
        }
    }
    
    func updateGems() {
        let nGems = String(UserDefaults.standard.integer(forKey: "Gems"))
        gemsText.text = nGems
    }
}
