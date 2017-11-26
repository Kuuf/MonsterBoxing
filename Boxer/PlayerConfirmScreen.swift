//
//  PlayerConfirmScreen.swift
//  Boxer
//
//  Created by Jacob Wall on 11/25/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//
import SpriteKit
import Foundation

class PlayerConfirmScreen: UIViewController {

    @IBOutlet weak var testView: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerCard: UIImageView!
    
    //sets player card image to player selected card
    var cardName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setPlayerCard(cardName: cardName)
        
        // setting playerCard to selected Fighter
        if(cardName == "Card_Puck.png"){
            print("Puck")
            //playerCard.image = UIImage(named: "Card_Puck.png")
        }
        if(cardName == "Card_Kragen.png"){
            print("Kragen")

            playerCard.image = UIImage(named: "Card_Kragen.png")
        }
        if(cardName == "Card_Rah.png"){
            print("Rah")

            playerCard.image = UIImage(named: "Card_Rah.png")
        }
        if(cardName == "Card_Kuufnar.png"){
            print("Kuufnar")

            playerCard.image = UIImage(named: "Card_Kuufnar.png")
        }
    }
    
    func setPlayerCard(cardName: String){
        print("cardName:", cardName)
        self.cardName = cardName
        print("self.cardName:", self.cardName, "\n")

    }
    
    
    
}
