//
//  GmailReactiveTypedAPI+APICalls.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/14/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Moya
import SwiftyJSON


extension GmailTypedReactiveAPIProvider {
	
	func searchMessages(onUsername username: String, withSearchTerm searchTerm: SearchTerm)
		-> SignalProducer<[GmailMessageReference], Error>{
		
		return self.moyaProivder.request(
			Gmail.SearchMessages(
				onUsername: username,
				withSearchTerm: searchTerm
			)
		)
			.mapSwiftyJSON()
			.map { $0["messages"] }
			.mapArray(GmailMessageReference)
	}
}



