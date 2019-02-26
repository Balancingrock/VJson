// =====================================================================================================================
//
//  File:       VJson-macos.swift
//  Project:    VJson
//
//  Version:    0.15.4
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
//  I strongly believe that voluntarism is the way for societies to function optimally. I thus reject
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
// 0.15.4 - Improved code clarity of undo/redo, fixed undo/redo problem for type changes
// 0.15.3 - Reimplemented undo/redo
// 0.15.0 - Harmonized names, now uses 'item' or 'items' for items contained in OBJECTs instead of 'child'
//          or 'children'. The name 'child' or 'children' is now used exclusively for operations transcending
//          OBJECTs or ARRAYs.
//          General overhaul of comments and documentation.
// 0.13.0 - Improved escape sequence support, name is now translated to an escaped sequence.
// 0.11.3 - Ensured that only the top level VJson object can have an undo manager.
//        - Added an customData member of AnyObject that can be used to associate custom data with a VJson object.
// 0.11.1 - Made member undoManager local instead of static.
// 0.10.8 - Split off from VJson.swift
// =====================================================================================================================

#if os(macOS)

import Foundation

    
public final class VJson: NSObject {
    
    
    /// The undo manager.
    ///
    /// VJson supports a single undo manager that is always written to the root item (top level) of a JSON hierarchy.
    ///
    /// When the undo manager is set, VJson will automatically use it. (From OSX 10.11 onward)
    ///
    /// - Note: VJson supports the assignment of an undo manager at the top level only.
    
    public var undoManager: UndoManager? {
        get {
            if let parent = parent {
                return parent.undoManager
            } else {
                return _undoManager
            }
        }
        set {
            if let parent = parent {
                parent._undoManager = newValue
            } else {
                _undoManager = newValue
            }
        }
    }
    
    private var _undoManager: UndoManager?

    
    /// The JSON type of this object.
    
    public internal(set) var type: JType {
        willSet {
            if !VJson.typeChangeIsAllowed(from: type, to: newValue) {
                assert(false, "Type conversion from \(type) to \(newValue) is not allowed")
                fatalError("Type conversion from \(type) to \(newValue) is not allowed")
            }
        }
        didSet {
            self.createdBySubscript = false
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.type = oldValue
                }
            }
            switch oldValue {
            case .null:
                switch type {
                case .null: break
                case .bool, .number, .string: break
                case .array, .object: children = Children(parent: self)
                }
            case .bool:
                switch type {
                case .null, .number, .string: bool = nil
                case .bool: break
                case .array, .object: bool = nil; children = Children(parent: self)
                }
            case .number:
                switch type {
                case .null, .bool, .string: number = nil
                case .number: break
                case .array, .object: number = nil; children = Children(parent: self)
                }
            case .string:
                switch type {
                case .null, .bool, .number: string = nil
                case .string: break
                case .array, .object: string = nil; children = Children(parent: self)
                }
            case .array:
                switch type {
                case .null, .bool, .number, .string: children = nil
                case .array: break
                case .object: for c in self { c.name = nil }
                }
            case .object:
                switch type {
                case .null, .bool, .number, .string: children = nil
                case .array: for (i, c) in self.enumerated() { if c.name == nil { c.name = "Child \(i)" } }
                case .object: break
                }
            }
        }
    }
    
    
    /// The name of this object if it is part of a name/value pair.
    
    public internal(set) var name: String? {
        didSet {
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.name = oldValue
                }
            }
        }
    }
    
    
    /// The value if this is a JSON BOOL.
    
    public internal(set) var bool: Bool? {
        didSet {
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.bool = oldValue
                }
            }
        }
    }
    
    
    /// The value if this is a JSON NUMBER.
    
    public internal(set) var number: NSNumber? {
        didSet {
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.number = oldValue
                }
            }
        }
    }
    
    
    /// The value if this is a JSON STRING.
    
    public internal(set) var string: String? {
        didSet {
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.string = oldValue
                }
            }
        }
    }
    
    
    /// Custom data associated with this VJson object.
    ///
    /// VJson does not support inheritance, this member may be used to provide similar functionalty. It is for the API user only. VJson itself never accesses this member.
    ///
    /// - Note: The API user must implement undo/redo operations if necessary!
    
    public var customData: AnyObject?
    
    
    /// The container for all subitems if self is .array or .object.
    
    public internal(set) var children: Children? {
        didSet {
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.children = oldValue
                }
            }
        }
    }
    
    
    /// The parent of a child
    ///
    /// A VJson object cannot have more than one parent. For that reason the parent is stricktly managed: when adding an object, the parent of that object must be nil. When removing an object, the parent of that object will be set to nil.
    ///
    /// - Note: When a parent is assigned, the undo manager will be set to nil.
    
    public internal(set) weak var parent: VJson? {
        didSet { self._undoManager = nil }
    }
    
    
    /// If this object was created to fullfill a subscript access, this property is set to 'true'. It is false for all other objects.
    
    internal var createdBySubscript: Bool = false {
        didSet {
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.createdBySubscript = oldValue
                }
            }
        }
    }
    
    
    /// Default initializer
    
    internal init(type: JType, name: String? = nil) {
        
        self.type = type
        self.name = name?.stringToJsonString()
        
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
