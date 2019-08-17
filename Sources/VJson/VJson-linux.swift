// =====================================================================================================================
//
//  File:       VJson-linux.swift
//  Project:    VJson
//
//  Version:    1.0.0
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
// 1.0.0 - Removed older history
// =====================================================================================================================

// =========================================
// PREPARED ONLY, NOT YET COMPILED OR TESTED
// =========================================

#if os(Linux)

import Foundation

    
public final class VJson: Equatable, CustomStringConvertible {
    
    
    /// The undo manager
    
    public static var undoManager: UndoManager?

    
    /// Set this option to 'true' to help find unwanted type conversions (in the debugging phase?).
    ///
    /// A type conversion occures if -for example- a string is assigned to a JSON item that contains a BOOL. If this flag is set to 'true', such a conversion will result in a fatal error. If this flag is set to 'false', the conversion will happen silently.
    ///
    /// Conversion to and from NULL are always possible, if it is necessary to force a type change irrespective of the value of this flag make two changes, first to NULL then to the desired type.
    
    public static var fatalErrorOnTypeConversion = true
    
    
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
    
    
    /// The container for all subitems if self is .array or .object.
    
    public internal(set) var children: Children?
    
    
    /// The parent of a child
    ///
    /// A VJson object cannot have more than one parent. For that reason the parent is stricktly managed: when adding an object, the parent of that object must be nil. When removing an object, the parent of that object will be set to nil.
    
    public internal(set) weak var parent: VJson?
    
    
    /// If this object was created to fullfill a subscript access, this property is set to 'true'. It is false for all other objects.
    
    fileprivate var createdBySubscript: Bool = false
    
    
    /// Default initializer
    
    internal init(type: JType, name: String? = nil) {
        
        self.type = type
        self.name = name
        
        switch type {
        case .object, .array: children = Children(parent: self)
        default: break
        }
    }
    
    
    /// Creates an empty VJson hierarchy
    
    public convenience init() {
        self.init(type: .object)
    }
    
    
    /// Copying
    
    public func copy() -> Any { return duplicate }
    
    
    /// The custom string convertible protocol.
    
    public var description: String { return code }
}

#endif
