//
//  PlayerSelectScreen.swift
//  Boxer
//
//  Created by Jacob Wall on 11/25/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//
import SpriteKit
import Foundation

class PlayerSelectScreen: UIViewController {
        
    //@IBOutlet weak var puckCard: UIButton!
    @IBOutlet weak var puckCard: UIButton!
    @IBOutlet weak var kragenCard: UIButton!
    @IBOutlet weak var kuufnarCard: UIButton!
    @IBOutlet weak var rahCard: UIButton!
    
  
    var gameScene = GameScene()
    var playerConfirmScreen = PlayerConfirmScreen()
    var playerCard: UIImage!
    var playerBoxer = Fighter()
    var deck = Fighters()
    
    override func viewDidLoad() {
        
        //registering different touches for puckCard
        puckCard.addTarget(self, action: #selector(PlayerSelectScreen.puckCardRelease), for: UIControlEvents.touchUpInside)
        puckCard.addTarget(self, action: #selector(PlayerSelectScreen.puckCardRelease), for: UIControlEvents.touchUpOutside)
     
        //registering different touches for kragenCard
        kragenCard.addTarget(self, action: #selector(PlayerSelectScreen.kragenCardRelease), for: UIControlEvents.touchUpInside)
        kragenCard.addTarget(self, action: #selector(PlayerSelectScreen.kragenCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for kuufnarCard
        kuufnarCard.addTarget(self, action: #selector(PlayerSelectScreen.kuufnarCardRelease), for: UIControlEvents.touchUpInside)
        kuufnarCard.addTarget(self, action: #selector(PlayerSelectScreen.kuufnarCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for rahCard
        rahCard.addTarget(self, action: #selector(PlayerSelectScreen.rahCardRelease), for: UIControlEvents.touchUpInside)
        rahCard.addTarget(self, action: #selector(PlayerSelectScreen.rahCardRelease), for: UIControlEvents.touchUpOutside)
 
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPlayerConfirmScreen" {
            let destination = segue.destination as! PlayerConfirmScreen
            destination.playerCardImage = playerCard
            destination.playerBoxer = playerBoxer
        }
    }

    func puckCardRelease(){
        playerCard = UIImage(named: "Card_Puck.png")
        playerBoxer = deck.getFighter(name: "Puck")
        deck.setPlayerBoxer(fighter: deck.getFighter(name: "Puck"))
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func kragenCardRelease(){
        playerCard = UIImage(named: "Card_Kragen.png")
        playerBoxer = deck.getFighter(name: "Kragen")
        deck.setPlayerBoxer(fighter: deck.getFighter(name: "Kragen"))
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func kuufnarCardRelease(){
        playerCard = UIImage(named: "Card_Kuufnar.png")
        playerBoxer = deck.getFighter(name: "Kuufnar")
        deck.setPlayerBoxer(fighter: deck.getFighter(name: "Kuufnar"))
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func rahCardRelease(){
        playerCard = UIImage(named: "Card_Rah.png")
        playerBoxer = deck.getFighter(name: "Rah")
        deck.setPlayerBoxer(fighter: deck.getFighter(name: "Rah"))
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
 
}
