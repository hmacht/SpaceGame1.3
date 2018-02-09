//
//  Level18Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/7/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level18Scene: GameScene {
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2.5)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -175, y: sun.position.y + 500)
        self.addChild(sun2)
        sun2.run(SKAction.colorize(with: UIColor.orange, colorBlendFactor: 0.5, duration: 0.01))
        
        _ = sun2.addOrbitingPlanet(radius: 275, planetImage: PlanetNames.greenPlanet, speed: 2.2)
        _ = sun2.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.6)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: -300, y: sun2.position.y + 600)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 180, planetImage: PlanetNames.yellowPlanet, speed: 1.8)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 300, y: sun3.position.y - 50)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 210, planetImage: PlanetNames.redPlanet, speed: 2.3)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: 100, y: sun3.position.y + 700)
        self.addChild(sun5)
        
        _ = sun5.addOrbitingPlanet(radius: 360, planetImage: PlanetNames.yellowPlanet, speed: 2.6)
        let p = sun5.addOrbitingPlanet(radius: 245, planetImage: PlanetNames.whitePlanet, speed: 2)
        p.setScale(1)
        _ = sun5.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.5)
        
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: -250, y: sun5.position.y + 750)
        self.addChild(sun6)
        
        let p3 = sun6.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.redPlanet, speed: 2.6)
        _ = p3.addOrbitingPlanet(radius: 50, planetImage: "planet", speed: 1)
        let p2 = sun6.addOrbitingPlanet(radius: 150, planetImage: PlanetNames.greenPlanet, speed: 2)
        p2.setScale(1)
        
        let sun7 = Sun(imageName: "Group 287")
        sun7.position = CGPoint(x: self.size.width/2, y: sun6.position.y + 600)
        self.addChild(sun7)
        
        _ = sun7.addOrbitingPlanet(radius: 300, planetImage: PlanetNames.whitePlanet, speed: 2.2)
        
        let sun8 = Sun(imageName: "Group 419")
        sun8.position = CGPoint(x: -self.size.width/2, y: sun7.position.y + 400)
        self.addChild(sun8)
        
        _ = sun8.addOrbitingPlanet(radius: 450, planetImage: PlanetNames.yellowPlanet, speed: 2.4)
        
        // Finish line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun8.position.y + 550)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun2.position.x + 115, y: sun2.position.y), CGPoint(x: sun5.position.x - 115, y: sun5.position.y), CGPoint(x: sun7.position.x, y: sun7.position.y - 120)]
        self.createGemsForLevel(scene: self)
    }
}
