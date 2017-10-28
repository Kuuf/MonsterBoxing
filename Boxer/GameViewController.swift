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
    var canMove = Bool()
    var directionLastPressed = String()
    var damage = Float()
    var coolDownTime = Float()
    var sceneNode = SKNode()
    
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
            coolDownTime = Float(50.0/Float(Boxer.getSpeed()))

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
            else{
                Boxer.setPosition(position: "left")
                self.playerPosition.text = Boxer.getPosition()
                Boxer.setStance(stance: "vulnerable")
                self.playerStance.text = Boxer.getStance()
            }
        }
    }
    
    func leftArrowRelease(sender: UIButton?){
        pressingLeft = false
        let boxerMoving = SKAction.wait(forDuration: TimeInterval(coolDownTime/2))
        let boxerDoneMoving = SKAction.run{
            if(self.canMove){
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
        let movementSequence = SKAction.sequence([boxerMoving, boxerDoneMoving])
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
            }else{
                Boxer.setPosition(position: "right")
                self.playerPosition.text = Boxer.getPosition()
                Boxer.setStance(stance: "vulnerable")
                self.playerStance.text = Boxer.getStance()
            }
        }
    }
    
    func rightArrowRelease(sender: UIButton?){
        pressingRight = false
        let boxerMoving = SKAction.wait(forDuration: TimeInterval(coolDownTime/2))
        let boxerDoneMoving = SKAction.run{
            if(self.canMove){
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
        let movementSequence = SKAction.sequence([boxerMoving, boxerDoneMoving])
        sceneNode.run(movementSequence)
    }
    
    func punchHold(sender: UIButton){
        Boxer.setStance(stance: "punching")
        self.playerStance.text = Boxer.getStance()
        canMove = false
    }
    
    func punchRelease(sender: UIButton){
        //disables button for coolDownTime
        self.punchKey.isEnabled = false
        Timer.scheduledTimer(timeInterval: TimeInterval(coolDownTime), target: self, selector: #selector(self.enablePunchKey), userInfo: nil, repeats: false)
        
        //does actual punching action
        damage = Match.punch(attacker: Boxer, defender: Opponent, isMonsterMove: false, coolDownTime: coolDownTime)
        modifyUI(attacker: Boxer, defender: Opponent, input: damage)

        
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
    

    // universal damage method, gets called in GameScene as well
    // return damage from this method to GameScene to modify HP bars
   /*
    func damage(attacker: Fighter, damaged: Fighter, punchHoldTime: Float) -> Float{

        // attacker punching left while opponent on right
        if(attacker.getPosition() == "left" && damaged.getPosition() == "right"){
            dodged = true
        }
        // attacker punching right while opponent on left
        else if(attacker.getPosition() == "right" && damaged.getPosition() == "left"){
            dodged = true
        }
        else{
            dodged = false
        }
        
        if(dodged){
            return 0
        }
        else if(damaged.getStance() == "blocking"){
            print("blocked")
            return 0
        }
        else{
            //fighter hp gets updated with damage
            let newHp = damaged.getHp() - (attacker.getStrength()/damaged.defense)*20
            let oldHp = damaged.getHp()
            print("oldHp:", oldHp)
            print("newHp:", newHp)
            damaged.setHp(hp: damaged.getHp() - (attacker.getStrength()/damaged.defense)*20)
     
            return (attacker.getStrength()/damaged.defense)*20
        }
    } // damage()
    */
    //uses info returned from Fight.swift's Punch() method to change UI
   
    func modifyUI(attacker: Fighter, defender: Fighter, input: Float){
        //if the defender is the player
        if(attacker.getName() != "Kuufnar"){
            if(Boxer.getStance() != "blocking"){
                print("kuuf hit")
                playerHpBar.position.x = CGFloat(Float(playerHpBar.position.x) - (damage/defender.getOriginalHp()) * Float(playerHpBar.frame.width))
            }
        }else{
            if(Opponent.getStance() != "blocking"){
                print("Kragen Hit")
                opponentHpBar.position.x = CGFloat(Float(opponentHpBar.position.x) - (damage/defender.getOriginalHp()) * Float(opponentHpBar.frame.width))
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
