//
//  GameViewController.swift
//  Orbit
//
//  Created by Henry Macht on 12/8/17.
//  Copyright © 2017 10-12. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameManager {
    func returnToMenu()
}

class GameViewController: UIViewController, GameManager {
    
    var selectedLevel = 0
    
    let sceneArray = ["GameScene", "Level1", "Level2", "Level3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = sceneArray[selectedLevel]
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: s) as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.gameManager = self
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }
    
    
    func returnToMenu() {
        self.navigationController?.popViewController(animated: true)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
