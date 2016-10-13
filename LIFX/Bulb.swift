//
//  Bulb.swift
//  LIFX
//
//  Created by Aladin TALEB on 14/04/16.
//  Copyright © 2016 Aladin. All rights reserved.
//

import Foundation
import Gloss

class Bulb: Decodable {
  //MARK: VAR
  var id:         String!
  var uuid:       String!
  var label:      String!
  var connected:  Bool!
  var power:      Bool!
  
  var brightness: Double!
  
  
  //INIT LIGHT BULB FROM JSON
  required init?(json: JSON) {
    guard let _id:    String = "id"     <~~ json else {return nil}
    guard let _label: String = "label"  <~~ json else {return nil}
    guard let _power: String = "power"  <~~ json else {return nil}
    
    guard let _brightness: Double = "brightness" <~~ json else {return nil}

    self.id = _id
    self.label = _label
    self.power = _power == "on" ? true: false
    self.brightness = _brightness
  }
  
}