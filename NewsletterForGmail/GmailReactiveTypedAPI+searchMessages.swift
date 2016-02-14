//
//  GmailReactiveTypedAPI+APICalls.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/14/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveCocoa

extension GmailReactiveTypedAPI {
	
	func searchMessages(onUsername username: String, withSearchString searchString: String){
		
		let a: SignalProducer = self.moyaProivder.request(
			Gmail.SearchMessages(onUsername: username, withSearchString: searchString)
		)
		
		
	}
}