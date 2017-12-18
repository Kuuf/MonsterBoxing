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

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerCard: UIImageView!
    //sets player card image to player selected card
    var playerCardImage: UIImage!
    var playerBoxer = Fighter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerCard.image = playerCardImage
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEnemySelectScreen" {
            let destination = segue.destination as! EnemySelectScreen
            destination.playerBoxer = playerBoxer
            destination.playerCardImage = playerCardImage
        }
    }
    
    @IBAction func touchCheckButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toEnemySelectScreen", sender: self)
    }
}
