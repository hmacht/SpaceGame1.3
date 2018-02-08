//
//  Level20Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/8/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level20Scene: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -268, y: sun.position.y + 500)
        self.addChild(sun2)
        
        _ = sun2.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 1.8)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 183, y: sun2.position.y + 475)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 200, planetImage: PlanetNames.greenPlanet, speed: 2.1)
        
        let sun4 = Sun(imageName: "Group 287")
        sun4.position = CGPoint(x: 97, y: sun3.position.y + 523)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 180, planetImage: PlanetNames.yellowPlanet, speed: 2.3)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: self.size.width/2, y: sun4.position.y + 600)
        self.addChild(sun5)
        
        _ = sun5.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.whitePlanet, speed: 1.8)
        _ = sun5.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 2.2)
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: -self.size.width/2, y: sun5.position.y + 750)
        self.addChild(sun6)
        
        _ = sun6.addOrbitingPlanet(radius: 350, planetImage: PlanetNames.bigBlue, speed: 2.5)
        let p = sun6.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.redPlanet, speed: 2)
        p.setScale(1.5)
        let p2 = sun6.addOrbitingPlanet(radius: 150, planetImage: PlanetNames.greenPlanet, speed: 1.5)
        p2.setScale(1)
        
        let sun7 = Sun(imageName: "Group 419")
        sun7.position = CGPoint(x: 250, y: sun6.position.y + 700)
        self.addChild(sun7)
        
        _ = sun7.addOrbitingPlanet(radius: 175, planetImage: "planet", speed: 2.2)
        
        let sun8 = Sun(imageName: "Group 419")
        sun8.position = CGPoint(x: 0, y: sun7.position.y + 400)
        self.addChild(sun8)
        
        _  = sun8.addOrbitingPlanet(radius: 165, planetImage: PlanetNames.yellowPlanet, speed: 1.7)
        
        let sun9 = Sun(imageName: "Group 419")
        sun9.position = CGPoint(x: -self.size.width/2 - 20, y: sun8.position.y - 100)
        self.addChild(sun9)
        
        _ = sun9.addOrbitingPlanet(radius: 160, planetImage: PlanetNames.redPlanet, speed: 2)
        
        let sun10 = Sun(imageName: "Group 287")
        sun10.position = CGPoint(x: 0, y: sun8.position.y + 600)
        self.addChild(sun10)
        
        let p3 = sun10.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.greenPlanet, speed: 2)
        _ = p3.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 0.7)
        
        let sun11 = Sun(imageName: "Group 419")
        sun11.position = CGPoint(x: -350, y: sun10.position.y + 700)
        self.addChild(sun11)
        
        _ = sun11.addOrbitingPlanet(radius: 225, planetImage: PlanetNames.whitePlanet, speed: 2)
        
        let sun12 = Sun(imageName: "Group 419")
        sun12.position = CGPoint(x: 350, y: sun11.position.y + 10)
        self.addChild(sun12)
        
        _ = sun12.addOrbitingPlanet(radius: 250, planetImage: "planet", speed: 1.8)
        
        let sun13 = Sun(imageName: "Group 287")
        sun13.position = CGPoint(x: 0, y: sun12.position.y + 800)
        self.addChild(sun13)
        
        _ = sun13.addOrbitingPlanet(radius: 400, planetImage: PlanetNames.redPlanet, speed: 3)
        _ = sun13.addOrbitingPlanet(radius: 280, planetImage: PlanetNames.whitePlanet, speed: 2.6)
        _ = sun13.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.7)
        
        let sun14 = Sun(imageName: "Group 419")
        sun14.position = CGPoint(x: self.size.width/2, y: sun13.position.y + 750)
        self.addChild(sun14)
        
        let p4 = sun14.addOrbitingPlanet(radius: 275, planetImage: PlanetNames.yellowPlanet, speed: 1.8)
        _ = p4.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 1)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun14.position.y + 500)
        self.addChild(finish)
        
        let label = SKLabelNode(fontNamed: "Bebas Neue")
        label.text = "Galaxy 2"
        label.fontColor = UIColor.black
        label.position = CGPoint(x: 0, y: 0)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.fontSize = 60
        finish.addChild(label)
        
        
        self.gemPos = [CGPoint(x: sun4.position.x - 115, y: sun4.position.y), CGPoint(x: sun10.position.x, y: sun10.position.y - 115), CGPoint(x: sun14.position.x - 50, y: sun14.position.y - 115)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns {
            for i in 0...4 {
                let wait = SKAction.wait(forDuration: 4.0 / Double(arc4random_uniform(5) + 1))
                
                self.run(SKAction.sequence([wait, SKAction.run({
                    self.createAsteroid(startPointY: self.usersShip.position.y + 525 + CGFloat(arc4random_uniform(200)), endPointY: nil)
                })]))
                self.timeSinceLastSpawn = 0
            }
        }
        super.update(currentTime)
    }
}
