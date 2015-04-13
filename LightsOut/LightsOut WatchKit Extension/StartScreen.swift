//
//  StartScreen.swift
//  LightsOut
//
//  Created by Paul on 10/04/2015.
//  Copyright (c) 2015 Fluid Pixel. All rights reserved.
//

import WatchKit
import Foundation

class StartScreen: WKInterfaceController {
    // MARK: IBOutlets
    @IBOutlet var resultLabel:WKInterfaceLabel!
    @IBOutlet var highScoreLabel:WKInterfaceLabel!
    
    var highScore:Int = Int.max
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        handleScore()
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        handleScore()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func handleScore() {
        if let newScore = lastScore {
            lastScore = nil
            
            resultLabel.setText("You did it in\n\(newScore) moves")
			
            if newScore < highScore {
                highScore = newScore
            }
        }
        else {
            
            resultLabel.setText("")
        }
        
        if highScore < Int.max {
            highScoreLabel.setText("HighScore\n\(highScore) moves")
        } else {
            highScoreLabel.setText("")
        }
    }
}
