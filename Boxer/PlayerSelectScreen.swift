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
    @IBOutlet weak var kragenCard: UIButton!
    @IBOutlet weak var kuufnarCard: UIButton!
    @IBOutlet weak var rahCard: UIButton!
    
  
    var gameScene = GameScene()
    var playerConfirmScreen = PlayerConfirmScreen()
    
    override func viewDidLoad() {
        /*
        //registering different touches for puckCard
        puckCard.addTarget(self, action: #selector(PlayerSelectScreen.puckCardRelease), for: UIControlEvents.touchUpInside)
        puckCard.addTarget(self, action: #selector(PlayerSelectScreen.puckCardRelease), for: UIControlEvents.touchUpOutside)
     */
        //registering different touches for kragenCard
        kragenCard.addTarget(self, action: #selector(PlayerSelectScreen.kragenCardRelease), for: UIControlEvents.touchUpInside)
        kragenCard.addTarget(self, action: #selector(PlayerSelectScreen.kragenCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for kuufnarCard
        kuufnarCard.addTarget(self, action: #selector(PlayerSelectScreen.kuufnarCardRelease), for: UIControlEvents.touchUpInside)
        kuufnarCard.addTarget(self, action: #selector(PlayerSelectScreen.kuufnarCardRelease), for: UIControlEvents.touchUpOutside)
        
        //registering different touches for puckCard
        rahCard.addTarget(self, action: #selector(PlayerSelectScreen.rahCardRelease), for: UIControlEvents.touchUpInside)
        rahCard.addTarget(self, action: #selector(PlayerSelectScreen.rahCardRelease), for: UIControlEvents.touchUpOutside)
 
    
    }
    
    func puckCardRelease(){
      //  playerConfirmScreen.setPlayerCard(cardName: "Card_Puck.png")
      
        
     
    }
    
    // BUG IS HERE HERE HERE HERE
    @IBAction func puckCardPress(_ sender: Any) {
        playerConfirmScreen.cardName = "Card_Puck.png"
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let playerConfirmScreenVC = storyBoard.instantiateViewController(withIdentifier: "PlayerConfirmScreen") as! PlayerConfirmScreen
        self.navigationController?.pushViewController(playerConfirmScreenVC, animated: false)
    }
    
    func kragenCardRelease(){
        self.playerConfirmScreen.setPlayerCard(cardName: "Card_Kragen.png")

    }
    
    func kuufnarCardRelease(){
        self.playerConfirmScreen.setPlayerCard(cardName: "Card_Kuufnar.png")

    }
    
    func rahCardRelease(){
        self.playerConfirmScreen.setPlayerCard(cardName: "Card_Rah.png")

    }
 
}
