//
//  extensions.swift
//  LIFX
//
//  Created by Aladin TALEB on 14/04/16.
//  Copyright © 2016 Aladin. All rights reserved.
//

import Foundation
import Cocoa

extension NSView {
  
  var backgroundColor: NSColor? {
    get {
      if let colorRef = self.layer?.backgroundColor {
        return NSColor(CGColor: colorRef)
      } else {
        return nil
      }
    }
    set {
      self.wantsLayer = true
      self.layer?.backgroundColor = newValue?.CGColor
    }
  }
}


func stringListFrom(array: [String], prefix: String = "") -> String {
  var toReturn = ""
  for e in array {
    toReturn += (prefix + e + ",")
  }
  toReturn.removeAtIndex(toReturn.endIndex.predecessor())
  return toReturn
}