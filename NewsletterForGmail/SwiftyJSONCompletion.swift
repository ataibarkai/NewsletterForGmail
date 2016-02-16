//
//  SwiftyJSONProtocols.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/15/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
An object that may be `init`'ed by decoding a `SwiftyJSON.JSON` object.
*/
public protocol SwiftyJSONDecodable {
	init?(withJSON json:SwiftyJSON.JSON)
}

/**
An object that may be encoded into a `SwiftyJSON.JSON` object.
*/
public protocol SwiftyJSONEncodable {
	func encodeToJSON() -> SwiftyJSON.JSON
}