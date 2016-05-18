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
		if	let id =			json["id"].string,
			let snippet =		json["snippet"].string,
			let historyId =		json["historyId"].string {
				self.id = id
				self.snippet = snippet
				self.historyId = historyId
		}
		else{
			return nil
		}
	}
}