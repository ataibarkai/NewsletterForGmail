//
//  ViewController.swift
//  NewsletterForGmail
//
//  Created by Atai Barkai on 2/12/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import UIKit
import Moya
//import SwiftyGmail

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		
		if let provider = try? GmailTypedReactiveAPIProvider(
		withClientId: "789483483852-pb0psft47jr3gds92uvd809tgqrvfcmv.apps.googleusercontent.com",
		scope: "https://www.googleapis.com/auth/gmail.readonly"){
			
			provider.searchMessages(
				onUsername: "atai.barkai@gmail.com",
				withSearchTerm: SearchTerm(.From("frmsaul@gmail.com"))
				)
				.startWithNext{ next -> () in
					print(next)
				}
			
			provider.searchThreads(
				onUsername: "atai.barkai@gmail.com",
				withSearchTerm: SearchTerm(.From("sbarkai@gmail.com"))
				)
				.startWithNext{ next -> () in
					print(next)
				}
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

