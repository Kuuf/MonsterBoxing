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
   
    @IBOutlet weak var playerBlock: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = GameScene(fileNamed:"GameScene") {
            scene.viewController = self
            
            // Configure the view.
            
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            
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
          
        }
        
        // registering different touches for leftKey
        leftKey.addTarget(self, action: #selector(GameViewController.arrowRelease), for: UIControlEvents.touchUpInside)
        leftKey.addTarget(self, action: #selector(GameViewController.arrowRelease), for: UIControlEvents.touchUpOutside)
        leftKey.addTarget(self, action: #selector(GameViewController.leftHold), for: UIControlEvents.touchDown)
        
        // registering different touches for rightKey
        rightKey.addTarget(self, action: #selector(GameViewController.arrowRelease), for: UIControlEvents.touchUpInside)
        rightKey.addTarget(self, action: #selector(GameViewController.arrowRelease), for: UIControlEvents.touchUpOutside)
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
      
        //blocking
        opponentBlock.addTarget(self, action: #selector(GameViewController.oppBlock), for: UIControlEvents.touchDown)
        playerBlock.addTarget(self, action: #selector(GameViewController.boxerBlock), for: UIControlEvents.touchDown)
        
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
    }
    
    func resetBoxer(sender: UIButton){
        Boxer.setPosition(position: "middle")
        playerPosition.text = Boxer.getPosition()
        Boxer.setStance(stance: "vulnerable")
        playerStance.text = Boxer.getStance()
        Boxer.setHp(hp: Boxer.getOriginalHp())
        playerHp.text = String(Boxer.getHp())
    }
    
    func oppBlock(sender: UIButton){
        Opponent.setStance(stance: "blocking")
        opponentStance.text = Opponent.getStance()
    }
    
    func boxerBlock(sender: UIButton){
        Boxer.setStance(stance: "blocking")
        playerStance.text = Boxer.getStance()
    }
    
    func opponentLeftHold(sender: UIButton){
        if(!pressingRight){
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
        damage(attacker: Opponent, damaged: Boxer, punchHoldTime: 1)
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
    func leftPress(sender: UIButton){
        if(!pressingRight){
            Boxer.setPosition(position: "left")
            self.playerPosition.text = Boxer.getPosition()
        }
    }
    
    func leftHold(sender: UIButton){
        if(!pressingRight){
            Boxer.setPosition(position: "left")
            self.playerPosition.text = Boxer.getPosition()
        }
    }
    
    func rightPress(sender: UIButton){
        if(!pressingLeft){
            Boxer.setPosition(position: "right")
            self.playerPosition.text = Boxer.getPosition()
        }
    }
    
    func rightHold(sender: UIButton){
        if(!pressingLeft){
            Boxer.setPosition(position: "right")
            self.playerPosition.text = Boxer.getPosition()
        }
    }
    
    func punchHold(sender: UIButton){
        Boxer.setStance(stance: "punching")
        self.playerStance.text = Boxer.getStance()
       
    }
    
    //disabling temporarily while testing functionality
    
    func arrowRelease(sender: UIButton){
       
        if(!pressingRight && !pressingLeft){
            self.playerPosition.text = "middle"
        }
        
    }
    
    func enablePunchKey(){
        self.punchKey.isEnabled = true
    }
    
    // **************************************************
 
    
    /*func punchRelease(sender: UIButton){
        var coolDownTime = Float(50.0/Float(Boxer.getSpeed()))
        print("coolDownTime", coolDownTime)
        // sets cooldown time for punches depending on speed of puncher

        
        //sets buildup time before punches
        let punchBufferTime = DispatchTime.now() + DispatchTimeInterval.seconds(Int(coolDownTime))
        DispatchQueue.main.asyncAfter(deadline: punchBufferTime){
            self.damage(attacker: self.Boxer, damaged: self.Opponent, punchHoldTime: 1)
        }
        
        
        if(!pressingRight && !pressingLeft){
            Boxer.setStance(stance: "vulnerable")
            self.playerStance.text = Boxer.getStance()
        }
        if(pressingRight && pressingLeft){
            Boxer.setStance(stance: "blocking")
        }
        
    } */
    func punchRelease(sender: UIButton){
        //disables button for coolDownTime
        let coolDownTime = Float(100.0/Float(Boxer.getSpeed()))
        self.punchKey.isEnabled = false
        Timer.scheduledTimer(timeInterval: TimeInterval(coolDownTime), target: self, selector: #selector(self.enablePunchKey), userInfo: nil, repeats: false)
       
        //does actual punching action
        Match.punch(attacker: Boxer, defender: Opponent, isMonsterMove: false, coolDownTime: coolDownTime)
        
        Boxer.setStance(stance: "vulnerable")
       
    }

    //unused for now, keeping just in case
    func changeStance(fighter: Fighter, stance: String){
        fighter.setStance(stance: stance)
    }
    
    func changePosition(fighter: Fighter, position: String){
        fighter.setPosition(position: position)
    }
    
    // universal damage method, gets called in GameScene as well
    // return damage from this method to GameScene to modify HP bars
   
    func damage(attacker: Fighter, damaged: Fighter, punchHoldTime: Float) -> Int{

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
    
    //temporary since hp labels aren't attached to Fighter objects yet
    // could possibly keep same system but with customizable player name
            if(damaged.getName() == "Kuufnar"){
                playerHp.text = String(Boxer.getHp())
                print("bar original position:", playerHpBar.position.x)
                print("width", playerHpBar.frame.width)
                print("change",playerHpBar.frame.width*((CGFloat(oldHp)-CGFloat(newHp))/CGFloat(damaged.getOriginalHp())))
                playerHpBar.position.x = playerHpBar.position.x - playerHpBar.frame.width*((CGFloat(oldHp)-CGFloat(newHp))/CGFloat(damaged.getOriginalHp()))

            }else{
                opponentHp.text = String(Opponent.getHp())
            }
    // ****************************************************************
            return (attacker.getStrength()/damaged.defense)*20
        }
    } // damage()
    
    
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
