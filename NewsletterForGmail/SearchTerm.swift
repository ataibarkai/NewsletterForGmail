//
//  SearchTerm.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/16/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation

/**
A search term is a union of several	`SearchTerm.PrimitiveSearchTerm` objects.
It describes the search operations we may use to search for messages in the Gmail API
*/
public struct SearchTerm: Equatable, CustomStringConvertible {
	
	// The search text that this SearchTerm represents.
	//
	// Note: we give up some information (yet it is still recoverable)
	// when we transform a composite SearchTerm into mearly a `String`.
	// We could instead have a stack that can store either a `SearchTerm` or an operation (and, or)
	// and compose the same way a calculator could be implemented.
	// However this point it seems like premature "elegant-ization". Perhaps we will revist this in the future.
	private let searchText: String
	
	// The private (psuedo) "designated" `init` of `SearchTerm`. Simply stuffs the searchText `String`
	private  init(withSearchText _searchText: String) {
		searchText = _searchText
	}
	
	// The public convenience initializer which only lets one create
	// a new `SearchTerm` from a (well-structured) `PrimitiveSearchTerm`.
	//
	// Composite `SearchTerm`s may be created using the `&&` and `||` operators.
	public init(_ primitiveSearchTerm: PrimitiveSearchTerm){
		self.init(withSearchText: "\(primitiveSearchTerm)")
	}
	
	
	public var description: String{
		return searchText
	}
	
	
	public enum PrimitiveSearchTerm: Equatable, Hashable, CustomStringConvertible {
		
		case Keywords(String)
		case From(String)
		case To(String)
		case InCategory(String)
		
		public var description: String{
			switch self{
			case .Keywords(let keywords):
				return "\(keywords)"
			case .From(let from):
				return "from:\(from)"
			case .To(let to):
				return "to:\(to)"
			case .InCategory(let category):
				return "in:\(category)"
			}
		}
		
		public var hashValue: Int{
			return self.description.hashValue
		}
	}
	
}

// `Equatable` conformance for `SearchTerm.PrimitiveSearchTerm`
public func == (left: SearchTerm.PrimitiveSearchTerm, right: SearchTerm.PrimitiveSearchTerm) -> Bool {
	switch (left, right){
	case (.Keywords(let a), .Keywords(let b)):
		return a == b
	case (.From(let a), .From(let b)):
		return a == b
	case (.To(let a), .To(let b)):
		return a == b
	case (.InCategory(let a), .InCategory(let b)):
		return a == b
	default:
		return false
	}
}

// `Equatable` conformance for `SearchTerm`
public func == (left: SearchTerm, right:SearchTerm) -> Bool {
	return (left.searchText == right.searchText)
}

// Compose `SearchTerm`s using a logical `AND`
public func && (left: SearchTerm, right: SearchTerm) -> SearchTerm {
	return SearchTerm(withSearchText:"(\(left)) (\(right))")
}

// Compose `SearchTerm`s using a logical `OR`
public func || (left: SearchTerm, right: SearchTerm) -> SearchTerm {
	return SearchTerm(withSearchText:"(\(left)) OR (\(right))")
}

