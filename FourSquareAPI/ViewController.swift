//
//  ViewController.swift
//  FourSquareAPI
//
//  Created by mahmoud khudairi on 4/25/17.
//  Copyright © 2017 mahmoud khudairi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
var venues = [Venue]()
    var cat = "all"
    var filterdVenues = [Venue]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        findVenues()
    }
    
    func findVenues(){
        
        let urlString = "https://api.foursquare.com/v2/venues/search?client_id=H51QIJ1K5YEVO2G5RAIVQHHNZIV1WNH1ZWPQBF5MB3GIVSJI&client_secret=J0QLTSSSVLT1XZZHZWJOOVDUNMCFWMFJJTBEQ22JLE4JJ50J&v=20130815&ll=3.135394,101.629894&query=\(cat)"
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
                
                    self.papolateVenues(dictData)
                }
                
            }catch{
                print("error when converting to JSON")
            }
        }
        task.resume()
    }
    func papolateVenues(_ dict : [String:Any]){
        
            if let responseDict = dict["response"] as? [String : Any]{
                   if let venuesDict = responseDict["venues"] as? [[String:Any]]{
                     for venue in venuesDict {
                        let newVenue = Venue(dict: venue)
                        
                       //
                        venues.append(newVenue)
                        
        }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

        }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return venues.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else{return UITableViewCell()}
        
        cell.textLabel?.text = venues[indexPath.row].name
        cell.detailTextLabel?.text = "\(venues[indexPath.row].address) , \(venues[indexPath.row].city)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let  detailController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            detailController.selectedVenue = venues[indexPath.row]
            navigationController?.pushViewController(detailController, animated: true)
        }
    }

}

