//
//  InterfaceController.swift
//  LightsOut WatchKit Extension
//
//  Created by Paul on 10/04/2015.
//  Copyright (c) 2015 Fluid Pixel. All rights reserved.
//

import WatchKit
import Foundation

internal var lastScore:Int? = nil

func delay(time:NSTimeInterval, block: ()->() ) {
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, Int64(time * NSTimeInterval(NSEC_PER_SEC))),
        dispatch_get_main_queue(),
        block)
}

class InterfaceController: WKInterfaceController {
    
    // MARK: IBOutlets
    
    @IBAction func ab1stFl_1() { press(0, y: 0) }
    @IBAction func ab1stFl_2() { press(0, y: 1) }
    @IBAction func ab1stFl_3() { press(0, y: 2) }
    @IBAction func ab1stFl_4() { press(0, y: 3) }
    
    @IBAction func ab2ndFl_1() { press(1, y: 0) }
    @IBAction func ab2ndFl_2() { press(1, y: 1) }
    @IBAction func ab2ndFl_3() { press(1, y: 2) }
    @IBAction func ab2ndFl_4() { press(1, y: 3) }
    
    @IBAction func ab3rdFl_1() { press(2, y: 0) }
    @IBAction func ab3rdFl_2() { press(2, y: 1) }
    @IBAction func ab3rdFl_3() { press(2, y: 2) }
    @IBAction func ab3rdFl_4() { press(2, y: 3) }
    
    @IBAction func ab4thFl_1() { press(3, y: 0) }
    @IBAction func ab4thFl_2() { press(3, y: 1) }
    @IBAction func ab4thFl_3() { press(3, y: 2) }
    @IBAction func ab4thFl_4() { press(3, y: 3) }
    
    @IBOutlet var btn_1stFl_1 : WKInterfaceButton!
    @IBOutlet var btn_1stFl_2 : WKInterfaceButton!
    @IBOutlet var btn_1stFl_3 : WKInterfaceButton!
    @IBOutlet var btn_1stFl_4 : WKInterfaceButton!
    
    @IBOutlet var btn_2ndFl_1 : WKInterfaceButton!
    @IBOutlet var btn_2ndFl_2 : WKInterfaceButton!
    @IBOutlet var btn_2ndFl_3 : WKInterfaceButton!
    @IBOutlet var btn_2ndFl_4 : WKInterfaceButton!
    
    @IBOutlet var btn_3rdFl_1 : WKInterfaceButton!
    @IBOutlet var btn_3rdFl_2 : WKInterfaceButton!
    @IBOutlet var btn_3rdFl_3 : WKInterfaceButton!
    @IBOutlet var btn_3rdFl_4 : WKInterfaceButton!
    
    @IBOutlet var btn_4thFl_1 : WKInterfaceButton!
    @IBOutlet var btn_4thFl_2 : WKInterfaceButton!
    @IBOutlet var btn_4thFl_3 : WKInterfaceButton!
    @IBOutlet var btn_4thFl_4 : WKInterfaceButton!
    
    @IBOutlet var grp_1stFl_1 : WKInterfaceGroup!
    @IBOutlet var grp_1stFl_2 : WKInterfaceGroup!
    @IBOutlet var grp_1stFl_3 : WKInterfaceGroup!
    @IBOutlet var grp_1stFl_4 : WKInterfaceGroup!
    
    @IBOutlet var grp_2ndFl_1 : WKInterfaceGroup!
    @IBOutlet var grp_2ndFl_2 : WKInterfaceGroup!
    @IBOutlet var grp_2ndFl_3 : WKInterfaceGroup!
    @IBOutlet var grp_2ndFl_4 : WKInterfaceGroup!
    
    @IBOutlet var grp_3rdFl_1 : WKInterfaceGroup!
    @IBOutlet var grp_3rdFl_2 : WKInterfaceGroup!
    @IBOutlet var grp_3rdFl_3 : WKInterfaceGroup!
    @IBOutlet var grp_3rdFl_4 : WKInterfaceGroup!
    
    @IBOutlet var grp_4thFl_1 : WKInterfaceGroup!
    @IBOutlet var grp_4thFl_2 : WKInterfaceGroup!
    @IBOutlet var grp_4thFl_3 : WKInterfaceGroup!
    @IBOutlet var grp_4thFl_4 : WKInterfaceGroup!
    
    var groups:[WKInterfaceGroup]!
    var moves:Int = 0
    
    var onOff:[Bool] = [Bool](count: 16, repeatedValue: false) {
        didSet {
            for i in 0 ..< 16 {
                //if oldValue[i] != onOff[i] {
                    groups[i].setBackgroundImageNamed(onOff[i] ? "Window_light" : "WindowDark")
                //}
            }
        }
    }
    var allLightsAreOff:Bool {
        return !onOff.reduce(false) { $0 || $1 }
    }
    func setAllLightsOff() {
        for i in 0 ..< 16 {
            onOff[i] = false
            //groups[i].setBackgroundImageNamed("WindowDark")
        }
    }

    func randomiseLights() {
        setAllLightsOff()
        for i in 0 ..< 16 {
            onOff[i] = drand48() < 0.5
        }
        moves = 0
    }

    func invertState(x:Int, y:Int) {
        if x >= 0 && x < 4 && y >= 0 && y < 4 {
            onOff[x * 4 + y] = !onOff[x * 4 + y]
        }
    }
    
    func press(x:Int, y:Int) {
        
        self.invertState(x-1, y: y-1)
        self.invertState(x-1, y: y)
        self.invertState(x-1, y: y+1)
        self.invertState(x,   y: y-1)
        self.invertState(x,   y: y)
        self.invertState(x,   y: y+1)
        self.invertState(x+1, y: y-1)
        self.invertState(x+1, y: y)
        self.invertState(x+1, y: y+1)
        moves++
        
        if allLightsAreOff {
            self.setTitle("Win \(moves)")
            delay(0.25) {
                lastScore = self.moves
                self.popController()
            }
        }
        else {
            self.setTitle("Moves \(moves)")
        }
        
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
        // Configure interface objects here.
        
        groups = [ grp_1stFl_1, grp_1stFl_2, grp_1stFl_3, grp_1stFl_4, grp_2ndFl_1, grp_2ndFl_2,
            grp_2ndFl_3, grp_2ndFl_4, grp_3rdFl_1, grp_3rdFl_2, grp_3rdFl_3, grp_3rdFl_4,
            grp_4thFl_1, grp_4thFl_2, grp_4thFl_3, grp_4thFl_4]
        
        randomiseLights()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
}
