//
//  Level5Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/20/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level5Scene: GameScene {
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
        
        let planet2 = Planet(imageName: "planet")
        planet2.position = CGPoint(x: 0, y: 0)
        self.addChild(planet2)
        let circle2 = UIBezierPath(center: sun.position, radius: 175)
        planet2.orbit(path: circle2.cgPath, speed: 2.5)
        
        // Second sun
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -self.size.width/2 + 50, y: self.size.height/2 * 0.75)
        self.addChild(sun2)
        
        // Second planet
        let planet3 = Planet(imageName: "planet")
        planet3.position = CGPoint(x: 0, y: 0)
        self.addChild(planet3)
        let circle3 = UIBezierPath(center: sun2.position, radius: 200)
        planet3.orbit(path: circle3.cgPath, speed: 2)
        
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: self.size.width/2 - 50, y: sun2.position.y)
        self.addChild(sun3)
        
        let planet4 = Planet(imageName: "Ellipse 8535")
        self.addChild(planet4)
        let circle4 = UIBezierPath(center: sun3.position, radius: 300)
        planet4.orbit(path: circle4.cgPath, speed: 2.5)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 0, y: sun3.position.y + 500)
        self.addChild(sun4)
        
        let planet5 = Planet(imageName: "Ellipse 8534")
        self.addChild(planet5)
        let circle5 = UIBezierPath(center: sun4.position, radius: 250)
        planet5.orbit(path: circle5.cgPath, speed: 2.5)
        
        self.gemPos = [CGPoint(x: 200, y: 0), CGPoint(x: 0, y: 300), CGPoint(x: 0, y: sun4.position.y + 120)]
        self.createGemsForLevel(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let deltaTime = currentTime - lastUpdateTime
        self.timeSinceLastSpawn += CGFloat(deltaTime)
        
        if self.timeSinceLastSpawn > self.timeInBetweenSpawns && self.scene!.speed > CGFloat(0) {
            self.timeSinceLastSpawn = 0
            self.createAsteroid(startPointY: usersShip.position.y + 425 + CGFloat(arc4random_uniform(100)), endPointY: nil)
        }
        super.update(currentTime)
    }
}
