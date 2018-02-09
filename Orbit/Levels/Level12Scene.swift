//
//  Level12Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/3/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level12Scene: GameScene {
    
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -200, y: self.size.height/2)
        self.addChild(sun2)
        
        let p = sun2.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.greenPlanet, speed: 3)
        _ = p.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 1)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 150, y: sun2.position.y + 450)
        self.addChild(sun3)
        
        sun3.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.8)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 0, y: sun3.position.y + 500)
        self.addChild(sun4)
        
        sun4.addOrbitingPlanet(radius: 200, planetImage: PlanetNames.yellowPlanet, speed: 1.7)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: -self.size.width/2, y: sun4.position.y + 500)
        self.addChild(sun5)
        
        sun5.addOrbitingPlanet(radius: 125, planetImage: "planet", speed: 2)
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: 0, y: sun4.position.y + 500)
        self.addChild(sun6)
        
        sun6.addOrbitingPlanet(radius: 175, planetImage: PlanetNames.whitePlanet, speed: 2.2)
        
        let sun7 = Sun(imageName: "Group 419")
        sun7.position = CGPoint(x: self.size.width/2, y: sun4.position.y + 500)
        self.addChild(sun7)
        
        sun7.addOrbitingPlanet(radius: 125, planetImage: "planet", speed: 1.8)
        
        let sun8 = Sun(imageName: "Group 419")
        sun8.position = CGPoint(x: 0, y: sun7.position.y + 600)
        self.addChild(sun8)
        
        sun8.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 2.4)
        sun8.addOrbitingPlanet(radius: 250, planetImage: PlanetNames.greenPlanet, speed: 2)
        
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun8.position.y + 500)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: 0, y: sun2.position.y + 115), CGPoint(x: sun4.position.x - 115, y: sun4.position.y ), CGPoint(x: 0, y: sun8.position.y - 115)]
        self.createGemsForLevel(scene: self)
    }
    
}

