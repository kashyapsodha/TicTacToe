//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kashyap Sodha on 3/3/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    var activePlayer = 1 // Cross
    var gameState = [0,0,0,0,0,0,0,0,0]
    
    let winningCombos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], // horizontal
                        [0, 3, 6], [1, 4, 7], [2, 5, 8], // vertical
                        [0, 4, 8], [2, 4, 6]] // diagonals
    
    var gameOn = true

    @IBAction func actions(_ sender: AnyObject) {
        if (gameState[sender.tag - 1] == 0 && gameOn == true){
            // To not allow other user edit on the same button
            gameState[sender.tag - 1] = activePlayer
            
            if (activePlayer == 1){
                sender.setImage(UIImage(named: "Cross.png"), for: UIControl.State())
                activePlayer = 2
            }
            else{
                sender.setImage(UIImage(named: "Nought.png"), for: UIControl.State())
                activePlayer = 1
            }
        }
        for combo in winningCombos{
            if (gameState[combo[0]] != 0 && gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]]){
                // Stop the game
                gameOn = false
                
                // Check who won
                if (gameState[combo[0]] == 1){
                    resultLabel.text = "Cross Wins!"
                }
                else{
                    resultLabel.text = "Nought Wins!"
                    
                }
                playAgainButton.isHidden = false
                resultLabel.isHidden = false
                disableButtons()
            }
        }
        
        gameOn = false
        
        for i in gameState{
            if (i == 0){
                gameOn = true
                break
            }
        }
        if (gameOn == false){
            resultLabel.text = "It's a tie!"
            playAgainButton.isHidden = false
            resultLabel.isHidden = false
        }
    }
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: AnyObject) {
        gameState = [0,0,0,0,0,0,0,0,0]
        gameOn = true
        activePlayer = 1
        
        playAgainButton.isHidden = true
        resultLabel.isHidden = true
        enableButtons()
        
        
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    // Disable all the buttons on the board after a result but not tie
    func disableButtons() {
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = false
        }
    }
    
    // Enable the buttons when 'Play Again' is clicked
    func enableButtons() {
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.isEnabled = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

