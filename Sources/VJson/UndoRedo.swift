// =====================================================================================================================
//
//  File:       UndoRedo.swift
//  Project:    VJson
//
//  Version:    0.10.8
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Blog:       http://swiftrien.blogspot.com
//  Git:        https://github.com/Balancingrock/SwifterJSON
//
//  Copyright:  (c) 2014-2017 Marinus van der Lugt, All rights reserved.
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
//  wishlist: http://www.amazon.co.uk/gp/registry/wishlist/34GNMPZKAQ0OO/ref=cm_sw_em_r_wsl_cE3Tub013CKN6_wb
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  (It is always a good idea to check the website http://www.balancingrock.nl before payment)
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
// History
//
// 0.10.8  - Initial version
// =====================================================================================================================


#if os(OSX)
    
import Foundation
import Cocoa


extension VJson {
    
    
    /// Returns the root of the hierarchy and the path from there to this item.
    
    internal func location() -> (root: VJson, path: Array<String>)? {
        
        
        // If there is no parent, this this is the top level and the path is empty.
        
        guard let _ = parent else { return (self, []) }
        
        
        // The path that will be returned.
        
        var path: Array<String> = []
        
        
        // The root that will be returned.
        
        var root: VJson
        
        
        // The itteration variables
        
        var item: VJson? = self // Start at the 'bottom'
        var nextUp: VJson? = self.parent
        
        repeat {
            
            root = item! // Only the last assignment will 'stick'
            
            
            // Check if the path part is an array index or a name
            
            if (nextUp?.type ?? .object) == .array {
                
                
                // Determine the array index
                
                if let index = nextUp?.index(of: item) {
                    path.insert(index.description, at: 0)
                } else {
                    // Impossible
                    assert(false, "Child not contained in parent.\nChild = \(String(describing: item))\n\nParent = \(String(describing: nextUp))")
                }
                
            } else {
                
                
                // There must be a name if the parent is non-nil
                
                if nextUp != nil {
                    
                    if let pathPart = item?.name {
                        path.insert(pathPart, at: 0)
                    } else {
                        // Impossible
                        assert(false, "The child from an object should always have a name.\nChild = \(String(describing: item))\n\nParent = \(String(describing: nextUp))")
                    }
                    
                } else {
                    
                    // The parent is nil. For the top level object an empty path element should be returned. Hence nothing should be done here.
                }
            }
            
            
            // Prepare for the next itteration
            
            item = nextUp
            nextUp = nextUp?.parent
            
            
            // Stop itterating if there are no more items
            
        } while item != nil
        
        
        return (root, path)
    }

    
    /// Returns a clone of this JSON object for undo/redo purposes.
    
    internal func undoRedoClone() -> VJson {
        let other = VJson(type: self.type, name: self.name)
        other.type = self.type
        other.bool = self.bool
        other.string = self.string
        other.number = self.numberValue
        other.createdBySubscript = self.createdBySubscript
        if self.children != nil {
            other.children!.cacheEnabled = self.children!.cacheEnabled
            for c in self.children!.items {
                let dupc = c.duplicate // duplicate does not update parent
                dupc.parent = self
                other.children!.items.append(dupc)
            }
        }
        return other
    }
    
    
    /// Sets the content of self to the content in other. This operation is the exact opposite of the undoRedoClone and should only be used as such.
    
    internal func undoRedoAssignment(from other: VJson) {
        
        recordUndoRedoAction() // Registers as a redo
        
        self.name = other.name
        self.type = other.type
        self.bool = other.bool
        self.string = other.string
        self.number = other.numberValue
        self.createdBySubscript = other.createdBySubscript
        if other.children != nil {
            self.children = Children(parent: self)
            self.children!.cacheEnabled = other.children!.cacheEnabled
            for c in other.children!.items {
                assert(self === c.parent, "Parent should be the same as the old parent")
                _ = self.children?.append(c) // Updates parent setting, should be the same however.
            }
        } else {
            self.children = nil
        }
    }
    
    
    internal func recordUndoRedoAction() {
        
        if let undoManager = VJson.undoManager {
            
            if #available(OSX 10.11, *) {
                
                if let (root, path) = self.location() {
                    
                    let clone = undoRedoClone()
                    
                    undoManager.registerUndo(withTarget: root, handler: {
                        [path, clone] (root) -> Void in
                        if let item = root.item(at: path) {
                            item.undoRedoAssignment(from: clone)
                        } else {
                            NSSound.beep()
                            assert(false, "ERROR - Cannot undo, target for undo at path '\(path)' not found")
                        }
                    })
                }
                
            } else {
                assert(false, "Undo/Redo support needs at least macOS 10.11")
            }
        }
    }
}
    
#endif
