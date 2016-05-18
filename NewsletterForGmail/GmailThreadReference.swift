//
//  GmailThreadReference.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/16/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GmailThreadReference: SwiftyJSONDecodable {
	
	let id: String
	let snippet: String
	let historyId: String
	
	init?(withJSON json: JSON){
		guard
			let _id					= json["id"].string,
			let _snippet		= json["snippet"].string,
			let _historyId	= json["historyId"].string
		else{	return nil }
		
		id = _id
		snippet = _snippet
		historyId = _historyId
	}
}