//
//  ElectionsViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit

class ElectionsViewController: UIViewController {
    
    private var elections: Elections?
    
    private let name: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 40, weight: .bold)
        name.textAlignment = .center
        name.textColor = .black
        name.numberOfLines = 2
        return name
    }()
    
    private let date: UILabel = {
        let date = UILabel()
        date.font = .systemFont(ofSize: 20)
        date.textAlignment = .center
        date.textColor = .black
        date.numberOfLines = 1
        return date
    }()
    
    private let data: UILabel = {
        let data = UILabel()
        data.font = .systemFont(ofSize: 20)
        data.textAlignment = .center
        data.textColor = .black
        data.numberOfLines = 5
        return data
    }()
    
    private let error: UILabel = {
        let error = UILabel()
        error.font = .systemFont(ofSize: 30)
        error.textAlignment = .center
        error.textColor = .black
        error.numberOfLines = 10
        return error
    }()
    
    private let polling: UIButton = {
        let polling = UIButton()
        polling.setTitle("View Polling Locations", for: .normal)
        polling.setTitleColor(.white, for: .normal)
        polling.backgroundColor = .black
        polling.layer.masksToBounds = true
        polling.titleLabel?.font = .systemFont(ofSize: 23)
        polling.addTarget(self, action: #selector(pollingTapped), for: .touchUpInside)
        return polling
    }()
    
    private let early: UIButton = {
        let early = UIButton()
        early.setTitle("View Early Voting Locations", for: .normal)
        early.setTitleColor(.white, for: .normal)
        early.backgroundColor = .black
        early.layer.masksToBounds = true
        early.titleLabel?.font = .systemFont(ofSize: 23)
        early.addTarget(self, action: #selector(earlyTapped), for: .touchUpInside)
        return early
    }()
    
    private let absentee: UIButton = {
        let absentee = UIButton()
        absentee.setTitle("View Drop-off Locations", for: .normal)
        absentee.setTitleColor(.white, for: .normal)
        absentee.backgroundColor = .black
        absentee.layer.masksToBounds = true
        absentee.titleLabel?.font = .systemFont(ofSize: 23)
        absentee.addTarget(self, action: #selector(absenteeTapped), for: .touchUpInside)
        return absentee
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = formatURL()
        getData(from: url)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showAddress))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let url = formatURL()
        getData(from: url)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(showAddress))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        name.frame = CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 120)
        date.frame = CGRect(x: 30, y: 220, width: view.frame.width - 60, height: 20)
        data.frame = CGRect(x: 30, y: 240, width: view.frame.width - 60, height: 100)
        polling.frame = CGRect(x: 30, y: view.frame.height - 340, width: view.frame.width - 60, height: 60)
        early.frame = CGRect(x: 30, y: view.frame.height - 270, width: view.frame.width - 60, height: 60)
        absentee.frame = CGRect(x: 30, y: view.frame.height - 200, width: view.frame.width - 60, height: 60)
        error.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: view.frame.height - 200)
    }
    
    @objc private func showAddress() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "editAddress")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func formatURL() -> String {
        var url = "https://civicinfo.googleapis.com/civicinfo/v2/voterinfo?address="
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
                let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    return
                }
                
                strongSelf.elections = Elections(json: json)
                DispatchQueue.main.async {
                    strongSelf.decide()
                }
            } catch let jsonErr {
                let alert = UIAlertController(title: "Error serializing json", message: jsonErr.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
            }
            
        }).resume()
    }
    
    private func decide() {
        if elections!.available {
            addViews()
        } else {
            addError()
        }
    }
    
    private func addError() {
        error.text = "Data is not yet available for your location: \(UserDefaults.standard.string(forKey: "FullAddress") ?? "No address provided")\nPlease come back later or try a different location"
        name.removeFromSuperview()
        date.removeFromSuperview()
        data.removeFromSuperview()
        polling.removeFromSuperview()
        early.removeFromSuperview()
        absentee.removeFromSuperview()
        view.addSubview(error)
    }
    
    private func addViews() {
        name.text = elections!.name
        date.text = elections!.date
        data.text = "Data is now available for your location!\n\(UserDefaults.standard.string(forKey: "FullAddress") ?? "No address provided")"
        error.removeFromSuperview()
        view.addSubview(name)
        view.addSubview(date)
        view.addSubview(data)
        view.addSubview(polling)
        view.addSubview(early)
        view.addSubview(absentee)
    }
    
    @objc private func pollingTapped() {
        let vc = LocationViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Polling Locations"
        vc.location = elections?.pollingLocations
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true)
    }
    
    @objc private func earlyTapped() {
        let vc = LocationViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Early Voting Locations"
        vc.location = elections?.earlyLocations
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true)
    }
    
    @objc private func absenteeTapped() {
        let vc = LocationViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Drop-off Locations"
        vc.location = elections?.absenteeLocations
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true)
    }
    
}
