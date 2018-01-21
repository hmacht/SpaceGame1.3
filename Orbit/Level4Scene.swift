//
//  Level4Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/20/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level4Scene: GameScene {
    
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        
        // Finish line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: 600 + self.size.height - finish.size.height)
        self.addChild(finish)
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        let planet2 = Planet(imageName: "Ellipse 8533")
        planet2.position = CGPoint(x: 0, y: 0)
        self.addChild(planet2)
        let circle2 = UIBezierPath(center: sun.position, radius: 300)
        planet2.orbit(path: circle2.cgPath, speed: 3.5)
        
        // Second sun
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: 0, y: self.size.height/2)
        self.addChild(sun2)
        
        // Second planet
        let planet3 = Planet(imageName: "planet")
        planet3.position = CGPoint(x: 0, y: 0)
        self.addChild(planet3)
        let circle3 = UIBezierPath(center: sun2.position, radius: 200)
        planet3.orbit(path: circle3.cgPath, speed: 2)
        
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: -self.size.width/2 + 50, y: sun2.position.y + 500)
        self.addChild(sun3)
        
        let planet4 = Planet(imageName: "Ellipse 8535")
        self.addChild(planet4)
        let circle4 = UIBezierPath(center: sun3.position, radius: 300)
        planet4.orbit(path: circle4.cgPath, speed: 2.5)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns {
            self.timeSinceLastSpawn = 0
            self.createAsteroid(startPointY: usersShip.position.y + 425 + CGFloat(arc4random_uniform(100)), endPointY: nil)
        }
        super.update(currentTime)
    }
}
