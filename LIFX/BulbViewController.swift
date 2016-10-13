//
//  BulbViewController.swift
//  LIFX
//
//  Created by Aladin TALEB on 14/04/16.
//  Copyright © 2016 Aladin. All rights reserved.
//

import Cocoa
import Alamofire

class BulbViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, BulbViewDelegate {
  
  //MARK: Var
  var bulbItems = [Bulb]()
  
  @IBOutlet weak var loadingIndicator: NSProgressIndicator!
  @IBOutlet weak var bulbsTableView: NSTableView!
  
  //MARK: View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do view setup here.
    self.bulbsTableView.sizeLastColumnToFit()
    self.bulbsTableView.columnAutoresizingStyle = .UniformColumnAutoresizingStyle
    self.bulbsTableView.alphaValue = 0
    
    self.loadingIndicator.hidden = false
    self.loadingIndicator.usesThreadedAnimation = false
    self.loadingIndicator.startAnimation(self)
    self.view.frame = NSRect(origin: CGPointZero, size: NSSize(width: 300, height: 40))
    
    BulbManager.sharedManager.getLights()
      .then { bulbs -> () in
        print(bulbs)
        self.bulbItems = bulbs
        self.updateData()
      }.error { error in
        print(error)
    }
    
  }
  
  func updateData() {
    self.bulbsTableView.reloadData()
    self.bulbsTableView.alphaValue = 1
    self.loadingIndicator.stopAnimation(self)
    self.loadingIndicator.hidden = true

    let height = CGFloat(self.bulbItems.count) * tableView(self.bulbsTableView, heightOfRow: 0) + 2;
    let size = NSSize(width: 300, height: height)
    self.view.frame = NSRect(origin: CGPointZero, size: size)

  }
  
  //MARK: NSTableViewDataSource
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return bulbItems.count ?? 0
  }
  
  func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    return 110
  }
  
  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    
    let bulb = bulbItems[row]
    var cellView : BulbCellView!
    
    if let view = tableView.makeViewWithIdentifier("bulbCell", owner: self) as? BulbCellView {
      cellView = view
    }
    
    cellView.delegate = self
    cellView.bulb = bulb
    
    return cellView
    
  }
  
  //MARK: BulbViewDelegate
  func bulbView(view: BulbCellView, didTogglePower power: Bool) {
    if let bulb = view.bulb {
      view.startLoading()
      BulbManager.sharedManager.setForBulb(bulb, power: power)
        .then { _ -> () in
        }.always {
          view.stopLoading()
        }.error { error -> () in
          print(error)
      }
    }
  }
  
  func bulbView(view: BulbCellView, didChangeBrightness brightness: Double) {
    if let bulb = view.bulb {
      view.startLoading()
      BulbManager.sharedManager.setForBulb(bulb, brightness: brightness)
        .then { _ -> () in
        }.always {
          view.stopLoading()
        }.error { error -> () in
          print(error)
        }
      }
  }
  
  func bulbView(view: BulbCellView, didChangeHue hue: Double) {
    if let bulb = view.bulb {
      view.startLoading()
      BulbManager.sharedManager.setForBulb(bulb, hue: hue)
        .then { _ -> () in
        }.always {
          view.stopLoading()
        }.error { error -> () in
          print(error)
      }
    }
  }
  
  func bulbView(view: BulbCellView, didChangeKelvin kelvin: Int) {
    if let bulb = view.bulb {
      view.startLoading()
      BulbManager.sharedManager.setForBulb(bulb, kelvin: kelvin)
        .then { _ -> () in
        }.always {
          view.stopLoading()
        }.error { error -> () in
          print(error)
      }
    }
  }
  
}
