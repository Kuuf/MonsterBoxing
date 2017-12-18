//
//  EnemySelectScreen.swift
//  Boxer
//
//  Created by Jacob Wall on 12/17/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import SpriteKit
import Foundation

class EnemySelectScreen: UIViewController {
    
    var playerBoxer = Fighter()
    var enemyBoxer = Fighter()
    var playerCardImage: UIImage!
    var enemyCardImage: UIImage!
    var deck = Fighters()
    
    
    @IBOutlet weak var puckCard: UIButton!
    @IBOutlet weak var kragenCard: UIButton!
    @IBOutlet weak var kuufnarCard: UIButton!
    @IBOutlet weak var rahCard: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        //registering different touches for puckCard
        puckCard.addTarget(self, action: #selector(EnemySelectScreen.puckCardRelease), for: UIControlEvents.touchUpInside)
        puckCard.addTarget(self, action: #selector(EnemySelectScreen.puckCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for kragenCard
        kragenCard.addTarget(self, action: #selector(EnemySelectScreen.kragenCardRelease), for: UIControlEvents.touchUpInside)
        kragenCard.addTarget(self, action: #selector(EnemySelectScreen.kragenCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for kuufnarCard
        kuufnarCard.addTarget(self, action: #selector(EnemySelectScreen.kuufnarCardRelease), for: UIControlEvents.touchUpInside)
        kuufnarCard.addTarget(self, action: #selector(EnemySelectScreen.kuufnarCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for rahCard
        rahCard.addTarget(self, action: #selector(EnemySelectScreen.rahCardRelease), for: UIControlEvents.touchUpInside)
        rahCard.addTarget(self, action: #selector(EnemySelectScreen.rahCardRelease), for: UIControlEvents.touchUpOutside)
        
        backButton.addTarget(self, action: #selector(EnemySelectScreen.backButtonRelease), for: UIControlEvents.touchUpInside)
        backButton.addTarget(self, action: #selector(EnemySelectScreen.backButtonRelease), for: UIControlEvents.touchUpOutside)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEnemyConfirmScreen" {
            let destination = segue.destination as! EnemyConfirmScreen
            destination.enemyCardImage = enemyCardImage
            destination.playerCardImage = playerCardImage
            destination.playerBoxer = playerBoxer
            destination.enemyBoxer = enemyBoxer
        }
        
        if segue.identifier == "toPlayerConfirmScreen" {
            let destination = segue.destination as! PlayerConfirmScreen
            destination.playerCardImage = playerCardImage
            destination.playerBoxer = playerBoxer
        }
    }
    
    func backButtonRelease(){
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func puckCardRelease(){
        enemyCardImage = UIImage(named: "Card_Puck.png")
        playerBoxer = deck.getFighter(name: "Puck")
        deck.setEnemyBoxer(fighter: deck.getFighter(name: "Puck"))
        self.performSegue(withIdentifier: "toEnemyConfirmScreen", sender: self)
    }
    
    func kragenCardRelease(){
        enemyCardImage = UIImage(named: "Card_Kragen.png")
        playerBoxer = deck.getFighter(name: "Kragen")
        deck.setEnemyBoxer(fighter: deck.getFighter(name: "Kragen"))
        self.performSegue(withIdentifier: "toEnemyConfirmScreen", sender: self)

    }
    
    func kuufnarCardRelease(){
        enemyCardImage = UIImage(named: "Card_Kuufnar.png")
        playerBoxer = deck.getFighter(name: "Kuufnar")
        deck.setEnemyBoxer(fighter: deck.getFighter(name: "Kuufnar"))
        self.performSegue(withIdentifier: "toEnemyConfirmScreen", sender: self)

    }
    
    func rahCardRelease(){
        enemyCardImage = UIImage(named: "Card_Rah.png")
        playerBoxer = deck.getFighter(name: "Rah")
        deck.setEnemyBoxer(fighter: deck.getFighter(name: "Rah"))
        self.performSegue(withIdentifier: "toEnemyConfirmScreen", sender: self)

    }
    
}
