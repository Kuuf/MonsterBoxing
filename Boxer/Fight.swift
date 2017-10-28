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
    
    var player = Fighter()
    var enemy = Fighter()

    
    init (player: Fighter, enemy: Fighter){
        self.player = player
        self.enemy = enemy
    }
    
    required init() {
        
    }
    
    func punch(attacker: Fighter, defender: Fighter, isMonsterMove: Bool, coolDownTime: Float) -> Float{
        
        let bufferTime = DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(coolDownTime*Float(300)))
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
            return 0
        }
        else if(defender.getStance() == "blocking"){
            print(defender.getName(), "blocked the attack\n")
            blocked = true
            return 0
        }
        // if monster punch lands
        else if(isMonsterMove){
            return 0
        }
        // if normal punch lands
        else{
            print(attacker.getName(), "punched", defender.getName())
            let newHp = Float(defender.getHp()) - (Float(attacker.getStrength())/Float(defender.defense)*20)
            let oldHp = defender.getHp()
            
            print(defender.getName(), "old HP:", oldHp)
            print(defender.getName(), "new HP:", newHp, "\n")
            defender.setHp(hp: newHp)
            
            DispatchQueue.main.asyncAfter(deadline: bufferTime){
                attacker.setStance(stance: "vulnerable")
            }
            return Float(attacker.getStrength())/Float(defender.defense)*Float(20.0)
            
        }
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
