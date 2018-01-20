//
//  LevelSelectViewController.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import UIKit
import SpriteKit

protocol MenuManager {
    func didPressPlay()
    func didPressEndless(level: Int)
    func didReturnToMainMenu(scene: LevelSelectScene)
}

class LevelSelectViewController: UIViewController, MenuManager {

    var selectedLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        if let view = self.view as! SKView? {
            print("Hello")
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "LevelSelect") as? LevelSelectScene {
                // Set the scale mode to scale to fit the window
                scene.menuManager = self
                scene.playBgMusic = true
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
    
    func didPressPlay() {
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "LevelMenuScene") as? LevelMenuScene {
                scene.menuManager = self
                view.presentScene(scene)
            }
        }
    }
    
    func didPressEndless(level: Int) {
        self.selectedLevel = level
        self.performSegue(withIdentifier: "toGameScene", sender: self)
    }
    
    func didReturnToMainMenu(scene: LevelSelectScene) {
        scene.menuManager = self
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
