//
//  AppDelegate.swift
//  LIFX
//
//  Created by Aladin TALEB on 14/04/16.
//  Copyright © 2016 Aladin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
  let viewController = BulbViewController(nibName: "BulbViewController", bundle: nil)
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    NSApplication.sharedApplication().windows.last!.close()
    
    if let button = statusItem.button {
      button.image = NSImage(named: "bulb")
      
      let menu = NSMenu(title: "")
      var item = NSMenuItem(title: "", action: nil, keyEquivalent: "")
      item.view = viewController?.view
      menu.addItem(item)
      menu.addItem(NSMenuItem.separatorItem())
      item = NSMenuItem(title: "Quit", action: #selector(AppDelegate.quitApp(_:)), keyEquivalent: "CMD+Q")
      menu.addItem(item)
      
      statusItem.menu = menu
    }
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
  func applicationShouldOpenUntitledFile(sender: NSApplication) -> Bool {
    return true
  }
  
  func quitApp(sender: AnyObject?) {
    NSApp.terminate(self)
  }

}

