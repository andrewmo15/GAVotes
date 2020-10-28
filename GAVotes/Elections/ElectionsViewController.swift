//
//  ElectionsViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit
import UserNotifications

class ElectionsViewController: UIViewController {
    
    private var pollings: Polling?
    var elect: Election?
    private var candidate: Candidates?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!
        name.textAlignment = .center
        name.textColor = .black
        name.numberOfLines = 2
        return name
    }()
    
    private let date: UILabel = {
        let date = UILabel()
        date.font = UIFont(name: "LouisGeorgeCafe", size: 20)!
        date.textAlignment = .center
        date.textColor = .black
        date.numberOfLines = 1
        return date
    }()
    
    private let data: UILabel = {
        let data = UILabel()
        data.font = UIFont(name: "LouisGeorgeCafe", size: 20)!
        data.textAlignment = .center
        data.textColor = .black
        data.numberOfLines = 5
        return data
    }()
    
    private let error: UILabel = {
        let error = UILabel()
        error.font = UIFont(name: "LouisGeorgeCafe", size: 30)!
        error.textAlignment = .center
        error.textColor = .black
        error.numberOfLines = 10
        return error
    }()
    
    private let polling: UIButton = {
        let polling = UIButton()
        polling.setTitle("View Polling Locations", for: .normal)
        polling.setTitleColor(.white, for: .normal)
        polling.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        polling.layer.masksToBounds = true
        polling.titleLabel?.font = UIFont(name: "LouisGeorgeCafe", size: 23)!
        polling.addTarget(self, action: #selector(pollingTapped), for: .touchUpInside)
        polling.layer.masksToBounds = true
        polling.layer.cornerRadius = 10
        return polling
    }()
    
    private let candidates: UIButton = {
        let candidates = UIButton()
        candidates.setTitle("View Candidate Information", for: .normal)
        candidates.setTitleColor(.white, for: .normal)
        candidates.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        candidates.layer.masksToBounds = true
        candidates.titleLabel?.font = UIFont(name: "LouisGeorgeCafe", size: 23)!
        candidates.addTarget(self, action: #selector(candidatesTapped), for: .touchUpInside)
        candidates.layer.masksToBounds = true
        candidates.layer.cornerRadius = 10
        return candidates
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        let url = formatURL()
        getData(from: url)
        configureNavBar()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        view.addSubview(scrollView)
        let url = formatURL()
        getData(from: url)
        configureNavBar()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        name.frame = CGRect(x: 30, y: 30, width: view.frame.width - 60, height: 120)
        date.frame = CGRect(x: 30, y: name.frame.maxY + 20, width: view.frame.width - 60, height: 20)
        data.frame = CGRect(x: 30, y: date.frame.maxY + 20, width: view.frame.width - 60, height: 100)
        candidates.frame = CGRect(x: 30, y: data.frame.maxY + 100, width: view.frame.width - 60, height: 60)
        polling.frame = CGRect(x: 30, y: candidates.frame.maxY + 10, width: view.frame.width - 60, height: 60)
        error.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: view.frame.height - 200)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 35)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .done, target: self, action: #selector(notify))
        self.title = "Election"
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
        return url + "%2C%20\(UserDefaults.standard.string(forKey: "State")!)%2C%20\(UserDefaults.standard.string(forKey: "Zipcode")!)&electionId=\(elect!.id)&key=AIzaSyBK0gua620ptoniUbZc3ypO-WWR-BpkdQQ"
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
                
                strongSelf.pollings = Polling(json: json)
                strongSelf.candidate = Candidates(json: json)
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
        if pollings!.available {
            name.text = pollings!.name
            date.text = pollings!.date
            data.text = "Data is now available for your location!\n\(UserDefaults.standard.string(forKey: "FullAddress") ?? "No address provided")"
            error.removeFromSuperview()
            scrollView.addSubview(name)
            scrollView.addSubview(date)
            scrollView.addSubview(data)
            scrollView.addSubview(polling)
            scrollView.addSubview(candidates)
        } else {
            error.text = "Data is not yet available for your location: \(UserDefaults.standard.string(forKey: "FullAddress") ?? "No address provided")\nPlease come back later or try a different location"
            name.removeFromSuperview()
            date.removeFromSuperview()
            data.removeFromSuperview()
            polling.removeFromSuperview()
            candidates.removeFromSuperview()
            scrollView.addSubview(error)
        }
    }
    
    @objc private func pollingTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "polling") as! PollingViewController
        vc.polling = pollings?.pollingLocations
        vc.early = pollings?.earlyLocations
        vc.absentee = pollings?.absenteeLocations
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Polling Locations"
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true)
    }
    
    @objc private func candidatesTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "cand") as! CandidatesViewController
        vc.candidates = candidate
        let nav = UINavigationController(rootViewController: vc)
        vc.title = "Candidates"
        nav.modalPresentationStyle = .automatic
        present(nav, animated: true)
    }
    
    @objc private func notify() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { [weak self] (allow, error) in
            guard let strongSelf = self else {
                return
            }
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.debugDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    strongSelf.present(alert, animated: true)
                }
            } else if allow {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Success!", message: "You will be notified 3 days prior!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    strongSelf.present(alert, animated: true)
                }
                
                let content = UNMutableNotificationContent()
                content.title = "Vote Now!"
                content.body = "2 days until the \(strongSelf.elect!.name)"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                var date = dateFormatter.date(from: strongSelf.elect!.date)
                date?.addTimeInterval(-172800)
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
                
                center.add(request) { (error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: error.debugDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                            strongSelf.present(alert, animated: true)
                        }
                    }
                }
            }
        }
    }
}
