//
//  Fighter.swift
//  Boxer
//
//  Created by Jacob Wall on 10/16/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import Foundation
import SpriteKit

class Fighter{
    
    var name = String()
    var originalHp = Float()
    var hp = Float()
    var defense = Float()
    var strength = Float()
    var speed = Float() // speed
    var stance = String()
    var position = String() // position
    
    init(name: String, hp: Float, defense: Float, strength: Float, speed: Float){
        self.hp = hp
        self.name = name
        self.originalHp = hp
        self.defense = defense
        self.strength = strength
        self.speed = speed
        self.stance = "vulnerable"
        self.position = "middle"
    }

    required init() {
        
    }
    
    func getOriginalHp() -> Float{
        return originalHp
    }
    
    func getName() -> String{
        return name
    }
    
    func getHp() -> Float{
        return hp
    }
    
    func getStrength() -> Float{
        return strength
    }
    
    func getSpeed() -> Float{
        return speed
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func setHp(hp: Float){
        self.hp = hp
    }
    
    func setStrength(strength: Float){
        self.strength = strength
    }
    
    func setSpd(speed: Float){
        self.speed = speed
    }

    func setDefense(defense: Float){
        self.defense = defense
    }
    
    func getDefense() -> Float{
        return defense
    }
    
    func setStance(stance: String){
        self.stance = stance
    }
    
    func getStance() -> String{
        return stance
    }
    
    func setPosition(position: String){
        self.position = position
    }

    func getPosition() -> String{
        return position
    }
  
    
    /*
     position:
     left
     right
     center
     */
    
    /*
     stances:
     punching
     blocking
     vulnerable
     */
}
