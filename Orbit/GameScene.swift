//
//  GameScene.swift
//  Orbit
//
//  Created by Henry Macht on 12/8/17.
//  Copyright © 2017 10-12. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox

public struct physicsCatagory {
    static let sun: UInt32 = 0x1 << 1
    static let usersShip: UInt32 = 0x1 << 2
    static let planet: UInt32 = 0x1 << 3
    static let magneticFeild: UInt32 = 0x1 << 4
    static let repelFeild: UInt32 = 0x1 << 5
    static let sunCopy2: UInt32 = 0x1 << 6
    static let theGem: UInt32 = 0x1 << 9
    static let asteroid: UInt32 = 0x1 << 10
    static let planetPath: UInt32 = 0x1 << 11
    static let finishLine: UInt32 = 0x1 << 12
    static let shockWave: UInt32 = 0x1 << 13
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameManager: GameManager?
    
    // Variables

    
    //Graphics
    var usersShip = SKSpriteNode()
    var planet = SKSpriteNode()
    var sun = SKSpriteNode()
    var moonHelper = SKSpriteNode()
    var planetPath = SKSpriteNode()
    var theGem = SKSpriteNode()
    
    //paused
    var pauseBtn = SKSpriteNode()
    var continuebtn = SKSpriteNode()
    var restartbtn2 = SKSpriteNode()
    var quitbtn = SKSpriteNode()
    var settingsbtn2 = SKSpriteNode()
    var pausedBg = SKSpriteNode()
    
    //endofGame
    var endBox = SKSpriteNode()
    var endTime = SKLabelNode()
    var endStar = SKSpriteNode()
    var endGems = SKLabelNode()
    
    var endRestart = SKSpriteNode()
    var endNext = SKSpriteNode()
    var endQuit = SKSpriteNode()
    var endBG = SKSpriteNode()
    var endstore = SKSpriteNode()
    var endCompleteLab = SKSpriteNode()
    var endSkip = SKSpriteNode()
    
    
    
    // lables
    var gemScore = SKLabelNode()
    var numberofYears = SKLabelNode()
    
    
    //particles & explotions
    var rocketSmoke = SKEmitterNode()
    var explotion = SKEmitterNode()
    var explotion1 = SKEmitterNode()
    var ringExplosion = SKSpriteNode()
    var explotion2 = SKEmitterNode()
    var asteroidTrail = SKEmitterNode()
    var asteroidTrailYellow = SKEmitterNode()
    

    // Bools
    var touchingScreen = false
    var right = true
    var launch = false
    var itsRun = false
    var undoAbout = false
    var endOGameDelayIsDone = false
    var gameOver = false
    
    
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
    
    
    // For spawing asteroids
    var timeInBetweenSpawns: CGFloat = 4.5
    var timeSinceLastSpawn: CGFloat = 0
    let alertAsteroid = SKSpriteNode(imageNamed: "alert")
    var startGemsForAsteroid = 0
    var asteroidExplosion = SKEmitterNode(fileNamed: "RockExplosion")!
    var numAsteroidsToSpawn = 1
    
    
    // For fuel
    let fuelBar = SKShapeNode(rectOf: CGSize(width: 200, height: 20))
    var fuel: CGFloat = 100
    var fuelReductionRate: CGFloat = 3
    let initialFuel: CGFloat = 75
    let fuelMask = SKSpriteNode(texture: nil, color: UIColor(red: 255/255, green: 194/255, blue: 0, alpha: 1), size: CGSize(width: 195, height: 15))
    
    
    // Other
    var circle = UIBezierPath()
    var circularMove = SKAction()
    var restartBtn = SKSpriteNode()
    var whatAsteroid = ["Path -1","Path -2","Path 1004"]
    var timer1 = Timer()
    var timer2 = Timer()
    var TopoBtm = Int(arc4random_uniform(2))
    var endOnce = 1
    var hitAlready = 1
    var score = 0
    var aroundTheCircle = 0
    var rotationDirection = CGFloat(M_PI/8)
    var r = CGFloat(0.4)
    var dx = CGFloat()
    var dy = CGFloat()
    var rotatD2 = 0
    var rotationInDegrees = CGFloat()
    var newRotationDegrees = CGFloat()
    var radianFactor = CGFloat(0.0174532925)
    var newRotationRadians = CGFloat()
    var onlyOnce = 1
    var differentColorGems = ["Group 653","Group 660","Group 661","Group 662"]
    var randomGemColor = arc4random_uniform(3)
    var displayEndBoxOnce = 0
    var died = true
    
    // Whether or not in normal game mode or in level
    var inLevel = false
    var cameraNode: SKCameraNode?
    var level = 0
    var gems = [0, 0, 0]
    var gemPos = [CGPoint]()
    var gemSprites = [SKSpriteNode]()
    var currentGemProgress = [0, 0, 0]
    
    var selectedShip = "myShip"
    var shipTexture = SKTexture()
    // Functions
    
    
    func creatEndScrene(yPos: CGFloat){
        
        endBG = SKSpriteNode(imageNamed: "Rectangle 1806")
        endBG.setScale(2)
        endBG.position = CGPoint(x: 0, y: yPos)
        endBG.zPosition = 850
        endBG.alpha = 0.9
        self.addChild(endBG)
        
        endNext = SKSpriteNode(imageNamed: "Group 526")
        endNext.setScale(0)
        endNext.name = "endNext"
        endNext.position = CGPoint(x: 0, y: 0)
        endNext.zPosition = 900
        if self.level % 20 != 0 {
            endBG.addChild(endNext)
        }
        
        endCompleteLab = SKSpriteNode(imageNamed: "Completed")
        endCompleteLab.setScale(1)
        endCompleteLab.position = CGPoint(x: 0, y: 200)
        endCompleteLab.zPosition = 900
        endBG.addChild(endCompleteLab)
        
        endQuit = SKSpriteNode(imageNamed: "Group 545")
        endQuit.setScale(0)
        endQuit.name = "endquit"
        endQuit.position = CGPoint(x: 0, y: -200)
        endQuit.zPosition = 900
        endBG.addChild(endQuit)
        
        endRestart = SKSpriteNode(imageNamed: "Group 544")
        endRestart.setScale(0)
        endRestart.name = "reatarLevel"
        endRestart.position = CGPoint(x: -80, y: -200)
        endRestart.zPosition = 900
        endBG.addChild(endRestart)
        
        endstore = SKSpriteNode(imageNamed: "Group 546")
        endstore.setScale(0)
        endstore.name = "endstore"
        endstore.position = CGPoint(x: 80, y: -200)
        endstore.zPosition = 900
        endBG.addChild(endstore)
        
        
        
        
        
        
        
        
    }
    func createDiedScreen(yPos2: CGFloat){
        //endBG = SKSpriteNode(imageNamed: "Rectangle 1806")
        endBG.setScale(2)
        endBG.position = CGPoint(x: 0, y: yPos2)
        endBG.zPosition = 850
        endBG.alpha = 1.0
        self.addChild(endBG)
        
        endRestart = SKSpriteNode(imageNamed: "Group 4350")
        endRestart.setScale(0)
        endRestart.position = CGPoint(x: 0, y: 0)
        endRestart.zPosition = 900
        endRestart.name = "reatarLevel"
        endBG.addChild(endRestart)
        
        endCompleteLab = SKSpriteNode(imageNamed: "Game over")
        endCompleteLab.setScale(1)
        endCompleteLab.position = CGPoint(x: 0, y: 200)
        endCompleteLab.zPosition = 900
        endBG.addChild(endCompleteLab)
        
        endQuit = SKSpriteNode(imageNamed: "Group 545")
        endQuit.setScale(0)
        endQuit.name = "endquit"
        endQuit.position = CGPoint(x: 0, y: -200)
        endQuit.zPosition = 900
        endBG.addChild(endQuit)
        
        endSkip = SKSpriteNode(imageNamed: "Group 554")
        endSkip.setScale(0)
        endSkip.name = "skip"
        endSkip.position = CGPoint(x: -80, y: -200)
        endSkip.zPosition = 900
        endBG.addChild(endSkip)
        
        endstore = SKSpriteNode(imageNamed: "Group 546")
        endstore.setScale(0)
        endstore.name = "endstore"
        endstore.position = CGPoint(x: 80, y: -200)
        endstore.zPosition = 900
        endBG.addChild(endstore)
    }
    func createHelper() {
        moonHelper.position = CGPoint(x: 0, y: 0)
        self.addChild(moonHelper)
        
    }
    
    func enableCameraFollow() {
        self.cameraNode = SKCameraNode()
        self.cameraNode?.position = CGPoint.zero
        self.addChild(self.cameraNode!)
        self.camera = cameraNode
    }
    
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
    
    func createRing() {
        ringExplosion = SKSpriteNode(imageNamed: "Ellipse 8965")
        ringExplosion.setScale(2)
        ringExplosion.position = CGPoint(x: 0, y: 0)
        ringExplosion.zPosition = 300
    }
    
    func creategemScore(){
        gemScore = SKLabelNode(fontNamed: "Bebas Neue")
        gemScore.text = "\(score)"
        gemScore.fontSize = 80
        gemScore.fontColor = SKColor.white
        gemScore.alpha = 1
        gemScore.zPosition = 130
        gemScore.position = CGPoint(x: 0, y: -25)
        self.addChild(gemScore)
    }
        
    
    func createGem() {
        TopoBtm = Int(arc4random_uniform(2))
        let ranPosx = GKRandomDistribution(lowestValue: -280, highestValue: 280)
        let posx = CGFloat(ranPosx.nextInt())
        var ranPosy = GKRandomDistribution()
        var posy = CGFloat()
        if TopoBtm == 1{
            ranPosy = GKRandomDistribution(lowestValue: 100, highestValue: 580)
            posy = CGFloat(ranPosy.nextInt())
            
        }else{
            ranPosy = GKRandomDistribution(lowestValue: -500, highestValue: -180)
            posy = CGFloat(ranPosy.nextInt())
        }
        randomGemColor = arc4random_uniform(3)
        print(Int(randomGemColor))
        theGem = Gem(imageName: differentColorGems[Int(randomGemColor)])
        theGem.position = CGPoint(x: posx, y: posy)
        if !gameOver {
            self.addChild(theGem)
        }
    }
    
    func createAsteroid(startPointY: CGFloat? = nil, endPointY: CGFloat? = nil) {
        
        let ranPosX = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.scene!.size.width))
        let ranPosY = GKRandomDistribution(lowestValue: -Int(self.scene!.size.height / 2) - 10, highestValue: Int(self.scene!.size.height / 2) - 10)
        var posX = CGFloat(ranPosX.nextInt())
        var posY = CGFloat(ranPosY.nextInt())
        
        // Set start point to either left or right side
        // send end point to the opposite
        
        if posX > self.scene!.size.width / 2 {
            posX = self.scene!.size.width / 2 + 32
        } else {
            posX = -self.scene!.size.width / 2 - 32
        }
        
        var endPosY = CGFloat(GKRandomDistribution(lowestValue: -Int(self.scene!.size.height / 2) - 10, highestValue: Int(self.scene!.size.height / 2) - 10).nextInt())
        var endPosX = -posX
        
        if let sP = startPointY {
            posY = sP
        }
        
        if let eP = endPointY {
            endPosY = eP
        }
        
        let asteroid = Asteroid(asteroidName: whatAsteroid[Int(arc4random_uniform(3))])
        asteroid.position = CGPoint(x: posX, y: posY)
        asteroid.trail.targetNode = self.scene
        
        self.addChild(asteroid)
        
        let growTime: CGFloat = 1.2
        let shrinkTime: CGFloat = 0.5
        let alert = AlertAsteroid(image: "alert", growTime: growTime, shrinkTime: shrinkTime)
        
        if posX < 0 {
            alert.position = CGPoint(x: posX + self.size.width/6, y: posY)
        } else {
            alert.position = CGPoint(x: posX - self.size.width/6, y: posY)
        }
        
        self.addChild(alert)
        
        alert.warn()
        
        asteroid.run(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(growTime + shrinkTime)), SKAction.run({
            asteroid.spin()
            asteroid.move(to: CGPoint(x: endPosX, y: endPosY))
        })]))
        
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
        //self.addChild(planetPath)
    }
    
    func createRestartbtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.setScale(2)
        restartBtn.position = CGPoint(x: 0, y: -500)
        restartBtn.alpha = 0
        restartBtn.zPosition = 200
        restartBtn.name = "restartGame"
    }
    func createdottedPath() {
        let dottedPath = SKSpriteNode(imageNamed: "Asset 4")
        dottedPath.alpha = 1
        dottedPath.setScale(1.2)
        dottedPath.position = CGPoint(x: 0, y: 0)
        self.addChild(dottedPath)
        dottedPath.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 50.0)))
        dottedPath.run(SKAction.scale(to: 1.5, duration: 2.5))
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 2.5), SKAction.fadeOut(withDuration: 0.5)])
        dottedPath.run(sequence)
        
    }
    
    func createSun() {
        
        self.sun = Sun(imageName: "Ellipse 8950")
        sun.position = CGPoint(x: 0, y: 0)
        self.addChild(sun)
    }
    
    func createShip() {
        usersShip = SKSpriteNode(imageNamed: self.selectedShip)
        self.shipTexture = SKTexture(imageNamed: self.selectedShip)
        usersShip.size.width = self.shipTexture.size().width
        usersShip.size.height = self.shipTexture.size().height
        if self.selectedShip == "Group 470" {
            usersShip.setScale(1.3)
        } else {
            usersShip.setScale(2)
        }
        usersShip.position = CGPoint(x: 0, y: 100)
        usersShip.zPosition = 25
        usersShip.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed:"myShip"), size: usersShip.size)
        //usersShip.physicsBody = SKPhysicsBody(rectangleOf: usersShip.size)
        usersShip.physicsBody?.categoryBitMask = physicsCatagory.usersShip
        usersShip.physicsBody?.collisionBitMask = physicsCatagory.usersShip | physicsCatagory.planet | physicsCatagory.sun
        usersShip.physicsBody?.contactTestBitMask = physicsCatagory.usersShip | physicsCatagory.planet | physicsCatagory.sun | physicsCatagory.theGem | physicsCatagory.asteroid
        usersShip.physicsBody?.affectedByGravity = true
        usersShip.physicsBody?.isDynamic = true
        
        
        
        let smokeTrail = SKEmitterNode(fileNamed: "newTrail")!
        smokeTrail.targetNode = self.scene
        smokeTrail.name = "Smoke"
        smokeTrail.zPosition = 20
        //smokeTrail.numParticlesToEmit = 1
        usersShip.addChild(smokeTrail)
        //smokeTrail.isHidden = true
        
        let smokeTrail2 = SKEmitterNode(fileNamed: "newTrail2")!
        smokeTrail2.targetNode = self.scene
        smokeTrail2.name = "Smoke2"
        smokeTrail2.zPosition = 21
        //smokeTrail2.numParticlesToEmit = 1
        usersShip.addChild(smokeTrail2)
        //smokeTrail2.isHidden = true
        
        let smokeTrail3 = SKEmitterNode(fileNamed: "newTrail3")!
        smokeTrail3.targetNode = self.scene
        smokeTrail3.name = "Smoke3"
        smokeTrail3.zPosition = 20
        //smokeTrail3.numParticlesToEmit = 1
        usersShip.addChild(smokeTrail3)
        //smokeTrail3.isHidden = true
 

 
        self.addChild(usersShip)
 
    }
    
    func explode(){
        explotion = SKEmitterNode(fileNamed: "shipDeath")!
        explotion.name = "explotion"
        explotion.zPosition = 300
        explotion.position = CGPoint(x: usersShip.position.x, y: usersShip.position.y)
        self.addChild(explotion)
    }
    
    func explode1(){
        explotion1 = SKEmitterNode(fileNamed: "explotionWhite")!
        explotion1.name = "explotionWhite"
        explotion1.zPosition = 20
        explotion1.position = CGPoint(x: 0, y: 400)
    }
    
    func explode2(){
        explotion2 = SKEmitterNode(fileNamed: "Explotion2.sks")!
        explotion2.name = "Explotion2"
        explotion1.zPosition = 500
    }
    
    func createAsteroidTrail(){
        //asteroidTrail = SKEmitterNode(fileNamed: "asteroidtrail.sks")!
        asteroidTrail.name = "asteroidtrail"
        asteroidTrail.zPosition = 500
    }
    
    func createPlanet() {
        let planet = Planet(imageName: "Ellipse 8951")
        planet.position = CGPoint(x: 0, y: 0)
        
        self.addChild(planet)
        
        circle = UIBezierPath(roundedRect: CGRect(x: self.frame.midX - 260, y: self.frame.midY - 260, width: 525, height: 525), cornerRadius: 300)
        
        planet.orbit(path: circle.cgPath, speed: 2)
    }
    
    func createyears(){
        numberofYears = SKLabelNode(fontNamed: "Book")
        //numberofYears.font
        
        numberofYears.text = "+\(score) GEMS"
        numberofYears.fontSize = 30
        numberofYears.fontColor = SKColor.black
        numberofYears.zPosition = 900
        numberofYears.alpha = 0
        numberofYears.position = CGPoint(x: 0, y: 250)
    }
    
    func randomPointOnCircle(radius:Float, center:CGPoint) -> CGPoint {
        // Random angle in [0, 2*pi]
        let theta = Float(arc4random_uniform(UInt32.max))/Float(UInt32.max-1) * Float.pi * 2.0
        // Convert polar to cartesian
        let x = radius * cos(theta)
        let y = radius * sin(theta)
        return CGPoint(x: CGFloat(x)+center.x, y: CGFloat(y)+center.y)
    }
    func pointOnCircle(radius:Float, center:CGPoint) -> CGPoint {
        // Random angle in [0, 2*pi]
        aroundTheCircle = aroundTheCircle + 2000000000
        let theta = Float(aroundTheCircle)/Float(UInt32.max-1) * Float.pi * 2.0
        // Convert polar to cartesian
        let x = radius * cos(theta)
        let y = radius * sin(theta)
        return CGPoint(x: CGFloat(x)+center.x, y: CGFloat(y)+center.y)
    }
    
    func endofGameNoDelay(win: Bool? = false) {
        if endOnce == 1 {
            print("Game Over")
            
            // Save gems
            self.updateGems()
            pauseBtn.removeFromParent()
            gameOver = true
            self.timer1.invalidate()
            self.sun.run(SKAction.scale(to: 0, duration: 1))
            if !inLevel {
                self.numberofYears.text = "+\(score) GEMS"
            }
            /*
            restartBtn.alpha = 0.5
            self.addChild(restartBtn)
            if let c = self.cameraNode {
                restartBtn.position = CGPoint(x: 0, y: c.position.y - 200)
            }*/
            theGem.removeFromParent()
            self.numberofYears.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
            let delayInSeconds = 1.0
            gemScore.removeFromParent()
            if !inLevel {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.numberofYears.alpha = 0
                    self.addChild(self.numberofYears)
                    
                }
            }
            endOnce = 0
        }
    }
    
    func updateGems() {
        // Get gems for memory. If nothing stored, returns 0
        let currentGems = UserDefaults.standard.integer(forKey: "Gems")
        UserDefaults.standard.set(currentGems + self.score, forKey: "Gems")
        //print("Total gems:", UserDefaults.standard.integer(forKey: "Gems"))
    }
    
    func goToGameScene(){
        print("Game Started")
        gameOver = false
        timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: "update1", userInfo: nil, repeats: true)
        if !inLevel {
            self.sun.run(SKAction.scale(to: 2, duration: 1))
        } else {
            for g in self.gemSprites {
                if let _ = g.parent {
                    g.removeFromParent()
                }
            }
            self.createGemsForLevel(scene: self)
        }
        
        self.gems = [0, 0, 0]
        score = 0
        hitAlready = 1
        gemScore.text = "\(score)"
        usersShip.position = CGPoint(x: 0, y: 100)
        usersShip.zRotation = 0
        
        // Ring for killing nearby asteroids
        let ring = SKSpriteNode(imageNamed: "ring")
        ring.zPosition = usersShip.zPosition + 10
        ring.physicsBody = SKPhysicsBody(circleOfRadius: ring.size.width)
        ring.physicsBody?.categoryBitMask = physicsCatagory.shockWave
        ring.physicsBody?.collisionBitMask = physicsCatagory.shockWave | physicsCatagory.asteroid
        ring.physicsBody?.contactTestBitMask = physicsCatagory.shockWave | physicsCatagory.asteroid
        ring.physicsBody?.affectedByGravity = false
        ring.physicsBody?.isDynamic = false
        ring.setScale(0)
        ring.position = usersShip.position
        self.addChild(ring)
        self.addChild(usersShip)
        
        let scale = SKAction.scale(to: 3.5, duration: 1)
        let fade = SKAction.fadeAlpha(to: 0, duration: 1.3)
        ring.run(SKAction.sequence([SKAction.group([scale, fade]), SKAction.removeFromParent()]))
        
        endOnce = 1
        self.fuel = self.initialFuel
        self.fuelMask.color = UIColor(red: 255/255, green: 194/255, blue: 0, alpha: 1)
        self.restartBtn.removeFromParent()
        self.addChild(gemScore)
        self.theGem.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        numberofYears.removeFromParent()
        explotion.particleBirthRate = 19
        explotion1.particleBirthRate = 35
        ringExplosion.alpha = 1
        createPauseBtn()
        if !inLevel {
            createGem()
        }
    }
    
    func playBtnClicked(){
        
        createRestartbtn()
        createyears()
        createRing()
        createPauseBtn()
        
        if !inLevel {
            createHelper()
            createPlanetPath()
            //createSun()
            createPlanet()
            //createPlanetTest()
            createGem()
            creategemScore()
            explode1()
            
        }
        //moonHelper.run(SKAction.repeatForever(SKAction.rotate(byAngle: 10, duration: 5)))
        //self.addChild(self.alertAsteroid)
    }
    
    
    func playBtnIsClicked(){
        startGemsForAsteroid = 1
        
        if !self.inLevel {
            self.createSun()
        }
        
            
        self.playBtnClicked()
        let delayInSeconds3 = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds3) {
            self.createShip()
        }
    }
    
    func whenAboutIsClicked(){
        aboutInfo = SKSpriteNode(imageNamed: "Group 147")
        aboutInfo.size.width = self.size.width - 200
        aboutInfo.size.height = 220
        aboutInfo.position = CGPoint(x: 0, y: 1000)
        aboutInfo.zPosition = 10
        self.addChild(aboutInfo)
        
        closeBtn1 = SKSpriteNode(imageNamed: "Group 135")
        closeBtn1.setScale(2)
        closeBtn1.position = CGPoint(x: (-(self.size.width - 200) / 2) + 30, y: 1070)
        closeBtn1.zPosition = 11
        self.addChild(closeBtn1)
    }
    
    func whenAboutIsClickedOpp2(){
        creatorsLab = SKSpriteNode(imageNamed: "created by henry & toby")
        creatorsLab.setScale(2)
        creatorsLab.position = CGPoint(x: 0, y: -500)
        creatorsLab.zPosition = 1
        self.addChild(creatorsLab)
        
        shareTestImg = SKSpriteNode(imageNamed: "Group 148")
        shareTestImg.setScale(2)
        shareTestImg.position = CGPoint(x: 0, y: -550)
        shareTestImg.zPosition = 1
        self.addChild(shareTestImg)
        
        undoAbout = true
        homeMoon.run(SKAction.move(to: CGPoint(x: 0, y: -980), duration: 2.5))
    }
    
    // Testing
    
    func createPlanetTest() {
        // This planet has the ability to go into on to the orbit
        let planet = SKSpriteNode(imageNamed: "planet")
        planet.setScale(2)
        planet.position = CGPoint(x: 0, y: planetPath.size.height / 2)
        planet.zPosition = 50
        moonHelper.addChild(planet)
    }
    
    func createPauseBtn(){
        pauseBtn = SKSpriteNode(imageNamed: "Group 362")
        pauseBtn.setScale(2.7)
        pauseBtn.position = CGPoint(x: -self.size.width/2 + 120, y: self.size.height/2 - 50)
        pauseBtn.zPosition = 5
        pauseBtn.name = "pausebtn"
        self.addChild(pauseBtn)
    }
    
    func pausedGame(){
        var yOffset: CGFloat = 0
        if let c = self.cameraNode {
            yOffset += c.position.y
        }
        
        pausedBg = SKSpriteNode(imageNamed: "Rectangle 1783")
        pausedBg.setScale(2)
        pausedBg.position = CGPoint(x: 0, y: yOffset)
        pausedBg.zPosition = 400
        self.addChild(pausedBg)
        
        continuebtn = SKSpriteNode(imageNamed: "Group 358")
        continuebtn.setScale(2)
        continuebtn.position = CGPoint(x: 0, y: 120 + yOffset)
        continuebtn.zPosition = 500
        continuebtn.name = "continue"
        self.addChild(continuebtn)
        
        restartbtn2 = SKSpriteNode(imageNamed: "Group 359")
        restartbtn2.setScale(2)
        restartbtn2.position = CGPoint(x: -10, y: 40 + yOffset)
        restartbtn2.zPosition = 500
        restartbtn2.name = "restart2"
        self.addChild(restartbtn2)
        
        quitbtn = SKSpriteNode(imageNamed: "Group 360")
        quitbtn.setScale(2)
        quitbtn.position = CGPoint(x: -50, y: -40 + yOffset)
        quitbtn.zPosition = 500
        quitbtn.name = "quit"
        self.addChild(quitbtn)
        
        settingsbtn2 = SKSpriteNode(imageNamed: "Group 366")
        settingsbtn2.setScale(2)
        settingsbtn2.position = CGPoint(x: 0, y: -120 + yOffset)
        settingsbtn2.zPosition = 50000001
        settingsbtn2.name = "settings2"
        self.addChild(settingsbtn2)
        
    }
    
    
    
    
    override func didMove(to view: SKView) {
        
        // Get rid of camera
        self.camera = nil
        self.backgroundColor = UIColor(red: 237/255, green: 248/255, blue: 255/255, alpha: 1)
        
        //view.showsPhysics = true
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        let field = SKFieldNode.radialGravityField()
        // center on X-axis
        field.position.x = 0
        // center on Y-axis
        field.position.y = 0
        // add to your world
        field.strength = 0.6
        self.addChild(field)
        
        let BG = SKSpriteNode(imageNamed: "BGGame")
        BG.setScale(2)
        BG.position = CGPoint(x: 0, y: 0)
        BG.size.width = self.size.width
        BG.size.height = self.size.height
        BG.zPosition = -10
        if !inLevel == false {
            BG.size.height = 200000
        
        }
        self.addChild(BG)
        
        
        if let selected = UserDefaults.standard.string(forKey: "selectedShip") {
            self.selectedShip = selected
        } else {
            self.selectedShip = "myShip"
        }
        
        playBtnIsClicked()
        
        fuelBar.strokeColor = UIColor.black
        fuelBar.lineWidth = 5
        fuelBar.zPosition = 100
        fuelBar.position = CGPoint(x: -self.size.width/2 + fuelBar.frame.size.width, y: -self.size.height/2 + 50)
        //self.addChild(fuelBar)
        fuelMask.name = "mask"
        fuelMask.position = CGPoint(x: 0, y: 0)
        //fuelBar.addChild(fuelMask)
        
        self.asteroidExplosion.zPosition = 100
        self.asteroidExplosion.alpha = 0
        self.addChild(self.asteroidExplosion)
        
        self.setupBackgroundMusic()
        
        if let gemProgress = UserDefaults.standard.array(forKey: "Level\(self.level)") as? [Int] {
            self.currentGemProgress = gemProgress
        }
        
        timer1 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: "update1", userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: "update2", userInfo: nil, repeats: true)
        
        if inLevel {
            self.createBottomBoundary()
        }
    }
    
    func createBottomBoundary() {
        let line = SKShapeNode(rect: CGRect(x: -self.size.width/2, y: 0, width: self.size.width, height: 10))
        line.fillColor = UIColor.black
        line.strokeColor = UIColor.black
        line.position = CGPoint(x: 0, y: -self.size.height/2 - 10)
        self.addChild(line)
    }
    
    @objc func update2() {
        if gameOver == false{
            createdottedPath()
        }
    }
    @objc func update1() {
        rotationInDegrees = usersShip.zRotation / radianFactor;
        newRotationDegrees = rotationInDegrees + 90;
        newRotationRadians = newRotationDegrees * radianFactor;
        dx = r * cos(newRotationRadians)
        dy = r * sin(newRotationRadians)
        if touchingScreen {
            if launch{
                usersShip.physicsBody?.applyImpulse(CGVector(dx: dx * 3, dy: dy * 3))
            }else{
                usersShip.run(SKAction.rotate(byAngle: rotationDirection, duration: 0.3))
                usersShip.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
            }
        }
    }
    
    func dieAsteroidAnimation() {
        shakeCamera(layer: sun, duration: 0.5)
        //self.addChild(explotion2)
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.explotion2.particleBirthRate = 1
            let delayInSeconds2 = 1.2
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds2) {
                self.explotion2.removeFromParent()
            }
        }
    }
    func dieShipAnimation(win: Bool = false) {
        explode()
        usersShip.removeFromParent()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        if win {
            self.run(SKAction.playSoundFileNamed("WinSoundOrbit.mp3", waitForCompletion: true))
        } else {
            self.run(SKAction.playSoundFileNamed("DeathSound.wav", waitForCompletion: true))
        }
        shakeCamera(layer: theGem, duration: 0.5)
        shakeCamera(layer: planetPath, duration: 0.5)
        shakeCamera(layer: sun, duration: 0.5)
        explotion.position = CGPoint(x: usersShip.position.x, y: usersShip.position.y)
        explotion1.position = CGPoint(x: usersShip.position.x, y: usersShip.position.y)
        ringExplosion.setScale(0)
        if hitAlready == 1{
            self.addChild(ringExplosion)
            //self.addChild(explotion1)
            //self.addChild(explotion)
            hitAlready = 0
        }
        ringExplosion.position = CGPoint(x: usersShip.position.x, y: usersShip.position.y)
        ringExplosion.run(SKAction.scale(to: 3, duration: 0.5))
        let delayInSeconds4 = 0.3
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds4) {
            self.ringExplosion.run(SKAction.fadeAlpha(to: 0, duration: 0.2), completion: {
                self.ringExplosion.removeFromParent()
            })
        }
        
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.explotion.particleBirthRate = 1
            let delayInSeconds2 = 1.2
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds2) {
                self.explotion1.particleBirthRate = 1
            }
            
            let delayInSeconds3 = 0.6
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds3) {
                
                self.explotion.run(SKAction.fadeAlpha(to: 0, duration: 0.2), completion: {
                    self.explotion.removeFromParent()
                    self.explotion.alpha = 1
                })
                
                self.explotion1.run(SKAction.fadeAlpha(to: 0, duration: 0.6), completion: {
                    self.explotion1.removeFromParent()
                    self.explotion1.alpha = 1
                })
                
                self.restartBtn.alpha = 1.0
                self.endOGameDelayIsDone = true
                
                
            }
        }
        
    }
    func levelDeathAnimation(){
        restartBtn.removeFromParent()
        died = true
        if inLevel {
            let ypos2 = usersShip.position.y
            createDiedScreen(yPos2: ypos2)
        }else{
            let ypos2 = 0
            createDiedScreen(yPos2: CGFloat(Int(ypos2)))
        }
        
        
        endstore.run(SKAction.scale(to: 1, duration: 0.5))
        endQuit.run(SKAction.scale(to: 1, duration: 0.5))
        endRestart.run(SKAction.scale(to: 1, duration: 0.5))
        endSkip.run(SKAction.scale(to: 1, duration: 0.5))
        dieShipAnimation()
        endofGameNoDelay()
        gameOver = true
        displayEndBoxOnce = 1
    }
    
    
    
    
    // Contact Functions
    
    
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstbody = contact.bodyA
        let secondbody = contact.bodyB
        
        if firstbody.categoryBitMask == physicsCatagory.usersShip && secondbody.categoryBitMask == physicsCatagory.planet || firstbody.categoryBitMask == physicsCatagory.planet && secondbody.categoryBitMask == physicsCatagory.usersShip{
            print("planet")
            endofGameNoDelay()
            dieShipAnimation()
            if displayEndBoxOnce == 0 {
                
                levelDeathAnimation()
            }
        }
        
        if firstbody.categoryBitMask == physicsCatagory.usersShip && secondbody.categoryBitMask == physicsCatagory.theGem || firstbody.categoryBitMask == physicsCatagory.theGem && secondbody.categoryBitMask == physicsCatagory.usersShip{
            
            var gem: Gem = Gem()
            if firstbody.categoryBitMask == physicsCatagory.theGem {
                gem = firstbody.node! as! Gem
            } else {
                gem = secondbody.node! as! Gem
            }
            if !gem.touched {
                self.playSound(s: "gold.wav", waitForEnd: true)
                gem.touched = true
            }
            
            if !inLevel {
                score = score + 1
                self.numAsteroidsToSpawn = min(score / 3 + 1, 6)
                gemScore.text = "\(score)"
                theGem.physicsBody = nil
                theGem.run(SKAction.scale(to: 3, duration: 0.5))
                theGem.run(SKAction.move(to: CGPoint(x: gemScore.position.x, y: gemScore.position.y) , duration: 1))
                let delayInSeconds = 0.5
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                    self.theGem.run(SKAction.scale(to: 0, duration: 0.5))
                }
                let delayInSeconds2 = 1.0
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds2) {
                    self.theGem.removeFromParent()
                    self.createGem()
                    //self.gemScore.text = "\(self.score)"
                    let grow = SKAction.scale(to: 1.3, duration: 0.5)
                    let shrink = SKAction.scale(to: 1, duration: 0.5)
                    self.gemScore.run(SKAction.sequence([grow, shrink]))
                }
                itsRun = true
            } else {
                // We are in level
                var gem = SKNode()
                if firstbody.categoryBitMask == physicsCatagory.theGem {
                    gem = firstbody.node!
                } else {
                    gem = secondbody.node!
                }
                let grow = SKAction.scale(to: 1.4, duration: 0.4)
                let shrink = SKAction.scale(to: 0, duration: 0.5)
                let n = gem.name!
                gem.run(SKAction.sequence([grow, shrink, SKAction.removeFromParent()]))
                self.gems[Int(n)!] = 1
            }
        }
        
        if firstbody.categoryBitMask == physicsCatagory.usersShip && secondbody.categoryBitMask == physicsCatagory.asteroid || secondbody.categoryBitMask == physicsCatagory.usersShip && firstbody.categoryBitMask == physicsCatagory.asteroid {
            
            dieShipAnimation()
            endofGameNoDelay()
            if displayEndBoxOnce == 0 {
                levelDeathAnimation()
            }
        }
        
        if firstbody.categoryBitMask == physicsCatagory.usersShip && secondbody.categoryBitMask == physicsCatagory.sun || secondbody.categoryBitMask == physicsCatagory.usersShip && firstbody.categoryBitMask == physicsCatagory.sun {
            self.fuel = self.initialFuel
            self.updateFuelBar(amountLeft: self.fuel)
        }
        
        if firstbody.categoryBitMask == physicsCatagory.asteroid && secondbody.categoryBitMask == physicsCatagory.sun || firstbody.categoryBitMask == physicsCatagory.sun && secondbody.categoryBitMask == physicsCatagory.asteroid {
            if firstbody.categoryBitMask == physicsCatagory.asteroid {
                explotion2.position = CGPoint(x: (firstbody.node?.position.x)!, y: (firstbody.node?.position.y)!)
                dieAsteroidAnimation()
                self.addAsteroidExplosion(point: firstbody.node!.position, node: firstbody.node!)
                firstbody.node?.removeFromParent()
            } else {
                explotion2.position = CGPoint(x: (secondbody.node?.position.x)!, y: (secondbody.node?.position.y)!)
                dieAsteroidAnimation()
                self.addAsteroidExplosion(point: secondbody.node!.position, node: secondbody.node!)
                secondbody.node?.removeFromParent()
            }
        }
        
        if firstbody.categoryBitMask == physicsCatagory.asteroid && secondbody.categoryBitMask == physicsCatagory.planet || firstbody.categoryBitMask == physicsCatagory.planet && secondbody.categoryBitMask == physicsCatagory.asteroid {
            
            if firstbody.categoryBitMask == physicsCatagory.asteroid {
                self.addAsteroidExplosion(point: firstbody.node!.position, node: firstbody.node!)
                firstbody.node?.removeFromParent()
            } else {
                self.addAsteroidExplosion(point: secondbody.node!.position, node: secondbody.node!)
                secondbody.node?.removeFromParent()
            }
        }
        
        if firstbody.categoryBitMask == physicsCatagory.asteroid && secondbody.categoryBitMask == physicsCatagory.shockWave || firstbody.categoryBitMask == physicsCatagory.shockWave && secondbody.categoryBitMask == physicsCatagory.asteroid {
            
            if firstbody.categoryBitMask == physicsCatagory.asteroid {
                self.addAsteroidExplosion(point: firstbody.node!.position, node: firstbody.node!)
                firstbody.node?.removeFromParent()
            } else {
                self.addAsteroidExplosion(point: secondbody.node!.position, node: secondbody.node!)
                secondbody.node?.removeFromParent()
            }
        }
        
        if firstbody.categoryBitMask == physicsCatagory.usersShip && secondbody.categoryBitMask == physicsCatagory.finishLine || firstbody.categoryBitMask == physicsCatagory.finishLine && secondbody.categoryBitMask == physicsCatagory.usersShip {
            
            if displayEndBoxOnce == 0 {
                
                for i in 0...self.gems.count - 1 {
                    if self.gems[i] == 1 {
                        if self.currentGemProgress[i] != 1 {
                            self.score += 1
                        }
                        self.currentGemProgress[i] = 1
                    }
                }
                UserDefaults.standard.set(self.currentGemProgress, forKey: "Level\(self.level)")
                
                self.updateGems()
                self.score = 0
                restartBtn.removeFromParent()
                dieShipAnimation(win: true)
                endofGameNoDelay()
                let yPos = usersShip.position.y //+ self.size.height * 0.75
                creatEndScrene(yPos: yPos)
                endstore.run(SKAction.scale(to: 1, duration: 0.5))
                endQuit.run(SKAction.scale(to: 1, duration: 0.5))
                endNext.run(SKAction.scale(to: 1, duration: 0.5))
                endRestart.run(SKAction.scale(to: 1, duration: 0.5))
                gameOver = true
                displayEndBoxOnce = 1
            }
            
            
        }
    }
    
    func addAsteroidExplosion(point: CGPoint, node: SKNode) {
        var trail = SKEmitterNode()
        
        if node.children.count > 0 {
            trail = node.children[0] as! SKEmitterNode
            trail.removeFromParent()
            self.addChild(trail)
            trail.position = node.position
            trail.numParticlesToEmit = 1
        } else {
            self.addChild(trail)
        }
        
        let asteroidExplosion = SKEmitterNode(fileNamed: "RockExplosion")!
        asteroidExplosion.zPosition = 100
        asteroidExplosion.xScale = 0.5
        asteroidExplosion.yScale = 0.5
        
        self.addChild(asteroidExplosion)
        
        asteroidExplosion.position = point
        asteroidExplosion.alpha = 1
        asteroidExplosion.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 0.5), SKAction.run({
            asteroidExplosion.removeFromParent()
        })]))
        
        trail.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 4), SKAction.removeFromParent()]))
    }
    
    var countTouch:[Int] = []
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        countTouch.append((event?.allTouches?.count)!)
        
        if let smoke = usersShip.childNode(withName: "Smoke") as? SKEmitterNode {
            smoke.isHidden = false
            smoke.numParticlesToEmit = 0
        }
        if let smoke = usersShip.childNode(withName: "Smoke2") as? SKEmitterNode {
            smoke.isHidden = false
            smoke.numParticlesToEmit = 0
        }
        if let smoke = usersShip.childNode(withName: "Smoke3") as? SKEmitterNode {
            smoke.isHidden = false
            smoke.numParticlesToEmit = 0
        }
        
        touchingScreen = true
        
        if gameOver == false {
            if self.action(forKey: "rocketSound") == nil {
                let sequence = SKAction.sequence([SKAction.wait(forDuration: 0.02), SKAction.playSoundFileNamed("RocketThrust.wav", waitForCompletion: true)])
                let sound = SKAction.repeatForever(sequence)
                self.run(sound, withKey: "rocketSound")
            }
        }
        
        
        
        if self.selectedShip == "myShip" {
            usersShip.size.height = self.shipTexture.size().height * 2 + 5
        }
        if self.selectedShip == "myShip" {
            usersShip.texture = SKTexture(imageNamed:"myShip2")
        }
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name{
            if name == "pausebtn"{
                self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                pausedGame()
                scene?.speed = 0
                scene?.physicsWorld.speed = 0
            }
            
            if name == "continue"{
                self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                pausedBg.removeFromParent()
                continuebtn.removeFromParent()
                restartbtn2.removeFromParent()
                quitbtn.removeFromParent()
                settingsbtn2.removeFromParent()
                scene?.speed = 1
                scene?.physicsWorld.speed = 1
            }
            
            if name == "quit" {
                self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                pausedBg.removeFromParent()
                continuebtn.removeFromParent()
                restartbtn2.removeFromParent()
                quitbtn.removeFromParent()
                settingsbtn2.removeFromParent()
                self.updateGems()
                scene?.speed = 1
                scene?.physicsWorld.speed = 1
                self.gameManager?.returnToMenu()
            }
            if name == "endquit" {
                self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                self.updateGems()
                self.gameManager?.returnToMenu()
            }
            if name == "restart2"{
                self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                pausedBg.removeFromParent()
                continuebtn.removeFromParent()
                restartbtn2.removeFromParent()
                quitbtn.removeFromParent()
                settingsbtn2.removeFromParent()
                self.updateGems()
                scene?.speed = 1
                scene?.physicsWorld.speed = 1
                gemScore.text = "0"
                score = 0
                usersShip.zRotation = 0
                usersShip.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                usersShip.position = CGPoint(x: 0, y: 100)
                
                if inLevel {
                    self.gems = [0, 0, 0]
                    for g in self.gemSprites {
                        if let _ = g.parent {
                            g.removeFromParent()
                        }
                    }
                    self.createGemsForLevel(scene: self)
                }
                
            }
            
            if name == "endNext" {
                let fadeAction = SKAction.run {
                    self.endBG.zPosition = 901
                    self.endBG.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
                }
                let clickAction = SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: false)
                self.run(SKAction.sequence([clickAction, fadeAction, SKAction.run({
                    self.gameManager?.nextLevel()
                })]))
            }
        }
        
        if undoAbout {
            homeMoon.run(SKAction.move(to: CGPoint(x: 0, y: -600), duration: 2.5))
            let delayInSeconds = 1.5
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                self.creatorsLab.removeFromParent()
                self.shareTestImg.removeFromParent()
            }
            undoAbout = false
        }
        
        if let name = touchedNode.name{
            if name == "about"{
                print("hi")
                whenAboutIsClickedOpp2()
            }
        }
        
        if let name = touchedNode.name{
            if name == "play"{
                playBtnIsClicked()
            }
        }
        
        if positionInScene.x > 0{
            right = true
            rotationDirection = CGFloat(-M_PI/8)
        }else{
            right = false
            rotationDirection = CGFloat(M_PI/8)
        }
        
        if let name = touchedNode.name{
            if name == "restartGame"{
                if endOGameDelayIsDone{
                    self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                    goToGameScene()
                    endOGameDelayIsDone = false
                }
            }
        }
        if let name = touchedNode.name{
            if name == "reatarLevel"{
                if endOGameDelayIsDone{
                    self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                    
                    displayEndBoxOnce = 0
                    goToGameScene()
                    
                    endRestart.removeFromParent()
                    endBox.removeFromParent()
                    endStar.removeFromParent()
                    endNext.removeFromParent()
                    endQuit.removeFromParent()
                    endTime.removeFromParent()
                    endGems.removeFromParent()
                    endstore.removeFromParent()
                    endBG.removeFromParent()
                    endCompleteLab.removeFromParent()
                    died = false
                    
                   
                    endOGameDelayIsDone = false
                }
            }
        }
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        countTouch.append((event?.allTouches?.count)!)
        //print(countTouch[countTouch.count - 1])let sun5 = Sun(imageName: "Group 419")
        
        if countTouch[countTouch.count - 1] == 2{
            launch = true
        }else{
            launch = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchingScreen = false
        if self.selectedShip == "myShip" {
            usersShip.texture = SKTexture(imageNamed:"myShip")
        }
        
        if let smoke = usersShip.childNode(withName: "Smoke") as? SKEmitterNode {
            smoke.isHidden = true
            smoke.numParticlesToEmit = 1
        }
        if let smoke = usersShip.childNode(withName: "Smoke2") as? SKEmitterNode {
            smoke.isHidden = true
            smoke.numParticlesToEmit = 1
        }
        if let smoke = usersShip.childNode(withName: "Smoke3") as? SKEmitterNode {
            smoke.isHidden = true
            smoke.numParticlesToEmit = 1
        }
        
        if self.selectedShip == "myShip" {
            usersShip.size.height = self.shipTexture.size().height * 2
        }
        self.removeAction(forKey: "rocketSound")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchingScreen = false
        usersShip.texture = SKTexture(imageNamed:"myShip")
        
        if let smoke = usersShip.childNode(withName: "Smoke") as? SKEmitterNode {
            smoke.isHidden = true
            smoke.numParticlesToEmit = 1
        }
        if let smoke = usersShip.childNode(withName: "Smoke2") as? SKEmitterNode {
            smoke.isHidden = true
            smoke.numParticlesToEmit = 1
        }
        if let smoke = usersShip.childNode(withName: "Smoke3") as? SKEmitterNode {
            smoke.isHidden = true
            smoke.numParticlesToEmit = 1
        }
        
        if self.selectedShip == "myShip" {
            usersShip.size.height = self.shipTexture.size().height * 2
        }
        self.removeAction(forKey: "rocketSound")
    }
    
    
    
    
    
    var lastUpdateTime: TimeInterval = 0
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if usersShip.position.x > self.size.width / 2 {
            usersShip.position.x = (-self.size.width / 2) + usersShip.size.width
        }
        if usersShip.position.x < -self.size.width / 2{
            usersShip.position.x = self.size.width / 2 - usersShip.size.width
        }
        if !inLevel {
            if usersShip.position.y > self.size.height / 2 {
                usersShip.position.y = -self.size.height / 2
            }
            if usersShip.position.y < -self.size.height / 2{
                usersShip.position.y = self.size.height / 2
            }
        } else {
            if usersShip.position.y < -self.size.height/2  && !gameOver {
                dieShipAnimation()
                endofGameNoDelay()
                levelDeathAnimation()
            }
        }
        
        
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        if self.score >= self.startGemsForAsteroid {
            self.timeSinceLastSpawn += CGFloat(deltaTime)
        }
        
        
        if gameOver == false && !inLevel {
            if timeSinceLastSpawn > self.timeInBetweenSpawns {
                for i in 1...self.numAsteroidsToSpawn {
                    self.createAsteroid()
                }
                self.timeSinceLastSpawn = 0
            }
        }

        // Update fuel
        if touchingScreen {
            var fuelDecreaseRate = self.fuelReductionRate
            if countTouch[countTouch.count - 1] == 2 {
                fuelDecreaseRate *= 3
            }
            self.fuel -= fuelDecreaseRate * CGFloat(deltaTime)
            if fuel < 0 {
                fuel = 0
                //self.endofGameNoDelay()
                //self.dieShipAnimation()
            }
            self.updateFuelBar(amountLeft: self.fuel)
        }
        
        if self.fuel < self.initialFuel * 0.25 {
            self.fuelMask.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 0.5, duration: 2))
        }
        
        // Update gravity of moon
        if !inLevel {
            let distancePlayerToMoon = distance(p1: usersShip.position, p2: sun.position)
            if distancePlayerToMoon > distance(p1: sun.position, p2: self.planet.position) {
                let dampningValue = CGFloat(0.007 * distancePlayerToMoon / (self.scene!.frame.height * 2))
                usersShip.physicsBody?.applyForce(CGVector(dx: (sun.position.x - usersShip.position.x) * dampningValue, dy:     (sun.position.y - usersShip.position.y) * dampningValue))
            }
        }
        if gameOver == false {
            if let c = self.cameraNode {
                c.run(SKAction.move(to: CGPoint(x: 0, y: usersShip.position.y), duration: 0.2))
                self.pauseBtn.run(SKAction.move(to: CGPoint(x: self.pauseBtn.position.x, y: c.position.y + self.size.height/2 - 75), duration: 0.2))
            }
        }
        
        
    }
    
    func updateFuelBar(amountLeft: CGFloat) {
        self.fuelMask.size = CGSize(width: (amountLeft / self.initialFuel) * 195, height: 15)
        self.fuelMask.position = CGPoint(x: (-195/2) + self.fuelMask.size.width/2, y: self.fuelMask.position.y)
    }
    
    func distance(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let xDif = p1.x - p2.x
        let yDif = p1.y - p2.y
        return CGFloat(sqrt((xDif * xDif) + (yDif * yDif)))
    }
    
    func playSound(s: String, waitForEnd: Bool) {
        self.run(SKAction.playSoundFileNamed(s, waitForCompletion: waitForEnd))
    }
    
    func setupBackgroundMusic() {
        let audioNode = SKAudioNode(fileNamed: "orbit_music2.wav")
        //self.addChild(audioNode)
    }
    
    func createGemsForLevel(scene: SKScene) {
        if gemPos.count >= 1 {
            for i in 0...gemPos.count-1 {
                let gem = Gem(imageName: "gem")
                gem.position = gemPos[i]
                gem.name = String(i)
                self.addChild(gem)
                self.gemSprites.append(gem)
            
                if self.currentGemProgress[i] == 1 {
                    gem.alpha = 0.5
                }
            }
        }
    }
}
