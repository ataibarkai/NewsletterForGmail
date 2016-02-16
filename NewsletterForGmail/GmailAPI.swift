//
//  GmailAPI.swift
//  SwiftyGmail
//
//  Created by Atai Barkai on 2/11/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveMoya


public enum Gmail {
	
	case SearchMessages(onUsername: String, withSearchTerm: SearchTerm)
	case SearchThreads(onUsername: String, withSearchTerm: SearchTerm)
}

extension Gmail{
	
	// each Gmail API call
	public var username: String {
		switch self {
		case .SearchMessages(onUsername: let username, withSearchTerm: _):
			return username
		case .SearchThreads(onUsername: let username, withSearchTerm: _):
			return username
		}
	}
}

extension Gmail: TargetType {
	public var baseURL: NSURL { return NSURL(string: "https://www.googleapis.com/gmail/v1/users/\(self.username)")! }
	public var path: String {
		
		switch self {
		case .SearchMessages(_):
			return "/messages"
		case .SearchThreads(_):
			return "/threads"
		}

	}
	public var method: ReactiveMoya.Method {
		switch self{
		case .SearchMessages(_):
			return .GET
		case .SearchThreads(_):
			return .GET
		}
	}
	
	public var parameters: [String: AnyObject]? {
		switch self {
		case .SearchMessages(onUsername: _, withSearchTerm: let searchTerm):
			return [
				"q": "\(searchTerm)",
			]
		case .SearchThreads(onUsername: _, withSearchTerm: let searchTerm):
			return [
				"q": "\(searchTerm)",
			]
		}
	}
	
	public var sampleData: NSData {
		switch self {
		default:
			return "".dataUsingEncoding(NSUTF8StringEncoding)!
		}
	}
}


