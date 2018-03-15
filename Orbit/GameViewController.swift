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
import AVFoundation

protocol GameManager {
    func returnToMenu()
    func nextLevel()
}

class GameViewController: UIViewController, GameManager {
    
    var selectedLevel = 0
    
    var sceneArray = ["GameScene"]
    var bgSoundPlayer: AVAudioPlayer?
    var selectedMode = GameMode.normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...25 {
            sceneArray.append("Level\(i)")
        }
        
        let s = sceneArray[selectedLevel]
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: s) as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.gameManager = self
                scene.level = self.selectedLevel
                scene.gameMode = self.selectedMode
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            playBGMusic()
        }
    }
    
    func playBGMusic() {
        
        let fileURL:URL = Bundle.main.url(forResource:"OrbitBGMusic", withExtension: "mp3")!
        
        //basically, try to initialize the bgSoundPlayer with the contents of the URL
        do {
            bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch _{
            bgSoundPlayer = nil
        }
        
        bgSoundPlayer?.volume = 0.25 //set the volume anywhere from 0 to 1
        bgSoundPlayer?.numberOfLoops = -1 // -1 makes the player loop forever
        bgSoundPlayer?.prepareToPlay() //prepare for playback by preloading its buffers.
        bgSoundPlayer?.play() //actually play
    }
    
    func returnToMenu() {
        bgSoundPlayer?.stop()
        self.navigationController?.popViewController(animated: true)
    }
    
    func nextLevel() {
        self.selectedLevel += 1
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "Level\(self.selectedLevel)") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.gameManager = self
                scene.level = self.selectedLevel
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
        }
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
