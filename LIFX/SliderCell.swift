import Foundation
import Cocoa

//Gray Slider
class SliderCell: NSSliderCell {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func drawBarInside(aRect: NSRect, flipped: Bool) {
    var rect = aRect
    rect.size.height = CGFloat(2)
    let barRadius = CGFloat(1)
    
    let value = CGFloat((self.doubleValue - self.minValue) / (self.maxValue - self.minValue))
    let finalWidth = CGFloat(value * (self.controlView!.frame.size.width - 8))
    var leftRect = rect
    leftRect.size.width = finalWidth
    
    let bg = NSBezierPath(roundedRect: rect, xRadius: barRadius, yRadius: barRadius)
    NSColor(white: 200/255.0, alpha: 0.8).setFill()
    bg.fill()
    let active = NSBezierPath(roundedRect: leftRect, xRadius: barRadius, yRadius: barRadius)
    NSColor(white: 120/255.0, alpha: 1.0).setFill()
    active.fill()
  }
  
}