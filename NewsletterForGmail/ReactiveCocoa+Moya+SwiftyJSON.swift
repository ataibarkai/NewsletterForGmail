//
//  ReactiveMoya+SwiftyJSON.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/15/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Moya
import SwiftyJSON

// TODO:
// This could (and should) be an extension on Signal rather than on SignalProducer.
// Then `lift` could be used to apply this function to both `Signal` and to `SignalProducer`.
// However we are using ReactiveMoya's `mapJSON()` function,
// which is unfortunately defined only on `SignalProducer`.
// The mistake is infectious.
// We should fix this as a pull request on ReactiveMoya.
extension SignalProducerType where Value == Moya.Response, Error == Moya.Error{
	
	/// Maps a Moya `Response` to a SwiftyJSON `JSON`
	func mapSwiftyJSON() -> SignalProducer<SwiftyJSON.JSON, Error> {
		return self.mapJSON().map{ SwiftyJSON.JSON($0) }
	}
}


// TODO:
// Fix the same SignalProducer infection as described above.
extension SignalProducerType where Value == SwiftyJSON.JSON {
	
	/// Maps data received from the signal into an object which implements the SwiftyJSONDecodable protocol.
	/// If the conversion fails, the value returned is nil.
	public func mapObject<T: SwiftyJSONDecodable>(type: T.Type) -> SignalProducer<T?, Error> {
		return producer.map { T(withJSON: $0) }
	}
	
	/// Maps data received from the signal into an object which implements the SwiftyJSONDecodable protocol.
	/// If the conversion fails, the signal errors.
	public func mapObject<T: SwiftyJSONDecodable>(
		toType type: T.Type,
		errorIfNil: Error) -> SignalProducer<T, Error> {
			return producer
				.mapObject(type)
				.flatMap(FlattenStrategy.Concat) {
					($0 != nil) ? SignalProducer(value: $0!) : SignalProducer(error: errorIfNil)
			}
	}
	
	/// Maps data received from the signal into an array of objects which implement the SwiftyJSONDecodable protocol.
	public func mapArray<T: SwiftyJSONDecodable>(type: T.Type) -> SignalProducer<[T], Error> {
		return producer.map { (arrayJson: SwiftyJSON.JSON) -> [T] in
			return arrayJson.arrayValue
				.map{ T(withJSON:  $0) } // Map to T
				.filter({ $0 != nil }) // Filter out failed objects
				.map({ $0! }) // Cast to non optionals array
		}
	}
	
}
