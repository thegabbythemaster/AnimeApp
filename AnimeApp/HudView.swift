//
//  HudView.swift
//  AnimeApp
//
//  Created by Gabby Gonzalez on 3/18/21.
//

import UIKit

class HudView: UIView {
  var text = ""

  class func hud(
    inView view: UIView,
    animated: Bool
  ) -> HudView {
    let hudView = HudView(frame: view.bounds)
    hudView.isOpaque = false

    view.addSubview(hudView)
    view.isUserInteractionEnabled = false
    
    return hudView
  }
    override func draw(_ rect: CGRect) {
      let boxWidth: CGFloat = 96
      let boxHeight: CGFloat = 96

    let boxRect = CGRect(
          x: round((bounds.size.width - boxWidth) / 2),
          y: round((bounds.size.height - boxHeight) / 2),
          width: boxWidth,
          height: boxHeight)

      let roundedRect = UIBezierPath(
        roundedRect: boxRect,
        cornerRadius: 10)
      UIColor(white: 0.3, alpha: 0.8).setFill()
      roundedRect.fill()
        
    let attribs = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

    let textSize = text.size(withAttributes: attribs)

    let textPoint = CGPoint(
          x: center.x - round(textSize.width / 2),
          y: center.y - round(textSize.height / 2) + boxHeight / 4)

        text.draw(at: textPoint, withAttributes: attribs)
    }

}


