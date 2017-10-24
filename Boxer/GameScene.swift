//
//  GameScene.swift
//  Boxer
//
//  Created by Jacob Wall on 9/13/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var viewController: GameViewController!
    var player = SKSpriteNode()
    var enemy = SKSpriteNode()
    var enemyHpBar = SKShapeNode()
    var playerHpBar = SKShapeNode()
    
    var fightOver = Bool()
    var touch = UITouch()
    
    var Boxer = Fighter()
    var Opponent = Fighter()
    var Match = Fight()

    override func didMove(to view: SKView) {
        //set up scene here
        view.isMultipleTouchEnabled = true
        self.backgroundColor = SKColor.white
        
        Boxer = Fighter(name: "Kuufnar", hp: 150, defense: 50, strength: 50, speed: 75)
        Opponent = Fighter(name: "Kragen", hp: 300, defense: 100, strength: 20, speed: 20)
        Match = Fight(player: Boxer, enemy: Opponent)
        
        
        enemyHpBar = SKShapeNode(rect: CGRect(x: (-self.frame.width/2)+30, y: (self.frame.height/2)-90, width: self.frame.width-60, height: 60))
        enemyHpBar.fillColor = SKColor.blue
        enemyHpBar.zPosition = 9
        
        playerHpBar = SKShapeNode(rect: CGRect(x: (-self.frame.width/2)+30, y: -(self.frame.height/2)+235, width: self.frame.width-60, height: 60))
        playerHpBar.fillColor = SKColor.green
        playerHpBar.zPosition = 9
        
        addChild(enemyHpBar)
        addChild(playerHpBar)
        
        //fight against AI
        //fight(player: Boxer, ai: Opponent)
    }
    
    func fight(player: Fighter, ai: Fighter){
        var attackCounter: Int = 0
        while(attackCounter < 10){
            var random: Int = Int(arc4random_uniform(4))
            
        }
        
       // Match.punch(attacker: ai, defender: Fighter, isMonsterMove: <#T##Bool#>, coolDownTime: <#T##Float#>)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        

        //node underneath touch location
        let node = self.atPoint(CGPoint(x: location.x, y: location.y))
            
        //if not touching empty space
        if(node.name != nil){
            
            //touching right arrow
            if(node.name! == "rightKey"){
                print("rightKey")
                enemyHpBar.position.x = enemyHpBar.position.x + 50
            }// if rightKey
            
            //touching left arrow
            if(node.name! == "leftKey"){
                print("leftKey")
                enemyHpBar.position.x = enemyHpBar.position.x - 50
            }// if leftKey
            
            //touching punch button
            if(node.name! == "punchKey"){
                print("punchKey")
            }// if rightKey
            
            if(node.name! == "damageEnemy"){
                print("damageEnemy")
                //damage(amount: 15, fighter: Opponent)
            }
            
            if(node.name! == "damagePlayer"){
                print("damagePlayer")
                //damage(amount: 15, fighter: Boxer)
            }
            
        } // if !nil
        
    } // touchesBegan
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
