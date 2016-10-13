import Foundation
import Cocoa

//Rainbow Slider
class HueSliderCell: NSSliderCell {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func drawBarInside(aRect: NSRect, flipped: Bool) {
    var rect = aRect
    rect.size.height = CGFloat(2)
    let barRadius = CGFloat(0)
    
    let value = CGFloat((self.doubleValue - self.minValue) / (self.maxValue - self.minValue))
    let finalWidth = CGFloat(value * (self.controlView!.frame.size.width - 8))
    var leftRect = rect
    leftRect.size.width = finalWidth
    
    for i in 0..<100 {
      var r = rect
      r.size.width /= 100.0
      r.origin.x += CGFloat(i) * r.size.width
      let bg = NSBezierPath(roundedRect: r, xRadius: barRadius, yRadius: barRadius)
      NSColor(calibratedHue: CGFloat(i) / 100.0, saturation: 1, brightness: 1, alpha: 1).setFill()
      bg.fill()
    }
  }
  
}