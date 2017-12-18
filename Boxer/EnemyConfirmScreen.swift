//
//  EnemyConfirmScreen.swift
//  Boxer
//
//  Created by Jacob Wall on 12/17/17.
//  Copyright © 2017 Jacob Wall. All rights reserved.
//

import SpriteKit
import Foundation

class EnemyConfirmScreen: UIViewController {
    
    var enemyCardImage: UIImage!
    var playerCardImage: UIImage!
    var enemyBoxer = Fighter()
    var playerBoxer = Fighter()
    var deck = Fighters()
    @IBOutlet weak var enemyCard: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enemyCard.image = enemyCardImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEnemySelectScreen"{
            let destination = segue.destination as! EnemySelectScreen
            destination.enemyCardImage = enemyCardImage
            destination.playerCardImage = playerCardImage
            destination.playerBoxer = playerBoxer
            destination.enemyBoxer = enemyBoxer
        }
        
        if segue.identifier == "toGameViewController"{
            let destination = segue.destination as! GameViewController
            destination.Boxer = playerBoxer
            destination.Opponent = enemyBoxer
        }
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toEnemySelectScreen", sender: self)
    }
    
    @IBAction func fightButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: "toGameViewController", sender: self)
    }
    
}
