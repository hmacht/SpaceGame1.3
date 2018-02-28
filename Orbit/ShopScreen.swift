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
    var gemsText = SKLabelNode()
    var boxPrice = 100
    var avalibleShips = ["Group 477", "Group 479", "Group 480", "Group 481", "Group 483"]
    var shipWon = SKSpriteNode()
    var popUpBg = SKSpriteNode()
    var PopUpBox = SKSpriteNode()
    var buyBtn = SKSpriteNode()
    var xOutBtn = SKSpriteNode()
    var cost = SKLabelNode()
    
    var cPosX = -120
    var cPosY = 140
    var levelNum = 1
    var levelsUnlocked = 1
    var background = SKSpriteNode()
    var levelColors = ["Group 562", "Group 561", "Group 560", "Group 559", "Group 558", "Group 557","Group 556"]
    var allTheLevels = [SKSpriteNode()]
    var allTheLevelsLabs = [SKLabelNode()]
    var whatToBuy = Int()
    var shipsUnlocked = [Int()]
    var selector = SKSpriteNode()
    
    var shipOptions = ["myShip", "Group 474", "Group 472", "Group 469", "Group 470", "Group 476"]
    var unlockedShips = [String]()
    var selectedShip = ""
    var selectedSprite = SKNode()
    var pendingShipBuy = ""
    
    
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
    func createAllLevels(){
        for j in 0...3 {
            for i in 0...2 {
                let index = 3 * j + i
                if index < self.shipOptions.count {
                    if self.unlockedShips.contains(self.shipOptions[index]) {
                        let ship = SKSpriteNode(imageNamed: self.shipOptions[index])
                        ship.position = CGPoint(x: cPosX, y: cPosY)
                        ship.setScale(0.1)
                        ship.name = self.shipOptions[index]
                        self.addChild(ship)
                        
                        let circle = SKShapeNode(circleOfRadius: 50 / 1.75)
                        circle.position = CGPoint(x: 0, y: 0)
                        circle.strokeColor = .black
                        circle.lineWidth = 8 / 1.75
                        circle.name = "circle"
                        ship.addChild(circle)
                        
                        if self.selectedShip == self.shipOptions[index] {
                            circle.strokeColor = UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4)
                            self.selectedSprite = ship
                        }
                        self.allTheLevels.append(ship)
                    } else {
                        let levelBtnLocked = SKSpriteNode(imageNamed: "Group 555")
                        levelBtnLocked.position = CGPoint(x: cPosX, y: cPosY)
                        levelBtnLocked.name = "\(self.shipOptions[index])/locked/\(index)"
                        levelBtnLocked.setScale(0)
                        allTheLevels.append(levelBtnLocked)
                        self.addChild(levelBtnLocked)
                    }
                    cPosX = cPosX + 120
                    levelNum = levelNum + 1
                }
            }
            cPosY = cPosY - 120
            cPosX = -120
        }
    }
    func moveSelector(theParent: SKNode) {
        self.selector.removeFromParent()
        selector = SKSpriteNode(imageNamed: "Group 519")
        selector.position = CGPoint(x: 30, y: -30)
        selector.zPosition = 100
        selector.setScale(1)
        theParent.addChild(selector)
    }
    func showUnlocked(){
        print("unlockFunc")
        print(shipsUnlocked)
        if shipsUnlocked.count > 0 {
            for i in 1...(shipsUnlocked.count - 1){
                print("i:\(i)")
                print("shipsUnlocked[i]:\(shipsUnlocked[i])")
                if shipsUnlocked[i] == i{
                    allTheLevels[i].texture = SKTexture(imageNamed: levelColors[i-1])
                    print(allTheLevels[i].texture)
                }
            }
        }
        
    }
    func buyAnimation(what: SKSpriteNode){
        shakeCamera(layer: what, duration: 0.5)
        let delayInSeconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            let shoShipEmi = SKEmitterNode(fileNamed: "RockExplosion copy")!
            shoShipEmi.zPosition = 100000
            shoShipEmi.xScale = 0.5
            shoShipEmi.yScale = 0.5
            
            self.addChild(shoShipEmi)
            
            shoShipEmi.position = what.position
            shoShipEmi.alpha = 1
            shoShipEmi.run(SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeAlpha(to: 0, duration: 0.5), SKAction.run({
                shoShipEmi.removeFromParent()
            })]))
        }
        
        
    }
    func createPopUp(){
        popUpBg = SKSpriteNode(imageNamed: "Rectangle 1889")
        popUpBg.position = CGPoint(x: 0, y: 0)
        popUpBg.zPosition = 500
        popUpBg.size.height = self.size.height
        popUpBg.size.width = self.size.width
        popUpBg.alpha = 0.5
        self.addChild(popUpBg)
        
        PopUpBox = SKSpriteNode(imageNamed: "Group 567")
        PopUpBox.position = CGPoint(x: 0, y: 0)
        PopUpBox.zPosition = 505
        PopUpBox.setScale(0)
        self.addChild(PopUpBox)
        
        buyBtn = SKSpriteNode(imageNamed: "Group 565")
        buyBtn.position = CGPoint(x: 40, y: -80)
        buyBtn.zPosition = 510
        buyBtn.name = "buy"
        PopUpBox.addChild(buyBtn)
        
        xOutBtn = SKSpriteNode(imageNamed: "Group 566")
        xOutBtn.position = CGPoint(x: -40, y: -80)
        xOutBtn.zPosition = 510
        xOutBtn.name = "close"
        PopUpBox.addChild(xOutBtn)
        
        cost = SKLabelNode(text: "\(boxPrice) Gems")
        cost.fontColor = .black
        cost.fontName = "Bebas Neue"
        cost.fontSize = 55
        cost.verticalAlignmentMode = .center
        cost.position = CGPoint(x: 0, y: 2)
        PopUpBox.addChild(cost)
        
        
        PopUpBox.run(SKAction.scale(to: 1.4, duration: 0.2))
        PopUpBox.run(SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.3),SKAction.scale(to: 1.4, duration: 0.2)]))
        
        
    }
    func removePopUp(){
        popUpBg.removeFromParent()
        PopUpBox.removeFromParent()
        buyBtn.removeFromParent()
        xOutBtn.removeFromParent()
    }
    func createCreateandStuff(){
        
        shipWon = SKSpriteNode(imageNamed: avalibleShips[Int(arc4random_uniform(UInt32(avalibleShips.count)))])
        shipWon.position = CGPoint(x: 0, y: 0)
        shipWon.zPosition = 10
        
        baseBox = SKSpriteNode(imageNamed: "Group 439")
        baseBox.position = CGPoint(x: 0, y: 0)
        baseBox.zPosition = 5
        //self.addChild(baseBox)
        
        openBox = SKSpriteNode(imageNamed: "Group 440")
        openBox.position = CGPoint(x: 70, y: 115)
        openBox.zPosition = 5
        //self.addChild(openBox)
        
        purchaseBtn = SKSpriteNode(imageNamed: "Group 441")
        purchaseBtn.position = CGPoint(x: 0, y: -200)
        purchaseBtn.zPosition = 5
        purchaseBtn.name = "purchase"
        //self.addChild(purchaseBtn)
        
        
        let backBtn2 = SKSpriteNode(imageNamed: "backBtn")
        backBtn2.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 - 50)
        backBtn2.name = "back2"
        self.addChild(backBtn2)
        
        let nGems = String(UserDefaults.standard.integer(forKey: "Gems"))
        gemsText = SKLabelNode(text: nGems)
        gemsText.fontColor = .black
        gemsText.fontName = "Bebas Neue"
        gemsText.fontSize = 50
        gemsText.verticalAlignmentMode = .center
        gemsText.horizontalAlignmentMode = .left
        gemsText.position = CGPoint(x: self.size.width/2 - 110, y: self.size.height/2 - 50)
        self.addChild(gemsText)
        
        let gemsImage = SKSpriteNode(imageNamed: "Group 677")
        gemsImage.position = CGPoint(x: -25, y: 0)
        gemsImage.setScale(1.5)
        gemsText.addChild(gemsImage)
        
        gemsText.setScale(0.6)
        
        
    }
    
    
    override func didMove(to view: SKView) {
        
        
        
        print("the start")
        
        if let shipsUnlockedSave = UserDefaults.standard.array(forKey: "uShips") as? [Int] {
            
            //print("helloooooooo")
            shipsUnlocked = shipsUnlockedSave
        }
        
        if let unlocked = UserDefaults.standard.array(forKey: "unlockedShips") as? [String] {
            self.unlockedShips = unlocked
        } else {
            self.unlockedShips = ["myShip"]
            UserDefaults.standard.set(["myShip"], forKey: "unlockedShips")
        }
        
        if let selected = UserDefaults.standard.string(forKey: "selectedShip") {
            self.selectedShip = selected
        } else {
            UserDefaults.standard.set("myShip", forKey: "selectedShip")
            self.selectedShip = "myShip"
        }
        
        print(self.unlockedShips)
        
        if shipsUnlocked.count == 1{
            shipsUnlocked.append(1)
        }
        
        
        
        createCreateandStuff()
        createAllLevels()
        for i in 1...allTheLevels.count {
            if self.allTheLevels[i-1].xScale == 0 {
                self.allTheLevels[i - 1].run(SKAction.scale(to: 1.3, duration: 0.32))
            } else {
                self.allTheLevels[i - 1].run(SKAction.scale(to: 1.75, duration: 0.32))
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        let sprite = touchedNode as! SKNode
        
        
        if let name = touchedNode.name{
            let currentGems = UserDefaults.standard.integer(forKey: "Gems")
            
            if name == "purchase" {
                if currentGems >= self.boxPrice {
                    //self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                    self.playSound(s: "click1.mp3", wait: true)
                    openBox.run(SKAction.move(to: CGPoint(x: 0, y: 0) , duration: 1.0))
                    openBox.run(SKAction.scale(to: 2, duration: 1.0))
                    purchaseBtn.run(SKAction.scale(to: 0, duration: 0.8))
                    baseBox.run(SKAction.scale(to: 0, duration: 0.8))
                    let delayInSeconds = 1.0
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                        self.boxIsReadyToOpen = true
                    }
                    UserDefaults.standard.set(currentGems - self.boxPrice, forKey: "Gems")
                    self.scrollDownGemsText()
                }else{
                    //self.run(SKAction.playSoundFileNamed("wood-5.wav", waitForCompletion: true))
                    self.playSound(s: "wood-5.wav", wait: true)
                    print("Want to buy more gems?")
                }
                
                
            }
            if name == "back2" {
                //self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                self.playSound(s: "click2.mp3", wait: true)
                if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                    scene.scaleMode = .aspectFill
                    self.menuManager?.didReturnToMainMenu(scene: scene)
                    self.scene?.view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.lightGray, duration: 0.2))
                }
            }
            /*
            for i in 1...allTheLevels.count {
                if name == "\(i)" {
                    //if String(describing: sprite.texture!) == "<SKTexture> 'Group 555' (245 x 245)"{
                    if true {
                        if levelsUnlocked < 3 {
                            whatToBuy = i
                            boxPrice = 100 * i
                            createPopUp()
                            
                        }
                    }else{
                        selector.removeFromParent()
                        moveSelector(theParent: sprite)
                    }
                    
                }
            }*/
            if name.contains("locked") {
                boxPrice = 50 * Int(name.components(separatedBy: "/")[2])!
                self.pendingShipBuy = name.components(separatedBy: "/")[0]
                self.whatToBuy = Int(name.components(separatedBy: "/")[2])!
                createPopUp()
            } else {
                if let shape = sprite.childNode(withName: "circle") as? SKShapeNode {
                    shape.strokeColor = UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4)
                    if let c = self.selectedSprite.childNode(withName: "circle") as? SKShapeNode {
                        c.strokeColor = UIColor.black
                    }
                    self.selectedSprite = sprite
                    self.selectedShip = sprite.name!
                    UserDefaults.standard.set(sprite.name!, forKey: "selectedShip")
                } else {
                    if let n = sprite.name {
                        if n == "circle" {
                            if self.selectedShip != sprite.parent?.name {
                                let s = sprite as! SKShapeNode
                                s.strokeColor = UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4)
                                if let c = self.selectedSprite.childNode(withName: "circle") as? SKShapeNode {
                                    c.strokeColor = UIColor.black
                                }
                                self.selectedSprite = s.parent!
                                self.selectedShip = (s.parent?.name)!
                                UserDefaults.standard.set(self.selectedShip, forKey: "selectedShip")
                            }
                        }
                    }
                }
                
            }
            
            
            if name == "buy" {
                if currentGems >= self.boxPrice {
                    //self.run(SKAction.playSoundFileNamed("click1.mp3", waitForCompletion: true))
                    self.playSound(s: "click1.mp3", wait: true)
                    UserDefaults.standard.set(currentGems - self.boxPrice, forKey: "Gems")
                    self.scrollDownGemsText()
                    //shipsUnlocked.append(whatToBuy)
                    self.unlockedShips.append(self.pendingShipBuy)
                    //UserDefaults.standard.set(shipsUnlocked, forKey: "uShips")
                    UserDefaults.standard.set(self.unlockedShips, forKey: "unlockedShips")
                    print(shipsUnlocked)
                    buyAnimation(what: allTheLevels[whatToBuy + 1])
                    removePopUp()
                    let delayInSeconds2 = 0.5
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds2) {
                        
                        let ship = SKSpriteNode(imageNamed: self.shipOptions[self.whatToBuy])
                        ship.position = CGPoint(x: self.allTheLevels[self.whatToBuy + 1].position.x, y: self.allTheLevels[self.whatToBuy + 1].position.y)
                        ship.setScale(1.75)
                        ship.name = self.shipOptions[self.whatToBuy]
                        self.addChild(ship)
                        
                        let circle = SKShapeNode(circleOfRadius: 50 / 1.75)
                        circle.position = CGPoint(x: 0, y: 0)
                        circle.strokeColor = .black
                        circle.lineWidth = 8 / 1.75
                        circle.name = "circle"
                        ship.addChild(circle)
                        
                        let n = self.allTheLevels[self.whatToBuy + 1]
                        //self.allTheLevels[self.whatToBuy] = ship
                        n.removeFromParent()
                    }
                }else{
                    //self.run(SKAction.playSoundFileNamed("wood-5.wav", waitForCompletion: true))
                    self.playSound(s: "wood-5.wav", wait: true)
                    print("Want to buy more gems?")
                }
                
                
            }
            if name == "close" {
                //self.run(SKAction.playSoundFileNamed("click2.mp3", waitForCompletion: true))
                self.playSound(s: "click2.mp3", wait: true)
                removePopUp()
            }
            
            
        }
        if boxIsReadyToOpen{
            
            shakeCamera(layer: openBox, duration: 1.0)
            
            let delayInSeconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
                //self.run(SKAction.playSoundFileNamed("DeathSound.wav", waitForCompletion: true))
                self.playSound(s: "DeathSound.wav", wait: true)
                self.openBox.removeFromParent()
                let boxExplotion = SKEmitterNode(fileNamed: "AsteroidDie")!
                boxExplotion.targetNode = self.scene
                boxExplotion.zPosition = 20
                self.addChild(boxExplotion)
                //self.addChild(self.shipWon)
                self.boxIsReadyToOpen = false
            }
            
        }
    }
    func updateGems() {
        let nGems = String(UserDefaults.standard.integer(forKey: "Gems"))
        gemsText.text = nGems
    }
    
    func scrollDownGemsText() {
        
        self.run(SKAction.repeat(SKAction.sequence([SKAction.wait(forDuration: 1.0 / Double(self.boxPrice)), SKAction.run({
            self.gemsText.text = String(Int(self.gemsText.text!)! - 1)
        })]), count: self.boxPrice))
    }
    
    func playSound(s: String, wait: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            self.run(SKAction.playSoundFileNamed(s, waitForCompletion: wait))
        }
    }
}

