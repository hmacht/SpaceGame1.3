//
//  Level11Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/1/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level11Scene: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419", gravity: false)
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        // First planets
        let planet1 = Planet(imageName: "planet")
        planet1.position = CGPoint(x: 0, y: 0)
        self.addChild(planet1)
        //let circle1 = UIBezierPath(ovalIn: CGRect(x: -200, y: -200, width: 400, height: 400))
        let circle1 = UIBezierPath(center: sun.position, radius: 200)
        planet1.orbit(path: circle1.cgPath, speed: 2)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: 0, y: self.size.height/2)
        self.addChild(sun2)
        
        let p = sun2.addOrbitingPlanet(radius: 350, planetImage: PlanetNames.redPlanet, speed: 3)
        _ = p.addOrbitingPlanet(radius: 100, planetImage: "planet", speed: 1)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 0, y: sun2.position.y + self.size.height * 0.75)
        self.addChild(sun3)
        
        let p2 = sun3.addOrbitingPlanet(radius: 350, planetImage: PlanetNames.greenPlanet, speed: 2.9)
        _ = p2.addOrbitingPlanet(radius: 100, planetImage: PlanetNames.yellowPlanet, speed: 1)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun3.position.y + 600)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: 0, y: sun2.position.y - 115), CGPoint(x: 0, y: sun2.position.y + self.size.height/2), CGPoint(x: 0, y: sun3.position.y + 115)]
        self.createGemsForLevel(scene: self)
    }
    
}
