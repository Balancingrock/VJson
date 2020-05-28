// =====================================================================================================================
//
//  File:       VJson-macos.swift
//  Project:    VJson
//
//  Version:    1.2.1
//
//  Author:     Marinus van der Lugt
//  Company:    http://balancingrock.nl
//  Website:    http://swiftfire.nl/projects/swifterjson/swifterjson.html
//  Git:        https://github.com/Balancingrock/VJson
//
//  Copyright:  (c) 2014-2019 Marinus van der Lugt, All rights reserved.
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
//  Like you, I need to make a living:
//
//   - You can send payment (you choose the amount) via paypal to: sales@balancingrock.nl
//   - Or wire bitcoins to: 1GacSREBxPy1yskLMc9de2nofNv2SNdwqH
//
//  If you like to pay in another way, please contact me at rien@balancingrock.nl
//
//  Prices/Quotes for support, modifications or enhancements can be obtained from: rien@balancingrock.nl
//
// =====================================================================================================================
// PLEASE let me know about bugs, improvements and feature requests. (rien@balancingrock.nl)
// =====================================================================================================================
//
// History
//
// 1.2.1 - Added warnings to name and string variables.
// 1.0.0 - Removed older history
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
    
    public var type: JType {
        willSet {
            if !VJson.typeChangeIsAllowed(from: type, to: newValue) {
                assert(false, "Type conversion from \(type) to \(newValue) is not allowed")
                fatalError("Type conversion from \(type) to \(newValue) is not allowed")
            }
        }
        didSet {
            self.createdBySubscript = false
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
            if #available(OSX 10.11, *) {
                undoManager?.registerUndo(withTarget: self) {
                    [oldValue] (json) -> Void in
                    json.type = oldValue
                }
            }
        }
    }
    
    
    /// The name of this object if it is part of a name/value pair.
    ///
    /// - Warning: If the name contains an escape sequence, that sequence will be returned as is. Use nameValue if the escape sequence should be converted to normal Character representations, use stringValuePrintable to also change invisibles to printable characters.

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
    ///
    /// - Warning: If the string contains an escape sequence, that sequence will be returned as is. Use stringValue if the escape sequence should be converted to normal Character representations, use stringValuePrintable to also change invisibles to printable characters.
    
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
