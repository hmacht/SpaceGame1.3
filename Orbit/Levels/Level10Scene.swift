//
//  Level10Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/1/18.
//  Copyright © 2018 10-12. All rights reserved.
//


public struct PlanetNames {
    static let redPlanet = "Ellipse 8535"
    static let yellowPlanet = "Ellipse 8534"
    static let greenPlanet = "Ellipse 8533"
    static let whitePlanet = "Ellipse 8552"
    static let bigBlue = "Ellipse 8538"
}

import SpriteKit

class Level10Scene: GameScene {
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -self.size.width/4, y: 425)
        self.addChild(sun2)
        
        sun2.addOrbitingPlanet(radius: 170, planetImage: PlanetNames.redPlanet, speed: 2.2)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 0, y: sun2.position.y + 450)
        self.addChild(sun3)
        
        sun3.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 1.8)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: self.size.width/2, y: sun3.position.y + 500)
        self.addChild(sun4)
        
        sun4.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.yellowPlanet, speed: 1.8)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: -self.size.width/2, y: sun4.position.y)
        self.addChild(sun5)
        
        sun5.addOrbitingPlanet(radius: 225, planetImage: PlanetNames.whitePlanet, speed: 1.7)
        
        let sun6 = Sun(imageName: "Group 287")
        sun6.position = CGPoint(x: 0, y: sun5.position.y + 300)
        self.addChild(sun6)
        
        let sun7 = Sun(imageName: "Group 419")
        sun7.position = CGPoint(x: 150, y: sun6.position.y + 425)
        self.addChild(sun7)
        
        sun7.addOrbitingPlanet(radius: 180, planetImage: "planet", speed: 3)
        
        let sun8 = Sun(imageName: "Group 419")
        sun8.position = CGPoint(x: -self.size.width/2, y: sun7.position.y + 200)
        self.addChild(sun8)
        
        sun8.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.greenPlanet, speed: 2)
        
        let sun9 = Sun(imageName: "Group 419")
        sun9.position = CGPoint(x: self.size.width/2, y: sun8.position.y + 200)
        self.addChild(sun9)
        
        sun9.addOrbitingPlanet(radius: 200, planetImage: PlanetNames.whitePlanet, speed: 2.5)
        
        let sun10 = Sun(imageName: "Group 419")
        sun10.position = CGPoint(x: 0, y: sun9.position.y + 500)
        self.addChild(sun10)
        
        sun10.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 1.8)
        
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun10.position.y + 350)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun3.position.x + 115, y: sun3.position.y), CGPoint(x: sun6.position.x, y: sun6.position.y + 115), CGPoint(x: sun10.position.x, y: sun10.position.y - 120)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            for i in 0...2 {
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

