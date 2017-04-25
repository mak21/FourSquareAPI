//
//  DetailsViewController.swift
//  FourSquareAPI
//
//  Created by mahmoud khudairi on 4/25/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var reviewText = [String]()
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var selectedVenue : Venue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        if selectedVenue == nil {
            return
        }
        nameLabel.text = selectedVenue.name
        phoneLabel.text = selectedVenue.phone
        urlLabel.text = selectedVenue.url
        categoryLabel.text = selectedVenue.catName
        addressLabel.text = "\(selectedVenue.address) , \(selectedVenue.city)"
        getReviews()
    }
    func getReviews(){
        
        let urlString = "https://api.foursquare.com/v2/venues/\(selectedVenue.id)?client_id=H51QIJ1K5YEVO2G5RAIVQHHNZIV1WNH1ZWPQBF5MB3GIVSJI&client_secret=J0QLTSSSVLT1XZZHZWJOOVDUNMCFWMFJJTBEQ22JLE4JJ50J&v=20130815&ll=3.135394,101.629894&query=sushi"
        guard let url = URL(string: urlString)
            
            else{return}
        
        let session =  URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("error\(err.localizedDescription)")
                return
            }
            guard let data = data
                else {
                    print ("Data Erorr")
                    return
            }
            //print(data)
            
            do {
                if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                    
                    self.papolateReviews(dictData)
                }
                
            }catch{
                print("error when converting to JSON")
            }
        }
        task.resume()
    }

    
func papolateReviews(_ dict : [String:Any]){
    
    if let responseDict = dict["response"] as? [String : Any]{
        if let venuesDict = responseDict["venue"] as? [String:Any]{
            
           if let tipsDict = venuesDict["tips"] as? [String:Any]{
              if let groupDict = tipsDict["groups"] as? [[String:Any]]{
                for group in groupDict{
                    
             if let itemDict = group["items"] as? [[String:Any]]{
                for txt in itemDict{
                  reviewText.append(txt["text"] as! String)
                    
                }
                }
                }
            DispatchQueue.main.async {
                self.reviewTableView.reloadData()
            }
          //  }
        }
        }
        }
}
}

    @IBAction func handleURL(_ sender: Any) {
        print("hi")
        UIApplication.shared.open(URL(string: selectedVenue.url)!, options: [:], completionHandler: nil)
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
        return UITableViewCell()
    }
    cell.detailTextLabel?.text = reviewText[indexPath.row]
    return cell
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviewText.count
}

}
