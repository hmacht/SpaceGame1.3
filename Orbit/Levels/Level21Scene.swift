//
//  Level21Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 3/9/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level21Scene: GameScene {
    override func didMove(to view: SKView) {
        
        self.inLevel = true
        
        super.didMove(to: view)
        
        // Set up level
        self.enableCameraFollow()
        
        
        // First sun
        let sun = Sun(imageName: "Group 419", gravity: false)
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        _ = sun.addOrbitingPlanet(radius: 200, planetImage: "planet", speed: 2)
        
        let blackHole = BlackHole(imageName: "Group 767")
        blackHole.position = CGPoint(x: 0, y: 650)
        self.addChild(blackHole)
        
        let finish = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
        finish.position = CGPoint(x: 0, y: self.size.height/2 + 300)
        self.addChild(finish)
        
        let label = SKLabelNode(fontNamed: "Bebas Neue")
        label.text = "Watch out for black holes!"
        label.fontColor = UIColor.black
        label.position = CGPoint(x: 0, y: -300)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.fontSize = 45
        self.addChild(label)
        
        
        self.gemPos = [CGPoint(x: 0, y: 200), CGPoint(x: 250, y: 500), CGPoint(x: -250, y: 600)]
        self.createGemsForLevel(scene: self)
    }
}
