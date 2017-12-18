//
//  Fighters.swift
//  Boxer
//
//  Created by Jacob Wall on 12/17/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import SpriteKit
import Foundation

class Fighters{
    
    var deck = [Fighter()]
    
    var Puck = Fighter(name: "Puck", hp: 100, defense: 40, strength: 50, speed: 100, stamina: 100)
    var Kragen = Fighter(name: "Kragen", hp: 300, defense: 100, strength: 20, speed: 20, stamina: 50)
    var Kuufnar = Fighter(name: "Kuufnar", hp: 150, defense: 50, strength: 70, speed: 75, stamina: 75)
    var Rah = Fighter(name: "Rah", hp: 400, defense: 200, strength: 50, speed: 10, stamina: 70)
    
    init(){
        deck.append(Puck)
        deck.append(Kragen)
        deck.append(Kuufnar)
        deck.append(Rah)
 
    }
    
    func getFighter(name: String) -> Fighter{
        for fighter in deck{
            if(name == fighter.getName()){
                return fighter
            }
        }
        return Puck
    }
    
}
