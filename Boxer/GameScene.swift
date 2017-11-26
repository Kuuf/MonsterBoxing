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
    var playerSelectScreen: PlayerSelectScreen!
    var playerConfirmScreen: PlayerConfirmScreen!
    var player = SKSpriteNode()
    var enemy = SKSpriteNode()
    var enemyHpBar = SKShapeNode()
    var playerHpBar = SKShapeNode()
    var playerStaminaBar = SKShapeNode()
    var playerStaminaAnimationBar = SKShapeNode()
    var opponentStaminaBar = SKShapeNode()
    var aiPunchLength = Float()
    
    var fightOver = Bool()
    var touch = UITouch()
    
    var Boxer = Fighter()
    var Opponent = Fighter()
    var Match = Fight()
    var random = UInt32()
    var gameStarted = Bool()

    override func didMove(to view: SKView) {
        //set up scene here
        view.isMultipleTouchEnabled = true
        self.backgroundColor = SKColor.white
        
        Boxer = Fighter(name: "Kuufnar", hp: 150, defense: 50, strength: 50, speed: 75, stamina: 75)
        Opponent = Fighter(name: "Kragen", hp: 300, defense: 100, strength: 20, speed: 20, stamina: 50)
        Match = Fight(player: Boxer, enemy: Opponent)
        
        enemyHpBar = SKShapeNode(rect: CGRect(x: (-self.frame.width/2)+30, y: (self.frame.height/2)-90, width: self.frame.width-60, height: 60))
        enemyHpBar.fillColor = SKColor.blue
        enemyHpBar.zPosition = 9
        
        playerHpBar = SKShapeNode(rect: CGRect(x: (-self.frame.width/2)+30, y: -(self.frame.height/2)+235, width: self.frame.width-60, height: 60))
        playerHpBar.fillColor = SKColor.green
        playerHpBar.zPosition = 9
        
        playerStaminaBar = SKShapeNode(rect: CGRect(x: (-self.frame.width/2)+70, y: -(self.frame.height/2)+320, width: self.frame.width/3, height: 30))
        playerStaminaBar.fillColor = SKColor.red
        playerStaminaBar.zPosition = 9
        
        playerStaminaAnimationBar = SKShapeNode(rect: CGRect(x: (-self.frame.width/2)+70, y: -(self.frame.height/2)+320, width: self.frame.width/3, height: 30))
        playerStaminaAnimationBar.fillColor = SKColor.cyan
        playerStaminaAnimationBar.zPosition = 10
        playerStaminaAnimationBar.alpha = 0.5
        
        
        
        addChild(enemyHpBar)
        addChild(playerHpBar)
        addChild(playerStaminaBar)
        addChild(playerStaminaAnimationBar)
       
       
    }
    
    func fight(player: Fighter, ai: Fighter){
        let coolDownTime = Float(50.0/Float(ai.getSpeed()))/2
        aiPunchLength = 5
        let aiPunch = SKAction.run{
            self.random = arc4random_uniform(4)
            let damage = self.Match.punch(attacker: ai, defender: player, isMonsterMove: false, coolDownTime: coolDownTime, punchLength: self.aiPunchLength)
            let staminaLost = self.Match.setStamina(attacker: ai, punchLength: self.aiPunchLength)
            // sets damage and stamina for appropriate movement of player HP and Stamina UI
            self.viewController.setStaminaLost(staminaLost: staminaLost)
            self.viewController.setDamage(damage: damage)
            self.viewController.modifyUI(attacker: ai, defender: player)
        }
      //  let buildUp = SKAction.wait(forDuration: TimeInterval(coolDownTime/2))
        let buildUp = SKAction.wait(forDuration: TimeInterval(coolDownTime/2))
        let printing = SKAction.run{
            print("AI punching")
        }
        let coolDown = SKAction.wait(forDuration: TimeInterval(coolDownTime))
        let randomDelay = SKAction.wait(forDuration: 3, withRange: 2)
        let punch = SKAction.sequence([printing, buildUp, aiPunch, coolDown, randomDelay])
        let punchRepeatForever = SKAction.repeatForever(punch)
        self.run(punchRepeatForever)
        
        // .05 is the degree of loss each iteration, combined with the interval of .01 given in the delay variable below, meaning every .01 seconds the bar moves .05 backward
        let regenerateStamina = SKAction.run{
            if((self.Boxer.getStamina() < self.Boxer.getOriginalStamina()) && self.Boxer.getStance() != "punching"){
                self.Boxer.setStamina(stamina: self.Boxer.getStamina()+0.05)
                // animate true stamina bar
                self.playerStaminaBar.position.x = CGFloat(Float(self.playerStaminaBar.position.x) + (0.05/self.Boxer.getOriginalStamina()) * Float(self.playerStaminaBar.frame.width))
                // animate stamina animation bar
                self.viewController.setStaminaAnimationBarPosition(position: CGFloat(Float(self.playerStaminaAnimationBar.position.x) + (0.05/self.Boxer.getOriginalStamina()) * Float(self.playerStaminaAnimationBar.frame.width)))
                
            }
            if(self.Opponent.getStamina() != self.Opponent.getOriginalStamina()){
                self.Opponent.setStamina(stamina: self.Opponent.getStamina()+10)

            }
        }
        let delay = SKAction.wait(forDuration: TimeInterval(0.01))
        let staminaActionSequence = SKAction.sequence([regenerateStamina,delay])
        let regenerateStaminaForever = SKAction.repeatForever(staminaActionSequence)
        self.run(regenerateStaminaForever)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!gameStarted){
            fight(player: Boxer, ai: Opponent)
        }
        gameStarted = true

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
