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
    var originalHp = Int()
    var hp = Int()
    var defense = Int()
    var strength = Int()
    var speed = Int() // speed
    var stance = String()
    var position = String() // position
    
    init(name: String, hp: Int, defense: Int, strength: Int, speed: Int){
        self.hp = hp
        self.name = name
        self.originalHp = hp
        self.defense = defense
        self.strength = strength
        self.speed = speed
    }

    required init() {
        
    }
    
    func getOriginalHp() -> Int{
        return originalHp
    }
    
    func getName() -> String{
        return name
    }
    
    func getHp() -> Int{
        return hp
    }
    
    func getStrength() -> Int{
        return strength
    }
    
    func getSpeed() -> Int{
        return speed
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func setHp(hp: Int){
        self.hp = hp
    }
    
    func setStrength(strength: Int){
        self.strength = strength
    }
    
    func setSpd(speed: Int){
        self.speed = speed
    }

    func setDefense(defense: Int){
        self.defense = defense
    }
    
    func getDefense() -> Int{
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
