//
//  Level13Scene.swift
//  Orbit
//
//  Created by Henry Macht on 2/4/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level13Scene: GameScene {

    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Ellipse 8950")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        
        let sun2 = Sun(imageName: "Ellipse 8950")
        sun2.position = CGPoint(x: 0, y: sun.position.y + 1000)
        self.addChild(sun2)
        
        let p = sun2.addOrbitingPlanet(radius: 400, planetImage: PlanetNames.greenPlanet, speed: 2)
        let p2 = p.addOrbitingPlanet(radius: 100, planetImage: "planet", speed: 0.8)
        p2.setScale(0.8)
        let p3 = p2.addOrbitingPlanet(radius: 80, planetImage: PlanetNames.redPlanet, speed: 0.4)
        let p4 = p3.addOrbitingPlanet(radius: 50, planetImage: PlanetNames.yellowPlanet, speed: 0.3)
        p4.setScale(0.4)
        
        
        
        let sun3 = Sun(imageName: "Ellipse 8950")
        sun3.position = CGPoint(x: -250, y: sun2.position.y + 900)
        self.addChild(sun3)
        
        sun3.addOrbitingPlanet(radius: 200, planetImage: PlanetNames.yellowPlanet, speed: 5.5)
        
        let sun4 = Sun(imageName: "Ellipse 8950")
        sun4.position = CGPoint(x: 350, y: sun2.position.y + 900)
        self.addChild(sun4)
        
        sun4.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.redPlanet, speed: 5.5)
        
        
        
        
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun4.position.y + 300)
        self.addChild(finish)
    }
    
    
    
}
