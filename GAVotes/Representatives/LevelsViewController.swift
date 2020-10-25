//
//  LevelsViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/4/20.
//

import UIKit

class LevelsViewController: UIViewController {
    
    private var federalData = [Officials]()
    private var stateData = [Officials]()
    private var countyData = [Officials]()
    @IBOutlet weak var federal: UIButton!
    @IBOutlet weak var state: UIButton!
    @IBOutlet weak var county: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let url = formatURL()
        getData(from: url)
        configureButtons()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let url = formatURL()
        getData(from: url)
        configureButtons()
        configureNavBar()
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(showAddress))
    }
    
    @objc private func showAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "editAddress")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func configureButtons() {
        federal.setTitle("Federal", for: .normal)
        federal.setTitleColor(.black, for: .normal)
        federal.titleLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 30)!
        federal.frame = CGRect(x: 30, y: (view.frame.height / 2) - ((view.frame.height / 6) + 100), width: view.frame.width - 60, height: view.frame.height / 6)
        federal.layer.borderWidth = 5
        federal.layer.cornerRadius = 15
        federal.layer.borderColor = UIColor(red: 93 / 255.0, green: 151 / 255.0, blue: 223 / 255.0, alpha: 1).cgColor
        federal.backgroundColor = UIColor(red: 147 / 255.0, green: 186 / 255.0, blue: 234 / 255.0, alpha: 1)
        
        state.setTitle("State", for: .normal)
        state.setTitleColor(.black, for: .normal)
        state.titleLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 30)!
        state.frame = CGRect(x: 30, y: (view.frame.height / 2) - view.frame.height / 12, width: view.frame.width - 60, height: view.frame.height / 6)
        state.layer.borderWidth = 3
        state.layer.cornerRadius = 15
        state.layer.borderColor = UIColor.lightGray.cgColor
        state.backgroundColor = .white
        
        county.setTitle("County", for: .normal)
        county.setTitleColor(.black, for: .normal)
        county.titleLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 30)!
        county.frame = CGRect(x: 30, y: (view.frame.height / 2) + 100, width: view.frame.width - 60, height: view.frame.height / 6)
        county.layer.borderWidth = 5
        county.layer.cornerRadius = 15
        county.layer.borderColor = UIColor(red: 227 / 255.0, green: 127 / 255.0, blue: 127 / 255.0, alpha: 1).cgColor
        county.backgroundColor = UIColor(red: 237 / 255.0, green: 175 / 255.0, blue: 176 / 255.0, alpha: 1)
    }
    
    private func formatURL() -> String {
        var url = "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address="
        var array = UserDefaults.standard.string(forKey: "Address")?.split(separator: " ")
        for i in 0 ..< array!.count {
            if i == 0 {
                url += array![i]
            } else {
                url += "%20\(array![i])"
            }
        }
        url += "%2C"
        array = UserDefaults.standard.string(forKey: "City")?.split(separator: " ")
        for i in 0 ..< array!.count {
            url += "%20\(array![i])"
        }
        return url + "%2C%20\(UserDefaults.standard.string(forKey: "State")!)%2C%20\(UserDefaults.standard.string(forKey: "Zipcode")!)&key=AIzaSyBK0gua620ptoniUbZc3ypO-WWR-BpkdQQ"
    }
    
    private func getData(from url: String) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [weak self] data, response, error in
            
            guard let strongSelf = self else {
                return
            }
            
            guard let data = data, error == nil else {
                let alert = UIAlertController(title: "Error", message: "Something went wrong!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
            strongSelf.federalData.removeAll()
            strongSelf.stateData.removeAll()
            strongSelf.countyData.removeAll()
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                guard let array = (json["offices"] as? [[String: Any]]) else {
                    strongSelf.federalData = []
                    strongSelf.stateData = []
                    strongSelf.countyData = []
                    return
                }
                for dict in array {
                    let title = dict["name"] as? String ?? "Not available"
                    let levels = (dict["levels"] as? [String] ?? ["Not available"])[0]
                    for indices in dict["officialIndices"] as! [Int] {
                        switch (levels) {
                        case "country":
                            strongSelf.federalData.append(Officials(json: json, index: indices, title: title))
                            break
                        case "administrativeArea1":
                            strongSelf.stateData.append(Officials(json: json, index: indices, title: title))
                            break
                        case "administrativeArea2":
                            strongSelf.countyData.append(Officials(json: json, index: indices, title: title))
                            break
                        default:
                            break
                        }
                    }
                }
            } catch let jsonErr {
                let alert = UIAlertController(title: "Error serializing json", message: jsonErr.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
        }).resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "federal" {
            let vc = segue.destination as! RepresentativesViewController
            vc.title = "Federal Level"
            vc.data = federalData
        }
        if segue.identifier == "state" {
            let vc = segue.destination as! RepresentativesViewController
            vc.title = "State Level"
            vc.data = stateData
        }
        if segue.identifier == "county" {
            let vc = segue.destination as! RepresentativesViewController
            vc.title = "County Level"
            vc.data = countyData
        }
    }
}
