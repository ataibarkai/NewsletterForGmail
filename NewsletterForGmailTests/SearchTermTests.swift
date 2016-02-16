//
//  SearchTermTests.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/15/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import XCTest
@testable import NewsletterForGmail

class SearchTermTests: XCTestCase {
	
	func testPrimitiveSearchTerm() {
		
		let keywordsSearchTerm = SearchTerm.PrimitiveSearchTerm.Keywords("hello world")
		XCTAssertEqual("\(keywordsSearchTerm)", "hello world")
		
		let fromSearchTerm = SearchTerm.PrimitiveSearchTerm.From("uliyahoo@gmail.com")
		XCTAssertEqual("\(fromSearchTerm)", "from:uliyahoo@gmail.com")
		
		let toSearchTerm = SearchTerm.PrimitiveSearchTerm.To("atai.barkai@gmail.com")
		XCTAssertEqual("\(toSearchTerm)", "to:atai.barkai@gmail.com")
		
		let inCategorySearchTerm = SearchTerm.PrimitiveSearchTerm.InCategory("inbox")
		XCTAssertEqual("\(inCategorySearchTerm)", "in:inbox")

	}

	
	func testCompositeSearch() {
		let searchTerm = SearchTerm(.From("frmsaul@gmail.com"))
			.and(.To("atai.barkai@gmail.com"))
			.and(.InCategory("inbox"))
		
		let searchString = "\(searchTerm)"
		
		let components = searchString.componentsSeparatedByString(" ")
		XCTAssertEqual(components.count, 3)
		XCTAssert(components.contains("from:frmsaul@gmail.com"))
		XCTAssert(components.contains("to:atai.barkai@gmail.com"))
		XCTAssert(components.contains("in:inbox"))
	}

	
	
}
