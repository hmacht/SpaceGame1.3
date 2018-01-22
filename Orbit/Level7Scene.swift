//
//  Level7Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/22/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level7Scene: GameScene {
    
    override func didMove(to view: SKView) {
        self.inLevel = true
        
        super.didMove(to: view)
        
        self.enableCameraFollow()
        
        let sun = Sun(imageName: "Group 419")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        let sun2 = Sun(imageName: "Group 419")
        sun2.position = CGPoint(x: -150, y: 500)
        self.addChild(sun2)
        
        sun2.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 3)
        
        let sun3 = Sun(imageName: "Group 419")
        sun3.position = CGPoint(x: 150, y: 900)
        self.addChild(sun3)
        
        sun3.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 1.75)
        
        let sun4 = Sun(imageName: "Group 419")
        sun4.position = CGPoint(x: -100, y: 1300)
        self.addChild(sun4)
        
        sun4.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        let sun5 = Sun(imageName: "Group 419")
        sun5.position = CGPoint(x: 0, y: 1800)
        self.addChild(sun5)
        
        sun5.addOrbitingPlanet(radius: 200, planetImage: "Ellipse 8533", speed: 2)
        
        let sun6 = Sun(imageName: "Group 419")
        sun6.position = CGPoint(x: self.size.width/2, y: 1800)
        self.addChild(sun6)
        
        sun6.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 1.9)
        
        let sun7 = Sun(imageName: "Group 419")
        sun7.position = CGPoint(x: -self.size.width/2, y: 1800)
        self.addChild(sun7)
        
        sun7.addOrbitingPlanet(radius: 150, planetImage: "planet", speed: 2.3)
        
        let finishLine = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finishLine.position = CGPoint(x: 0, y: 2100)
        self.addChild(finishLine)
    }
}
