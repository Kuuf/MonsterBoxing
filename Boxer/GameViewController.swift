//
//  GameViewController.swift
//  Boxer
//
//  Created by Jacob Wall on 9/13/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

/*
 * All user interactions are maintained in this class
 * All opponent interactions are maintained in GameScene
 */

class GameViewController: UIViewController {
 
    @IBOutlet weak var playerStance: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerHp: UILabel!
    @IBOutlet weak var leftKey: UIButton!
    @IBOutlet weak var rightKey: UIButton!
    @IBOutlet weak var punchKey: UIButton!
    @IBOutlet weak var opponentPosition: UILabel!
    @IBOutlet weak var opponentStance: UILabel!
    @IBOutlet weak var opponentHp: UILabel!
    @IBOutlet weak var opponentLeft: UIButton!
    @IBOutlet weak var opponentRight: UIButton!
    @IBOutlet weak var opponentPunch: UIButton!
    @IBOutlet weak var opponentBlock: UIButton!
    @IBOutlet weak var resetOpponent: UIButton!
    @IBOutlet weak var resetPlayer: UIButton!
    
    var pressingLeft = Bool()
    var pressingRight = Bool()
    var Boxer = Fighter()
    var Opponent = Fighter()
    var Match = Fight()
    var dodged = Bool()
    var punchHoldTime = Int()
    var playerHpBar = SKShapeNode()
    var opponentHpBar = SKShapeNode()
    var playerStaminaBar = SKShapeNode()
    var opponentStaminaBar = SKShapeNode()
    var canMove = Bool()
    var directionLastPressed = String()
    var damage = Float()
    var coolDownTime = Float() //fighter movement cool down time
    var sceneNode = SKNode() // copy of gamescene so it can be accessed
    var boxerMoving = Bool()
    var punchLength = Float() //duration fighter holds down a punch
    var punchTimer = Timer()
    var staminaLost = Float() // stamina lost from each respective punch
    
    // variables to tweak for gameplay speed & balance (Edit at bottom of viewDidLoad)
    var boxerMovementCooldownTime = Float()
    var punchCooldownTime = Float()
    
    override func viewDidLoad() {
        canMove = true
        super.viewDidLoad()
        view.isMultipleTouchEnabled = true
        
        if let scene = GameScene(fileNamed:"GameScene") {
            scene.viewController = self
            // Configure the view.
            let skView = self.view as! SKView
            
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.isMultipleTouchEnabled = true
            sceneNode = scene
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            Match = scene.Match
            Boxer = scene.Boxer
            Opponent = scene.Opponent
            playerHpBar = scene.playerHpBar
            opponentHpBar = scene.enemyHpBar
            playerStaminaBar = scene.playerStaminaBar
            opponentStaminaBar = scene.opponentStaminaBar
            
            // variables to tweak for gameplay speed & balance
            coolDownTime = Float(50.0/Float(Boxer.getSpeed()))
            boxerMovementCooldownTime = coolDownTime/2
            punchCooldownTime = coolDownTime/2
            

        }
        
        // registering different touches for leftKey
        leftKey.addTarget(self, action: #selector(GameViewController.leftArrowRelease), for: UIControlEvents.touchUpInside)
        leftKey.addTarget(self, action: #selector(GameViewController.leftArrowRelease), for: UIControlEvents.touchUpOutside)
        leftKey.addTarget(self, action: #selector(GameViewController.leftHold), for: UIControlEvents.touchDown)
        
        // registering different touches for rightKey
        rightKey.addTarget(self, action: #selector(GameViewController.rightArrowRelease), for: UIControlEvents.touchUpInside)
        rightKey.addTarget(self, action: #selector(GameViewController.rightArrowRelease), for: UIControlEvents.touchUpOutside)
        rightKey.addTarget(self, action: #selector(GameViewController.rightHold), for: UIControlEvents.touchDown)
        
        // registering different touches for punchKey
        punchKey.addTarget(self, action: #selector(GameViewController.punchRelease), for: UIControlEvents.touchUpInside)
        punchKey.addTarget(self, action: #selector(GameViewController.punchRelease), for: UIControlEvents.touchUpOutside)
        punchKey.addTarget(self, action: #selector(GameViewController.punchHold), for: UIControlEvents.touchDown)
        
        
        
//**** temporary for opponent functionality testing ****//
        opponentLeft.addTarget(self, action: #selector(GameViewController.opponentLeftHold), for: UIControlEvents.touchDown)
        opponentRight.addTarget(self, action: #selector(GameViewController.opponentRightHold), for: UIControlEvents.touchDown)
       
        //opponent punching
        opponentPunch.addTarget(self, action: #selector(GameViewController.opponentPunchHold), for: UIControlEvents.touchDown)
        opponentPunch.addTarget(self, action: #selector(GameViewController.opponentPunchRelease), for: UIControlEvents.touchUpInside)
        opponentPunch.addTarget(self, action: #selector(GameViewController.opponentPunchRelease), for: UIControlEvents.touchUpOutside)
       
        //resetting fighters
        resetOpponent.addTarget(self, action: #selector(GameViewController.resetOpp), for: UIControlEvents.touchDown)
        resetPlayer.addTarget(self, action: #selector(GameViewController.resetBoxer), for: UIControlEvents.touchDown)
      
//****   //     ****// ***********************************
        
        
        
    }
    //temporary opponent functions to test damage and scenario functionality
    
    func resetOpp(sender: UIButton){
        Opponent.setPosition(position: "middle")
        opponentPosition.text = Opponent.getPosition()
        Opponent.setStance(stance: "vulnerable")
        opponentStance.text = Opponent.getStance()
        Opponent.setHp(hp: Opponent.getOriginalHp())
        opponentHp.text = String(Opponent.getHp())
        opponentHpBar.position.x = 0
    }
    
    func resetBoxer(sender: UIButton){
        Boxer.setPosition(position: "middle")
        playerPosition.text = Boxer.getPosition()
        Boxer.setStance(stance: "vulnerable")
        playerStance.text = Boxer.getStance()
        Boxer.setHp(hp: Boxer.getOriginalHp())
        playerHp.text = String(Boxer.getHp())
        playerHpBar.position.x = 0
        playerStaminaBar.position.x = 0
        Boxer.setStamina(stamina: Boxer.getOriginalStamina())
    }
    
    func oppBlock(sender: UIButton){
        Opponent.setStance(stance: "blocking")
        opponentStance.text = Opponent.getStance()
    }
    
    func opponentLeftHold(sender: UIButton){
        
        if(pressingRight){
            Opponent.setPosition(position: "middle")
            self.opponentPosition.text = Opponent.getPosition()
            Opponent.setStance(stance: "blocking")
            self.opponentStance.text = Opponent.getStance()
        }else{
            Opponent.setPosition(position: "left")
            self.opponentPosition.text = Opponent.getPosition()
        }
    }

    func opponentRightHold(sender: UIButton){
        if(!pressingLeft){
            Opponent.setPosition(position: "right")
            self.opponentPosition.text = Opponent.getPosition()
        }
    }

    func opponentPunchHold(sender: UIButton){
        Opponent.setStance(stance: "punching")
        self.opponentStance.text = Opponent.getStance()
       // damage(attacker: Opponent, damaged: Boxer, punchHoldTime: 1)
    }

    func opponentPunchRelease(sender: UIButton){
        if(!pressingRight && !pressingLeft){
            Opponent.setStance(stance: "vulnerable")
            self.opponentStance.text = Opponent.getStance()
        }
        if(pressingRight && pressingLeft){
            Opponent.setStance(stance: "blocking")
        }
    }
    
    // ************************************** (means above is temp)


    // adding function to buttons' touching scenarios
    
    func leftHold(sender: UIButton?){
        pressingLeft = true
        if(canMove){
            directionLastPressed = "left"
            if(pressingRight){
                Boxer.setPosition(position: "middle")
                self.playerPosition.text = Boxer.getPosition()
                Boxer.setStance(stance: "blocking")
                self.playerStance.text = Boxer.getStance()
            }
            else if(!boxerMoving){
                Boxer.setPosition(position: "left")
                self.playerPosition.text = Boxer.getPosition()
                Boxer.setStance(stance: "vulnerable")
                self.playerStance.text = Boxer.getStance()
            }
        }
    }
    
    func leftArrowRelease(sender: UIButton?){
        pressingLeft = false
        self.boxerMoving = true
        self.leftKey.isEnabled = false
        self.rightKey.isEnabled = false
        let boxerMovement = SKAction.wait(forDuration: TimeInterval(boxerMovementCooldownTime))
        let boxerDoneMoving = SKAction.run{
            if(self.canMove){
                self.boxerMoving = false
                self.leftKey.isEnabled = true
                self.rightKey.isEnabled = true
                if(!self.pressingRight && !self.pressingLeft){
                    self.Boxer.setPosition(position: "middle")
                    self.playerPosition.text = self.Boxer.getPosition()
                    self.Boxer.setStance(stance: "vulnerable")
                    self.playerStance.text = self.Boxer.getStance()
                }
                if(self.pressingRight){
                    self.Boxer.setPosition(position: "right")
                    self.playerPosition.text = self.Boxer.getPosition()
                    self.Boxer.setStance(stance: "vulnerable")
                    self.playerStance.text = self.Boxer.getStance()
                }
            }
        }
        // creates a cooldown to go to center after moving left or right
        let movementSequence = SKAction.sequence([boxerMovement, boxerDoneMoving])
        sceneNode.run(movementSequence)
    }
    
    func rightHold(sender: UIButton?){
        pressingRight = true
        if(canMove){
            directionLastPressed = "right"
            if(pressingLeft){
                Boxer.setPosition(position: "middle")
                self.playerPosition.text = Boxer.getPosition()
                Boxer.setStance(stance: "blocking")
                self.playerStance.text = Boxer.getStance()
            }else if(!boxerMoving){
                Boxer.setPosition(position: "right")
                self.playerPosition.text = Boxer.getPosition()
                Boxer.setStance(stance: "vulnerable")
                self.playerStance.text = Boxer.getStance()
            }
        }
    }
    
    func rightArrowRelease(sender: UIButton?){
        pressingRight = false
        self.boxerMoving = true
        self.rightKey.isEnabled = false
        self.leftKey.isEnabled = false
        let boxerMovement = SKAction.wait(forDuration: TimeInterval(boxerMovementCooldownTime))
        let boxerDoneMoving = SKAction.run{
            if(self.canMove){
                self.boxerMoving = false
                self.rightKey.isEnabled = true
                self.leftKey.isEnabled = true
                if(!self.pressingRight && !self.pressingLeft){
                    self.Boxer.setPosition(position: "middle")
                    self.playerPosition.text = self.Boxer.getPosition()
                    self.Boxer.setStance(stance: "vulnerable")
                    self.playerStance.text = self.Boxer.getStance()
                }
                if(self.pressingLeft){
                    self.Boxer.setPosition(position: "left")
                    self.playerPosition.text = self.Boxer.getPosition()
                    self.Boxer.setStance(stance: "vulnerable")
                    self.playerStance.text = self.Boxer.getStance()
                }
            }
        }
        // creates a cooldown to go to center after moving left or right
        let movementSequence = SKAction.sequence([boxerMovement, boxerDoneMoving])
        sceneNode.run(movementSequence)
    }
    
    func punchHold(sender: UIButton){
        punchLength = 0
        Boxer.setStance(stance: "punching")
        self.playerStance.text = Boxer.getStance()
        canMove = false
        
        punchTimer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.punchLengthCounter), userInfo: nil, repeats: true)
    }
    
    func punchRelease(sender: UIButton){
        //disables button for coolDownTime
        self.punchKey.isEnabled = false
        punchTimer.invalidate()
        Timer.scheduledTimer(timeInterval: TimeInterval(punchCooldownTime), target: self, selector: #selector(self.enablePunchKey), userInfo: nil, repeats: false)
        
        // setting minimum punch strength for tapping button
        if (punchLength < 1){
            punchLength = 1
        }
        //does actual punching action
        damage = Match.punch(attacker: Boxer, defender: Opponent, isMonsterMove: false, coolDownTime: punchCooldownTime, punchLength: punchLength)
        staminaLost = Match.setStamina(attacker: Boxer, punchLength: punchLength)
        modifyUI(attacker: Boxer, defender: Opponent)
        print("punch length:", punchLength)
        
        // resetting punch length
        punchLength = 0
    }
    
    func punchLengthCounter(){
        punchLength += 0.001
    }

    func setStanceText(text: String){
        playerStance.text = text
    }
    
    func enablePunchKey(){
        self.punchKey.isEnabled = true
        Boxer.setStance(stance: "vulnerable")
        playerStance.text = Boxer.getStance()
        canMove = true
        /*
         if you release an arrow during the punch's cooldown time,
         canMove is set to false, so the arrowRelease function doesn't
         get a chance to set the player's position back to normal
         These 2 methods handle that scenario
         */
        if(pressingLeft){
            leftHold(sender: nil)
            print("pressing left after punch ends")
        }
        else if(pressingRight){
            rightHold(sender: nil)
            print("pressing right after punch ends")

        }
        if(!pressingLeft && !pressingRight){
            if(directionLastPressed == "right"){
                rightArrowRelease(sender: nil)
            }
            
            if(directionLastPressed == "left"){
                leftArrowRelease(sender: nil)
            }
        }
    }
    
    // used so gamescene can modify this class's damage object
    func setDamage(damage: Float){
        self.damage = damage
    }
    
    // used so gamescene can modify this class's staminaLost object
    func setStaminaLost(staminaLost: Float){
        self.staminaLost = staminaLost
    }
    //uses info returned from Fight.swift's Punch() method to change UI
    func modifyUI(attacker: Fighter, defender: Fighter){
        //if the defender is the player
        if(attacker.getName() != "Kuufnar"){
            if(Boxer.getStance() != "blocking"){
                // change Player HP bar
                playerHpBar.position.x = CGFloat(Float(playerHpBar.position.x) - (damage/defender.getOriginalHp()) * Float(playerHpBar.frame.width))
                
                // change Opponent stamina bar
            }
        }else{
            if(Opponent.getStance() != "blocking"){
                // change Opponent HP bar
                opponentHpBar.position.x = CGFloat(Float(opponentHpBar.position.x) - (damage/defender.getOriginalHp()) * Float(opponentHpBar.frame.width))
                
                // change Player stamina Bar
                playerStaminaBar.position.x = CGFloat(Float(playerStaminaBar.position.x) - (staminaLost/attacker.getOriginalStamina()) * Float(playerStaminaBar.frame.width))
                print("player stamina:", attacker.getStamina())
            }
        }
        //^^ modify the 4 according to the dimensions of the container for the hpbar
        // play around with it until the bar depleats completely when hp = 0
        //print("new Bar Position:", playerHpBar.position.x)

    }
    
    
    
    
    
    
    
    
    override var shouldAutorotate: Bool {
        return false
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
