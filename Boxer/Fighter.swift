//
//  Fighter.swift
//  Boxer
//
//  Created by Jacob Wall on 10/16/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import Foundation
import SpriteKit

class Fighter : SKSpriteNode{
    
    var nickName = String()
    var hp = Int()
    var defense = Int()
    var strength = Int()
    var spd = Int() // speed
    var recoveryTime = Int()
    var stance = String()
    var pos = String() // position
    var originalHp = Int()
    
    func setOriginalHp(hp: Int){
        originalHp = hp
        setHp(hp: hp)
    }
    
    func getOriginalHp() -> Int{
        return originalHp
    }
    
    func getName() -> String{
        return nickName
    }
    
    func getHp() -> Int{
        return hp
    }
    
    func getStrength() -> Int{
        return strength
    }
    
    func getSpeed() -> Int{
        return spd
    }
    
    func setName(name: String){
        nickName = name
    }
    
    func setHp(hp: Int){
        self.hp = hp
    }
    
    func setStrength(strength: Int){
        self.strength = strength
    }
    
    func setSpd(speed: Int){
        spd = speed
    }
    
    func setRecoveryTime(recoveryTime: Int){
        self.recoveryTime = recoveryTime
    }
    
    func getRecoveryTime() -> Int{
        return recoveryTime
    }
    
    func setDefense(defense: Int){
        self.defense = defense
    }
    
    func getDefense() -> Int{
        return defense
    }
    
    /*
     stances:
     punching
     blocking
     vulnerable
     */
    
    func setStance(stance: String){
        self.stance = stance
    }
    
    func getStance() -> String{
        return stance
    }
    
    /*
     position:
     left
     right
     center
     */
    
    func setPosition(position: String){
        pos = position
    }

    func getPosition() -> String{
        return pos
    }
  
  
    
    
}
