//
//  Level6Scene.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/20/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import SpriteKit

class Level6Scene: GameScene {
    
    override func didMove(to view: SKView) {
        self.inLevel = true
        super.didMove(to: view)
        self.enableCameraFollow()
        
        let sun = Sun(imageName: "Group 287")
        sun.position = CGPoint.zero
        self.addChild(sun)
        
        for i in 1...9 {
            var pImage = "planet"
            if i == 5 {
                // Jupiter
                pImage = "Ellipse 8535"
            } else if i == 6 {
                // Saturn
                pImage = "Ellipse 8534"
            }
            let p = Planet(imageName: pImage)
            self.addChild(p)
            let orbit = UIBezierPath(center: sun.position, radius: 150 * CGFloat(i))
            p.orbit(path: orbit.cgPath, speed: 1.5 * Double(i))
            
            if i == 9 {
                let finishLine = FinishLine(color: UIColor(red: 0, green: 222/255, blue: 0, alpha: 0.4), size: CGSize(width: self.size.width, height: 100))
                finishLine.position = CGPoint(x: 0, y: 150 * CGFloat(i) + 300)
                self.addChild(finishLine)
            }
        }
    }
}
