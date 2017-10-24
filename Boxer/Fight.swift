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
        
        // attacker punching left while opponent on right
        if(attacker.getPosition() == "left" && defender.getPosition() == "right"){
            dodged = true
        }
        // attacker punching right while opponent on left
        else if(attacker.getPosition() == "right" && defender.getPosition() == "left"){
            dodged = true
        }
        else{
            dodged = false
        }
        
        if (dodged){
            return 0
        }
        else if(defender.getStance() == "blocking"){
            blocked = true
            return 0
        }
        // if monster punch lands
        else if(isMonsterMove){
            return 0
        }
        // if normal punch lands
        else{
            let newHp = Float(defender.getHp()) - (Float(attacker.getStrength())/Float(defender.defense)*20)
            let oldHp = defender.getHp()
            
            
            DispatchQueue.main.asyncAfter(deadline: bufferTime){
                defender.setHp(hp: newHp)
                attacker.setStance(stance: "vulnerable")
                print("punch over")
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
