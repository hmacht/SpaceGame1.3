//
//  LevelSelectViewController.swift
//  Orbit
//
//  Created by Toby Kreiman on 1/15/18.
//  Copyright © 2018 10-12. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

protocol MenuManager {
    func didPressPlay()
    func didPressEndless(level: Int)
    func didReturnToMainMenu(scene: LevelSelectScene)
    func stopMusic()
    func startMusic()
}

class LevelSelectViewController: UIViewController, MenuManager {

    var selectedLevel = 0
    var bgSoundPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = UserDefaults.standard.string(forKey: "selectedShip") {
            
        } else {
            UserDefaults.standard.set("myShip", forKey: "selectedShip")
            UserDefaults.standard.set(true, forKey: "soundOn")
            UserDefaults.standard.set(true, forKey: "vibrationOn")
        }
        
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
    
    func playBGMusic() {
        
        let fileURL:URL = Bundle.main.url(forResource:"bgMusic3", withExtension: "mp3")!
        
        //basically, try to initialize the bgSoundPlayer with the contents of the URL
        do {
            bgSoundPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch _{
            bgSoundPlayer = nil
        }
        
        bgSoundPlayer?.volume = 0.75 //set the volume anywhere from 0 to 1
        bgSoundPlayer?.numberOfLoops = -1 // -1 makes the player loop forever
        bgSoundPlayer?.prepareToPlay() //prepare for playback by preloading its buffers.
        bgSoundPlayer?.play() //actually play
    }
    
    func stopMusic() {
        bgSoundPlayer?.stop()
    }
    
    func startMusic() {
        self.playBGMusic()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "soundOn") {
            self.playBGMusic()
        }
        if let view = self.view as! SKView? {
            if let scene = view.scene as? LevelSelectScene {
                scene.updateHighScore()
                scene.updateGems()
            }
            
            if let scene = view.scene as? LevelMenuScene {
                if scene.children.count > 0 {
                    scene.durationToOpen = 0
                }
                scene.removeAllChildren()
                scene.didMove(to: view)
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
        bgSoundPlayer?.stop()
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
                //let transition = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                view.presentScene(scene) //, transition: transition
                
                
                
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
