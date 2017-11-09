//
//  Fight.swift
//  Monster Boxing
//
//  Created by Jacob Wall on 10/18/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import Foundation
import SpriteKit

class Fight{
    var viewController: GameViewController!
    
    var coolDownTime = Float()
    var holdTime = Float()
    var isMonsterMove = Bool()
    var dodged = Bool()
    var blocked = Bool()
    var damage = Float() // damage done by each respective punch
    var staminaLost = Float()
    
    var player = Fighter()
    var enemy = Fighter()

    
    init (player: Fighter, enemy: Fighter){
        self.player = player
        self.enemy = enemy
    }
    
    required init() {
        
    }
    
    func punch(attacker: Fighter, defender: Fighter, isMonsterMove: Bool, coolDownTime: Float, punchLength: Float) -> Float{
        let bufferTime = DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(coolDownTime*Float(1000)))
        self.isMonsterMove = isMonsterMove
        
        // attacker punching left while opponent on the opponent's left
        if(attacker.getPosition() == "left" && defender.getPosition() == "left"){
            dodged = true
        }
        // attacker punching right while opponent on the opponent's left
        else if(attacker.getPosition() == "right" && defender.getPosition() == "right"){
            dodged = true
        }
        else{
            dodged = false
        }
        
        if (dodged){
            print(defender.getName(),"dodged the attack\n")
            DispatchQueue.main.asyncAfter(deadline: bufferTime){
                attacker.setStance(stance: "vulnerable")
            }
            return 0
        }
        else if(defender.getStance() == "blocking"){
            print(defender.getName(), "blocked the attack\n")
            blocked = true
            DispatchQueue.main.asyncAfter(deadline: bufferTime){
                attacker.setStance(stance: "vulnerable")
            }
            return 0
        }
        // if monster punch lands
        else if(isMonsterMove){
            DispatchQueue.main.asyncAfter(deadline: bufferTime){
                attacker.setStance(stance: "vulnerable")
            }
            return 0
        }
        // if normal punch lands
        else{
            
            // damage formula
            damage = Float(attacker.getStrength())/Float(defender.defense)*(5.0 * punchLength)
            print(attacker.getName(), "punched", defender.getName())
            
            let newHp = Float(defender.getHp()) - damage
            let oldHp = defender.getHp()
            
            print(defender.getName(), "old HP:", oldHp)
            print(defender.getName(), "new HP:", newHp, "\n")
            defender.setHp(hp: newHp)
            
            DispatchQueue.main.asyncAfter(deadline: bufferTime){
                attacker.setStance(stance: "vulnerable")
            }
            return damage
            
        }
    }
    
    func setStamina(attacker: Fighter, punchLength: Float) -> Float{
        
        staminaLost = punchLength*2
        attacker.setStamina(stamina: attacker.getStamina()-staminaLost)

        return staminaLost
    }
    
    func setCoolDownTime(coolDownTime: Float){
        self.coolDownTime = coolDownTime
    }
    
    func getCoolDownTime() -> Float{
        return coolDownTime
    }
    
    func setHoldTime(holdTime: Float){
        self.holdTime = holdTime
    }
    
    func getHoldTime() -> Float{
        return holdTime
    }
    
    func isMonsterMove(isMonsterMove: Bool){
        self.isMonsterMove = isMonsterMove
    }
    
    func getIsMonsterMove() -> Bool{
        return isMonsterMove
    }
    
    
}
