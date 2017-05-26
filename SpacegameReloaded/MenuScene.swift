//
//  MenuScene.swift
//  SpacegameReloaded
//
//  Created by Yulminator on 5/25/17.
//  Copyright © 2017 YuraPetrov. All rights reserved.
//

import SpriteKit 

class MenuScene: SKScene {

    var starfield: SKEmitterNode!
    
    var newGameButtonNode: SKSpriteNode!
    var difficultyButtonNode: SKSpriteNode!
    var difficultyLabelNode: SKLabelNode!
    
    var livesArray: [SKSpriteNode]!
    
    override func didMove(to view: SKView) {
        starfield = childNode(withName: "starfield") as! SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = childNode(withName: "newGameButton") as! SKSpriteNode
        difficultyButtonNode = childNode(withName: "difficultyButton") as! SKSpriteNode
        
        difficultyButtonNode.texture = SKTexture(imageNamed: "difficultyButton")
        
        difficultyLabelNode = childNode(withName: "difficultyLabel") as! SKLabelNode
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.text = "Hard"
        } else {
            difficultyLabelNode.text = "Easy"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = nodes(at: location)
            
            if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: size)
                view?.presentScene(gameScene, transition: transition)
            } else if nodesArray.first?.name == "difficultyButton" {
                changeDifficulty()
            }
        }
    }
    
    func changeDifficulty() {
        let userDefaults = UserDefaults.standard
        
        if difficultyLabelNode.text == "Easy" {
            difficultyLabelNode.text = "Hard"
            userDefaults.set(true, forKey: "hard")
        } else {
            difficultyLabelNode.text = "Easy"
            userDefaults.set(false, forKey: "hard")
        }
        
        userDefaults.synchronize()
    }
    
}
