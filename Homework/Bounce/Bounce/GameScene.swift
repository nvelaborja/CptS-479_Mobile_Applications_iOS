//
//  GameScene.swift
//  Bounce
//
//  Created by Nathan VelaBorja on 4/9/17.
//  Copyright © 2017 Nathan VelaBorja. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var redBallNode: SKSpriteNode!
    var greenBallNode: SKSpriteNode!
    var startStopLabel: SKLabelNode!
    var bounceSFX: SKAction!
    var breakSFX: SKAction!
    var audioPlayer: AVAudioPlayer!
    var vc: GameViewController!
    var stopped: Bool = true
    
    override func didMove(to view: SKView) {
        
        // Make walls bouncy
        let screenPhysicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        screenPhysicsBody.friction = 0.0
        screenPhysicsBody.categoryBitMask = 0b100
        screenPhysicsBody.collisionBitMask = 0b111
        screenPhysicsBody.contactTestBitMask = 0b001
        self.physicsBody = screenPhysicsBody
        self.name = "Wall";
        
        redBallNode = self.childNode(withName: "RedBall") as! SKSpriteNode
        startStopLabel = self.childNode(withName: "StartStop") as! SKLabelNode
        
        physicsWorld.contactDelegate = self
        
        self.initGame()
    }
    
    func initGame() {
        // Load sound effects
        bounceSFX = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false)
        breakSFX = SKAction.playSoundFileNamed("glassbreak.mp3", waitForCompletion: false)
        
        // Load music player
        let backgroundURL = Bundle.main.url(forResource: "WSU-Fight-Song.mp3", withExtension: nil);
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: backgroundURL!)
        } catch {
            print("Could not load WSU-Fight-Song.mp3")
        }
        audioPlayer.volume = 0.1
        audioPlayer.numberOfLoops = -1
        
        
        // Initialize settings
        if (UserDefaults.standard.object(forKey: "music") == nil) {
            UserDefaults.standard.set(true, forKey: "music")
        }
        
        if (UserDefaults.standard.object(forKey: "sfx") == nil) {
            UserDefaults.standard.set(true, forKey: "sfx")
        }
    }
    
    func addGreenBall(_ position: CGPoint) {
        // Add green ball programmatically
        greenBallNode = SKSpriteNode(imageNamed: "Ball_Green")
        greenBallNode.name = "GreenBall"
        greenBallNode.physicsBody = SKPhysicsBody(circleOfRadius: 50.0)
        greenBallNode.physicsBody?.affectedByGravity = false
        greenBallNode.physicsBody?.friction = 0.0
        greenBallNode.physicsBody?.restitution = 1.0
        greenBallNode.physicsBody?.linearDamping = 0.0
        greenBallNode.physicsBody?.categoryBitMask = 0b100
        greenBallNode.physicsBody?.collisionBitMask = 0b110
        greenBallNode.physicsBody?.contactTestBitMask = 0b001
        greenBallNode.position = position
        self.addChild(greenBallNode)
    }
    
    func startGame() {
        self.isPaused = false
        self.startStopLabel.text = "Stop"
        stopped = false
        redBallNode.physicsBody?.applyImpulse(CGVector(dx: 200.0, dy: 200.0))
    }
    
    func pauseGame() {
        self.isPaused = true
        self.startStopLabel.text = "Start"
        stopped = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var buttonPressed = false
        
        for touch in touches {
            let point = touch.location(in: self)
            let nodeArray = nodes(at: point)
            
            for node in nodeArray {
                if node.name == "StartStop" {
                    buttonPressed = true
                    if (self.isPaused) {
                        self.startGame()
                        playBackgroundMusic()
                    } else {
                        self.pauseGame()
                        pauseBackgroundMusic()
                    }
                }
                
                if node.name == "settingsButton" {
                    vc.performSegue(withIdentifier: "showSettingsSegue", sender: self)
                }
            }
        }
        
        if (!buttonPressed) {
            for touch in touches {
                addGreenBall(touch.location(in: self))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyNameA = String(describing: contact.bodyA.node?.name)
        let bodyNameB = String(describing: contact.bodyB.node?.name)
        print("Contact: \(bodyNameA), \(bodyNameB)")
        
        // If either contact body is a green ball, remove it from the scene
        if (bodyNameA.contains("GreenBall")) {
            playBreakSFX()
            let bodyA = contact.bodyA.node!
            bodyA.removeFromParent()
        }
        
        if (bodyNameB.contains("GreenBall")) {
            playBreakSFX()
            let bodyB = contact.bodyB.node!
            bodyB.removeFromParent()   
        }
        
        // If contact is between RedBall and Wall, play bounce sound
        let contactString = bodyNameA + bodyNameB;
        if (contactString.contains("RedBall") && contactString.contains("Wall")) {
            playBounceSFX()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func playBackgroundMusic() {
        if (UserDefaults.standard.bool(forKey: "music") == true) {
            audioPlayer.play()
        }
    }
    
    func pauseBackgroundMusic() {
        audioPlayer.pause()
    }
    
    func playBounceSFX() {
        if (UserDefaults.standard.bool(forKey: "sfx") == true) {
            run(bounceSFX)
        }
    }
    
    func playBreakSFX() {
        if (UserDefaults.standard.bool(forKey: "sfx") == true) {
            run(breakSFX)
        }
    }
}
