//
//  GmailReactiveTypedAPI+APICalls.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/14/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveMoya
import SwiftyJSON



extension GmailTypedReactiveAPIProvider {
	
	func searchMessages(onUsername username: String, withSearchString searchString: String)
		-> SignalProducer<[GmailMessageReference], ReactiveMoya.Error>{
		
		return self.moyaProivder.request(
			Gmail.SearchMessages(onUsername: username, withSearchString: searchString)
		)
			.mapSwiftyJSON()
			.map { primitiveJson in
				return primitiveJson["messages"]
			}
			.mapArray(GmailMessageReference)
	}
}