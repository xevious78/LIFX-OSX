//
//  BulbCellView.swift
//  LIFX
//
//  Created by Aladin TALEB on 14/04/16.
//  Copyright © 2016 Aladin. All rights reserved.
//

import Cocoa
import Foundation

//Callback Delegate
protocol BulbViewDelegate {
  func bulbView(view: BulbCellView, didTogglePower power: Bool)
  func bulbView(view: BulbCellView, didChangeBrightness brightness: Double)
  func bulbView(view: BulbCellView, didChangeHue hue: Double)
  func bulbView(view: BulbCellView, didChangeKelvin kelvin: Int)
}

class BulbCellView: NSTableCellView {
  
  //MARK: Var
  weak var bulb: Bulb? {
    didSet {
      configure()
    }
  }
  var delegate: BulbViewDelegate?
  
  @IBOutlet weak var nameLabel: NSTextField!
  @IBOutlet weak var brightnessSlider: NSSlider!
  @IBOutlet weak var hueSlider: NSSlider!
  @IBOutlet weak var kelvinSlider: NSSlider!
  @IBOutlet weak var enabledButton: NSButton!
  @IBOutlet weak var activityIndicator: NSProgressIndicator!
  
  
  //MARK: View Life Cycle
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func drawRect(dirtyRect: NSRect) {
    super.drawRect(dirtyRect)
    
    // Drawing code here.
  }
  
  func configure() {
    stopLoading()
    
    nameLabel.drawsBackground = true
    nameLabel.backgroundColor = NSColor.clearColor()
    nameLabel.stringValue = bulb!.label as String

    brightnessSlider.intValue = Int32(bulb!.brightness * 100)
    enabledButton.state = bulb!.power == true ? NSOnState : NSOffState
  }
  
  func startLoading() {
    activityIndicator.startAnimation(self)
    activityIndicator.hidden = false
  }
  
  func stopLoading() {
    activityIndicator.stopAnimation(self)
    activityIndicator.hidden = true
  }
  
  //MARK: Callbacks
  @IBAction func brightnessSliderDidChange(sender: AnyObject) {
    delegate?.bulbView(self, didChangeBrightness: Double(brightnessSlider.intValue) / 100.0)
  }
  
  @IBAction func enabledButtonDidChange(sender: AnyObject) {
    delegate?.bulbView(self, didTogglePower: enabledButton.state == NSOnState)
  }
  
  @IBAction func hueSliderDidChange(sender: AnyObject) {
    delegate?.bulbView(self, didChangeHue: Double(hueSlider.intValue) / 100.0)
  }
  
  @IBAction func kelvinSliderDidChange(sender: AnyObject) {
    delegate?.bulbView(self, didChangeKelvin: Int(kelvinSlider.intValue))
  }
  
}
