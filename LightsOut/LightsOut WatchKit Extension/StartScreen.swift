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
    
    var highScore:Int? = nil
    
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
            
            if newScore < highScore ?? Int.max {
                highScore = newScore
            }
        }
        else {
            
            resultLabel.setText("")
        }
        
        if let hs = highScore {
            highScoreLabel.setText("HighScore\n\(hs) moves")
        }
        else {
            highScoreLabel.setText("")
        }
    }
}
