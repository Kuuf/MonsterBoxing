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
    var card: UIImage!
    
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
        
        //registering different touches for puckCard
        rahCard.addTarget(self, action: #selector(PlayerSelectScreen.rahCardRelease), for: UIControlEvents.touchUpInside)
        rahCard.addTarget(self, action: #selector(PlayerSelectScreen.rahCardRelease), for: UIControlEvents.touchUpOutside)
 
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPlayerConfirmScreen" {
            let destination = segue.destination as! PlayerConfirmScreen
            destination.card = card
        }
    }

    func puckCardRelease(){
        card = UIImage(named: "Card_Puck.png")
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func kragenCardRelease(){
        card = UIImage(named: "Card_Kragen.png")
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func kuufnarCardRelease(){
        card = UIImage(named: "Card_Kuufnar.png")
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
    
    func rahCardRelease(){
        card = UIImage(named: "Card_Rah.png")
        self.performSegue(withIdentifier: "toPlayerConfirmScreen", sender: self)
    }
 
}
