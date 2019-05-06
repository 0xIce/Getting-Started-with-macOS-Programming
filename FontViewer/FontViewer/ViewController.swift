//
//  ViewController.swift
//  FontViewer
//
//  Created by 马红奇 on 2019/5/6.
//  Copyright © 2019 hongqima. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  @IBOutlet weak var fontFamiliesPopup: NSPopUpButton!
  @IBOutlet weak var fontTypesPopup: NSPopUpButton!
  @IBOutlet weak var sampleLabel: NSTextField!
  private var selectedFontFamily: String?
  private var fontFamilyMembers = [[Any]]()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    populateFontFamilies()
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  private func setupUI() {
    fontFamiliesPopup.removeAllItems()
    fontTypesPopup.removeAllItems()
    sampleLabel.stringValue = ""
    sampleLabel.alignment = .center
  }
  
  private func populateFontFamilies() {
    fontFamiliesPopup.removeAllItems()
    fontFamiliesPopup.addItems(withTitles: NSFontManager.shared.availableFontFamilies)
    handleFontFamilySelection(self)
  }
  
  private func updateFontTypesPopup() {
    fontTypesPopup.removeAllItems()
    fontTypesPopup.addItems(withTitles: fontFamilyMembers.compactMap { $0[1] as? String })
    handleFontTypeSelection(self)
  }

  @IBAction func handleFontFamilySelection(_ sender: Any) {
    guard let fontFamily = fontFamiliesPopup.titleOfSelectedItem else {
      return
    }
    selectedFontFamily = fontFamily
    if let members = NSFontManager.shared.availableMembers(ofFontFamily: fontFamily) {
      fontFamilyMembers = members
      updateFontTypesPopup()
      view.window?.title = fontFamily
    }
  }
  
  @IBAction func handleFontTypeSelection(_ sender: Any) {
    let selectedMember = fontFamilyMembers[fontTypesPopup.indexOfSelectedItem]
    guard let postscriptName = selectedMember[0] as? String,
      let weight = selectedMember[2] as? Int,
      let traits = selectedMember[3] as? UInt,
      let fontfamily = selectedFontFamily else {
        return
    }
    let font = NSFontManager.shared.font(withFamily: fontfamily,
                                         traits: NSFontTraitMask(rawValue: traits),
                                         weight: weight,
                                         size: 19.0)
    sampleLabel.font = font
    sampleLabel.stringValue = postscriptName
  }
  
  @IBAction func displayAllFonts(_ sender: Any) {
  }
}

