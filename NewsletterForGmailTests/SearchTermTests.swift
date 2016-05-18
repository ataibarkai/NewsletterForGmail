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
		
		// Test searches with only `AND` operations
		let onlyAndSearch =
				SearchTerm(.From("frmsaul@gmail.com")) &&
				SearchTerm(.To("atai.barkai@gmail.com")) &&
				SearchTerm(.InCategory("inbox"))
		
		XCTAssertEqual(
			"\(onlyAndSearch)",
			"((from:frmsaul@gmail.com) (to:atai.barkai@gmail.com)) (in:inbox)"
		)
		
		
		// Test searches with only `OR` operations
		let onlyOrSearch =
				SearchTerm(.InCategory("inbox")) ||
				SearchTerm(.From("atai.barkai@gmail.com")) ||
				SearchTerm(.To("frmsaul@gmail.com"))

		XCTAssertEqual(
			"\(onlyOrSearch)",
			"((in:inbox) OR (from:atai.barkai@gmail.com)) OR (to:frmsaul@gmail.com)"
		)
		
		// Test searches with a combination of `AND`, `OR` operations
		let orAndSearch =
				(
					SearchTerm(.From("frmsaul@gmail.com")) &&
					SearchTerm(.To("atai.barkai@gmail.com"))
				) ||
				(
					SearchTerm(.InCategory("inbox")) ||
					SearchTerm(.To("frmsaul@gmail.com"))
				)
		XCTAssertEqual(
			"\(orAndSearch)",
			"((from:frmsaul@gmail.com) (to:atai.barkai@gmail.com)) OR ((in:inbox) OR (to:frmsaul@gmail.com))"
		)
		
	}

	
	
}
