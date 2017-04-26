//
//  WebViewController.swift
//  FourSquareAPI
//
//  Created by mahmoud khudairi on 4/26/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
var currentURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL (string: currentURL)
        let requestObj = URLRequest(url: url!)
        webView.loadRequest(requestObj);
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

  
    


}
