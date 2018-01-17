//
//  Level2Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level2Scene: GameScene {
    
    let proximityToLaunchAsteroid: CGFloat = 400
    var asteroidYPositions = [CGFloat]()
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        
        
        // Finish Line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: self.size.height - finish.size.height)
        self.addChild(finish)
        
        // First sun
        let sun = Sun(imageName: "Moon")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        // First planets
        let planet1 = Planet(imageName: "planet")
        planet1.position = CGPoint(x: 0, y: 0)
        self.addChild(planet1)
        let circle1 = UIBezierPath(ovalIn: CGRect(x: -200, y: -250, width: 400, height: 500))
        planet1.orbit(path: circle1.cgPath, speed: 2)
        
        // Level has camera
        self.enableCameraFollow()
        
        asteroidYPositions.append(200)
        asteroidYPositions.append(500)
        asteroidYPositions.append(600)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        for asteroidY in asteroidYPositions {
            if abs(asteroidY - usersShip.position.y) < self.proximityToLaunchAsteroid {
                self.createAsteroid(startPointY: asteroidY, endPointY: asteroidY + 200)
                self.asteroidYPositions.remove(at: 0)
            }
        }
    }

}
