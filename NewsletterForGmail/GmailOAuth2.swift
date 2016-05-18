
//
//  GmailOAuth2.swift
//  SwiftyGmail
//
//  Created by Atai Barkai on 2/12/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import Foundation
import p2_OAuth2

/// An enum which amounts to a namespace for Gmail+OAuth2-related actions
public enum GmailOAuth2 {
	
	/// The name of the NSNotification used to communicate OAuth url redirections
	private static let k_OAuthNotificationName = "OAuthNotificationName_SomeRandomStringNextForSafety_2348hsdfkjhasdfysd7345klu341325678mhgkjhergqw"
	
	/**
	To be called when a url which is potentially due to a OAuth2-successful-authentication redirection.
	
	- parameter url: potentially the OAuth2-autherization redirection url
	*/
	public static func receivedPotentialOAuthURL(url: NSURL){
		NSNotificationCenter.defaultCenter().postNotificationName(GmailOAuth2.k_OAuthNotificationName, object: url)
	}
	
	
	/**
	Provides an OAuth2 object for authentication of the Gmail API, corresponding to the specific given data
	
	- parameter clientId:      The id of the API client. Obtained from Google Developer Console
	- parameter scope:         The string describing the permission scope for the Gmail authorization.
	- parameter redirect_uris: The url to which Gmail should redirect upon a successful authentication. Generally should send back to the App.
	
	- returns: `OAuth2CodeGrant` object which can be used by calling its `authorize()` function
	*/
	internal static func newOauth2Object(
		withClientId clientId: String,
		scope: String,
		redirect_uris: [String]) -> OAuth2CodeGrant {
			
			let oauth2 = OAuth2CodeGrant(settings: [
				"client_id": clientId,
				"client_secret": "",
				"authorize_uri": "https://accounts.google.com/o/oauth2/auth",
				"token_uri": "https://accounts.google.com/o/oauth2/token",   // code grant only!
				"scope": scope,
				"redirect_uris": redirect_uris,   // don't forget to register this scheme
				"keychain": true,     // if you DON'T want keychain integration
				//	"state": 7,
				"title": "Gmail Login"  // optional title to show in views
				] as OAuth2JSON
			)
			
			
			NSNotificationCenter.defaultCenter().addObserverForName(GmailOAuth2.k_OAuthNotificationName, object: nil, queue: nil) { (notification: NSNotification) -> Void in
				if let url = notification.object as? NSURL {
					oauth2.handleRedirectURL(url)
				}
			}
			
			return oauth2
	}
	
}