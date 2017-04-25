//
//  searchViewController.swift
//  FourSquareAPI
//
//  Created by mahmoud khudairi on 4/25/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit

class searchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    @IBAction func searchButtonPressed(_ sender: Any) {
        if let  viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController{
            guard let text = searchTextField.text?.lowercased() else {
                return
            }
            viewController.cat = text
            navigationController?.pushViewController(viewController, animated: true)
        }
    }


}
