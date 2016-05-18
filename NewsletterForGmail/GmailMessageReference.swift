//
//  Message.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/14/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GmailMessageReference: SwiftyJSONDecodable {
	
	let id: String
	let threadId: String
	
	init?(withJSON json: JSON){
		if	let id =			json["id"].string,
			let threadId =		json["threadId"].string {
				self.id = id
				self.threadId = threadId
		}
		else{
			return nil
		}
	}
}