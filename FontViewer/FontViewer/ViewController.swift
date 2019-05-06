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
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  @IBAction func handleFontFamilySelection(_ sender: Any) {
  }
  
  @IBAction func handleFontTypeSelection(_ sender: Any) {
  }
  
  @IBAction func displayAllFonts(_ sender: Any) {
  }
}

