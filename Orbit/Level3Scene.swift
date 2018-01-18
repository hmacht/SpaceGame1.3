//
//  Level3Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/16/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level3Scene: GameScene {
    
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        // Finish line
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
        let circle1 = UIBezierPath(center: sun.position, radius: 200)
        planet1.orbit(path: circle1.cgPath, speed: 2)
        
        let planet2 = Planet(imageName: "planet")
        planet2.position = CGPoint(x: 0, y: 0)
        self.addChild(planet2)
        let circle2 = UIBezierPath(center: sun.position, radius: 300)
        planet2.orbit(path: circle2.cgPath, speed: 4)
        
        // Second sun
        let sun2 = Sun(imageName: "Moon")
        sun2.position = CGPoint(x: 0, y: self.size.height/2)
        self.addChild(sun2)
        
        // Second planet
        let planet3 = Planet(imageName: "planet")
        planet3.position = CGPoint(x: 0, y: 0)
        self.addChild(planet3)
        let circle3 = UIBezierPath(center: sun2.position, radius: 200)
        planet3.orbit(path: circle3.cgPath, speed: 2)
        
    }
}


