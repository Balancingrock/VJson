// =====================================================================================================================
//
//  File:       VJson-macos.swift
//  Project:    VJson
//
//  Version:    0.11.3
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2018 Marinus van der Lugt, All rights reserved.
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
// 0.11.3 - Ensured that only the top level VJson object can have an undo manager.
//        - Added an customData member of AnyObject that can be used to associate custom data with a VJson object.
// 0.11.1 - Made member undoManager local instead of static.
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

#if os(macOS)

import Foundation

    
public final class VJson: NSObject {
    
    
    /// The undo manager
    ///
    /// - Note: VJson will support the assignment of an undo manager at the top level only.
    
    public var undoManager: UndoManager? {
        get {
            if let parent = parent {
                return parent.undoManager
            } else {
                return _undoManager
            }
        }
        set {
            if parent == nil {
                _undoManager = newValue
            }
        }
    }
    
    private var _undoManager: UndoManager?

    
    /// The JSON type of this object.
    
    public internal(set) var type: JType
    
    
    /// The name of this object if it is part of a name/value pair.
    
    public internal(set) var name: String?
    
    
    /// The value if this is a JSON BOOL.
    
    public internal(set) var bool: Bool?
    
    
    /// The value if this is a JSON NUMBER.
    
    public internal(set) var number: NSNumber?
    
    
    /// The value if this is a JSON STRING.
    
    public internal(set) var string: String?
    
    
    /// Custom data associated with this VJson object.
    ///
    /// - Note: VJson does not do anything with this object. As far as VJson is concerned, this member does not exist. It is not used when copying, duplication, comparing, undo/redo etc.
    
    public var customData: AnyObject?
    
    
    /// The container for all children if self is .array or .object.
    
    public internal(set) var children: Children?
    
    
    /// The parent of a child
    ///
    /// A VJson object cannot have more than one parent. For that reason the parent is stricktly managed: when adding an object, the parent of that object must be nil. When removing an object, the parent of that object will be set to nil.
    ///
    /// - Note: When a parent is assigned, the undo manager will be set to nil.
    
    public internal(set) weak var parent: VJson? {
        didSet { self._undoManager = nil }
    }
    
    
    /// If this object was created to fullfill a subscript access, this property is set to 'true'. It is false for all other objects.
    
    internal var createdBySubscript: Bool = false
    
    
    /// Default initializer
    
    internal init(type: JType, name: String? = nil) {
        
        self.type = type
        self.name = name
        
        super.init()
        
        switch type {
        case .object, .array: children = Children(parent: self)
        default: break
        }
    }
    
    
    /// Creates an empty VJson hierarchy
    
    public convenience override init() {
        self.init(type: .object)
    }
    
    
    /// The custom string convertible protocol.
    
    override public var description: String { return code }

    
    /// Satifies the NSObject protocol
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? VJson else { return false }
        return self == object
    }
    
    public override func copy() -> Any { return duplicate }
}

#endif
