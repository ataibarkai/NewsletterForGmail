//
//  TypeBurrito.swift
//  TypeBurrito
//
//  Created by Atai Barkai on 1/11/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

/**
A protocol to be adopted by types that specify and describe a TypeBurrito.

e.g.:

```
enum _Kgs: TypeBurritoSpec { typealias TheTypeInsideTheBurrito = Double }
typealias Kgs = TypeBurrito<_Kgs>

let _ = Kgs(234.2)

```
*/
public protocol TypeBurritoSpec {
	associatedtype TheTypeInsideTheBurrito: Comparable, CustomStringConvertible, Hashable
	
	static func gatewayMap(preMap: TheTypeInsideTheBurrito) -> TheTypeInsideTheBurrito
}

// This extension provides the **identiy** map as the default gatewayMap implementation.
// This means that effectively any TypeBurritoSpec which does not specify a gatewayMap will behave as if it doesn't have one.
// 
// On a first glace, it may appear that this is somewhat dangerous, as a user may cast our underlying type into
// a TypeBurritoSpec, and therefore get the extension's behavior rather than its own specified behvaior.
// However it is **not so** for 2 reasons:
// 1. No *instance* is ever created of a type which conforms to `TypeBurritoSpec`.
//		Only its *type* is used.
//
// 2. As of Swift 2, type covariance and contravariance are not supported (nor are they planned for Swift 3).
//		This would be the only way such a down-cast could occur on the type level (rather than on the instance level).
//		If such support is added in the future, this µframework could probably make good use of it,
//		and would therefore require a redesign at any rate.
public extension TypeBurritoSpec {
	public static func gatewayMap(preMap: TheTypeInsideTheBurrito) -> TheTypeInsideTheBurrito {
		return preMap
	}
}

public struct TypeBurrito <Spec: TypeBurritoSpec>: Comparable, Hashable, CustomStringConvertible, CustomDebugStringConvertible {
	
	// The variable we use to store the value.
	// It is private and should NOT (and cannot) be accessed directly.
	// Instead it should be accessed through the value var
	private var _value: Spec.TheTypeInsideTheBurrito
	
	// The variable we use to access the value.
	// It is read/write (for instance so we can implement += and -=),
	// but it is *internal*, meaning inaccesible for users of the framework.
	internal var value: Spec.TheTypeInsideTheBurrito{
		get {
			return _value
		}
		set{
			// Before setting the value, we first pass it through our gatewayMap function.
			self._value = Spec.gatewayMap(newValue)
		}
	}
	
	// This is a read-only field which is declared *public*,
	// meaning it is accessible to users of the framework.
	// It allows users to get ahold of the stored primitive inside the TypeBurrito
	public var primitiveValueInside: Spec.TheTypeInsideTheBurrito {
		return self.value
	}
	
	public init(_ value: Spec.TheTypeInsideTheBurrito){
		
		// If we could, we would simply set self._value using self.value in this case too.
		// However Swift is unfortunately not smart enough to realize this would satisfy initialization.
		
		self._value = Spec.gatewayMap(value)
	}
	
	// CustomStringConvertible compliance
	public var description: String {
		return self.value.description
	}
	
	// CustomDebugStringConvertible compliance
	public var debugDescription: String {
		return "(\(self.dynamicType)): \(self.value)"
	}
	
	// Hashable compliance
	public var hashValue: Int {
		return self.value.hashValue
	}

}


// Comparable compliance
public func  == <Spec: TypeBurritoSpec>
	(left: TypeBurrito<Spec>, right: TypeBurrito<Spec>) -> Bool {
	return left.value == right.value
}
public func < <Spec: TypeBurritoSpec>
	(left: TypeBurrito<Spec>, right: TypeBurrito<Spec>) -> Bool {
		return left.value < right.value
}


