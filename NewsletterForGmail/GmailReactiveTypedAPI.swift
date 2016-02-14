//
//  GmailReactiveTypedAPI.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/14/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveMoya

public class GmailReactiveTypedAPI {
	
	internal let moyaProivder: ReactiveCocoaMoyaProvider<Gmail>
	
	init(withClientId clientId: String, scope: String) throws {
		
		do {
			self.moyaProivder = try Gmail.provider(withClientId: clientId, scope: scope)
		}
		catch(let error){
			
			// TODO: this is a hack due to a bug in Swift. Check back if it's been fixed.
			// The bug is that a *class*, (unlike a struct) must set all of its values
			// before throwing or returning nil from a failable initializer.
			// Therefore we set our value to some useless value, then immediatly throw
			self.moyaProivder = ReactiveCocoaMoyaProvider<Gmail>()
			throw error
		}
	}
}

