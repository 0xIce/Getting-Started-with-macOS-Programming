//
//  FontsDisplayViewController.swift
//  FontViewer
//
//  Created by 马红奇 on 2019/5/6.
//  Copyright © 2019 hongqima. All rights reserved.
//

import Cocoa

class FontsDisplayViewController: NSViewController {

  @IBOutlet var fontsTextView: NSTextView!
  var fontFamily: String?
  var fontFamilyMembers = [[Any]]()
  var fontPostscriptNames = ""
  var lengths = [Int]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTextView()
  }
  
  override func viewWillAppear() {
    super.viewWillAppear()
    showFonts()
  }
  
  private func setupTextView() {
    fontsTextView.backgroundColor = NSColor(white: 1.0, alpha: 0.0)
    fontsTextView.enclosingScrollView?.backgroundColor = NSColor(white: 1.0, alpha: 0.0)
    fontsTextView.isEditable = false
    fontsTextView.enclosingScrollView?.autohidesScrollers = true
  }
  
  private func showFonts() {
    guard let fontFamily = fontFamily else { return }
    fontFamilyMembers.forEach { (member) in
      if let postscript = member[0] as? String {
        self.fontPostscriptNames += "\(postscript)\n"
        self.lengths.append(postscript.count)
      }
    }
    let attributedString = NSMutableAttributedString(string: fontPostscriptNames)
    var location = 0
    for (index, member) in fontFamilyMembers.enumerated() {
      if let weight = member[2] as? Int,
        let traits = member[3] as? UInt,
        let font = NSFontManager.shared.font(withFamily: fontFamily, traits: NSFontTraitMask(rawValue: traits), weight: weight, size: 19) {
        let range = NSRange(location: location, length: lengths[index])
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        location += lengths[index] + 1
      }
    }
    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.white, range: NSRange(location: 0, length: attributedString.string.count))
    fontsTextView.textStorage?.setAttributedString(attributedString)
  }
    
  @IBAction func closeWindow(_ sender: Any) {
    view.window?.close()
  }
}
