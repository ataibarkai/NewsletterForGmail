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
	
	// stores all of the primitive searches which this SearchTerm is a union of
	private let primitiveSearches: Set<PrimitiveSearchTerm>
	
	init(_ primitiveSearchTerm: PrimitiveSearchTerm){
		self.primitiveSearches = [primitiveSearchTerm]
	}
	
	private init(withPrimitiveSearches primitiveSearches: Set<PrimitiveSearchTerm>){
		self.primitiveSearches = primitiveSearches
	}
	
	func and(anotherSearch: PrimitiveSearchTerm) -> SearchTerm{
		return SearchTerm(withPrimitiveSearches: self.primitiveSearches.union([anotherSearch]))
	}
	
	
	public var description: String{
		return self.primitiveSearches.map{"\($0)"}.joinWithSeparator(" ")
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

public func == (left: SearchTerm, right:SearchTerm) -> Bool {
	return (left.primitiveSearches == right.primitiveSearches)
}