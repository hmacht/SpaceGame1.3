//
//  Level17Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 2/7/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level17Scene: GameScene {
    
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419", gravity: false)
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2.5)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: 0, y: sun.position.y + 500)
        self.addChild(sun2)
        sun2.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 0.5, duration: 0.01))
        
        _ = sun2.addOrbitingPlanet(radius: 200, planetImage: PlanetNames.whitePlanet, speed: 2.2)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: -300, y: sun2.position.y + 500)
        self.addChild(sun3)
        
        _ = sun3.addOrbitingPlanet(radius: 180, planetImage: PlanetNames.redPlanet, speed: 1.8)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: 300, y: sun3.position.y + 50)
        self.addChild(sun4)
        
        _ = sun4.addOrbitingPlanet(radius: 210, planetImage: PlanetNames.greenPlanet, speed: 2.3)
        
        var currentHeight = sun4.position.y
        var currentX: CGFloat = 0
        let radius = (self.size.width - 2 * sun4.size.width) / 3 - 20
        
        for i in 0...1 {
            currentHeight += 500
            currentX = -self.size.width/2 + CGFloat(i) * 75
            
            for j in 0...2 {
                let s = Sun(imageName: "Group 419")
                s.position = CGPoint(x: currentX, y: currentHeight)
                self.addChild(s)
                
                _ = s.addOrbitingPlanet(radius: radius, planetImage: "planet", speed: 1.7 + Double(i) * 0.15 + Double(j) * 0.15)
                currentX += self.size.width/2
            }
        }
        
        let sun5 = Sun(imageName: "Group 287")
        sun5.position = CGPoint(x: 0, y: currentHeight + 650)
        self.addChild(sun5)
        
        let p = sun5.addOrbitingPlanet(radius: 275, planetImage: PlanetNames.yellowPlanet, speed: 2.3)
        _ = p.addOrbitingPlanet(radius: 60, planetImage: "planet", speed: 0.8)
        
        
        // Finish line
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: sun5.position.y + 300)
        self.addChild(finish)
        
        self.gemPos = [CGPoint(x: sun2.position.x + 115, y: sun2.position.y), CGPoint(x: sun4.position.x - 115, y: sun4.position.y), CGPoint(x: sun5.position.x, y: sun5.position.y - 120)]
        self.createGemsForLevel(scene: self)
    }
}
