//
//  LevelSelectViewController.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import UIKit
import SpriteKit

class LevelSelectViewController: UIViewController {

    var selectedLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let view = self.view as! SKView? {
            print("Hello")
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "LevelSelect") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                
                view.presentScene(scene)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! GameViewController
        destination.selectedLevel = self.selectedLevel
    }
 
    
    @IBAction func levelButtonPressed(_ sender: Any) {
        let s = sender as! UIButton
        self.selectedLevel = s.tag
        self.performSegue(withIdentifier: "toGameScene", sender: self)
    }
    

}
