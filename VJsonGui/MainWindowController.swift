// =====================================================================================================================
//
//  File:       MainWindowController.swift
//  Project:    SwifterJSON
//
//  Version:    0.9.12
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/pages/projects/swifterjson/
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Swiftrien/SwifterJSON
//
//  Copyright:  (c) 2016 Marinus van der Lugt, All rights reserved.
//
//  License:    Use or redistribute this code any way you like with the following two provision:
//
//  1) You ACCEPT this source code AS IS without any guarantees that it will work as intended. Any liability from its
//  use is YOURS.
//
//  2) You WILL NOT seek damages from the author or balancingrock.nl.
//
//  I also ask you to please leave this header with the source code.
//
//  I strongly believe that the Non Agression Principle is the way for societies to function optimally. I thus reject
//  the implicit use of force to extract payment. Since I cannot negotiate with you about the price of this code, I
//  have choosen to leave it up to you to determine its price. You pay me whatever you think this code is worth to you.
//
//   - You can send payment via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  I prefer the above two, but if these options don't suit you, you might also send me a gift from my amazon.co.uk
//  whishlist: http://www.amazon.co.uk/gp/registry/wishlist/34GNMPZKAQ0OO/ref=cm_sw_em_r_wsl_cE3Tub013CKN6_wb
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  (It is always a good idea to visit the website/blog/google to ensure that you actually pay me and not some imposter)
//
//  For private and non-profit use the suggested price is the price of 1 good cup of coffee, say $4.
//  For commercial use the suggested price is the price of 1 good meal, say $20.
//
//  You are however encouraged to pay more ;-)
//
//  Prices/Quotes for support, modifications or enhancements can be obtained from: rien@balancingrock.nl
//
// =====================================================================================================================
//
//  This JSON implementation was written using the definitions as found on: http://json.org (2015.01.01)
//
// =====================================================================================================================
//
//  As a general rule: use the pipe operators to read from a JSON hierarchy and use the subscript accessors to create
//  the JSON hierarchy. For more information, see the readme file.
//
// =====================================================================================================================
//
// History
//
// v0.9.12 - Initial version.
// =====================================================================================================================

import Foundation
import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet weak var parserSelectPopupButton: NSPopUpButton!
    @IBOutlet weak var durationTextField: NSTextField!
    
    @IBOutlet var outputTextView: NSTextView!
    
    @IBAction func loadButtonAction(sender: AnyObject?) {
        
        let openFilePanel = NSOpenPanel()
        openFilePanel.message = "Select a JSON file:"
        openFilePanel.canChooseDirectories = false
        openFilePanel.allowsMultipleSelection = false
        openFilePanel.runModal()
        
        
        // When the user selected a file
        
        if let file = openFilePanel.url {
            
            do {
                if parserSelectPopupButton.titleOfSelectedItem == "Use VJson Parser" {
                    let now = Date()
                    _ = try VJson.parse(file: file)
                    let duration = Date().timeIntervalSince(now)
                    durationTextField.stringValue = "\(Int(duration * 1000))"
                } else {
                    let now = Date()
                    _ = try VJson.parseUsingAppleParser(Data.init(contentsOf: file))
                    let duration = Date().timeIntervalSince(now)
                    durationTextField.stringValue = "\(Int(duration * 1000))"
                }
                outputTextView.textStorage?.beginEditing()
                outputTextView.textStorage?.mutableString.setString("Parsing succesful")
                outputTextView.textStorage?.endEditing()
            } catch let error as VJson.Exception {
                outputTextView.textStorage?.beginEditing()
                outputTextView.textStorage?.mutableString.setString(error.description)
                outputTextView.textStorage?.endEditing()
            } catch {
                outputTextView.textStorage?.beginEditing()
                outputTextView.textStorage?.mutableString.setString("\(error)")
                outputTextView.textStorage?.endEditing()
            }
        }
    }
}
