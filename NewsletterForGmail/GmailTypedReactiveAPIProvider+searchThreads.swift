//
//  File.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/16/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Moya
import SwiftyJSON

extension GmailTypedReactiveAPIProvider {
	
	func searchThreads(onUsername username: String, withSearchTerm searchTerm: SearchTerm)
	 -> SignalProducer<[GmailThreadReference], Error>{
		
			return self.moyaProivder.request(
				Gmail.SearchThreads(
					onUsername: username,
					withSearchTerm: searchTerm
				)
			)
			.mapSwiftyJSON()
			.map { $0["threads"] }
			.mapArray(GmailThreadReference)
	}
}

