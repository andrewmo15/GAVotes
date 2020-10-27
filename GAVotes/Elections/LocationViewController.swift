//
//  ElectDetailViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    var location: Location?
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        configureNavBar()
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
        if location!.end != "Not Available" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .done, target: self, action: #selector(notify))
        }
        self.title = "Location"
    }
    
    @objc private func addressTapped() {
        let latitude: CLLocationDegrees = location!.latitude
        let longitude: CLLocationDegrees = location!.longitude
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location!.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func formatName(name: String) -> String {
        let array = name.split(separator: " ")
        var str = ""
        for word in array {
            str += word.prefix(1) + String(word.suffix(word.count - 1)).lowercased() + " "
        }
        return String(str.prefix(str.count - 1))
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
                content.title = "\(strongSelf.location!.name) closes tomorrow!"
                content.body = "Go out and cast your vote now!"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, yyyy"
                var date = dateFormatter.date(from: strongSelf.location!.end)
                date?.addTimeInterval(-86400)
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

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place", for: indexPath)
        cell.textLabel?.font = UIFont(name: "LouisGeorgeCafe", size: 20)!
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = formatName(name: location!.name)
            cell.textLabel?.numberOfLines = 2
            cell.selectionStyle = .none
        case 1:
            cell.textLabel?.text = location?.address
            cell.textLabel?.numberOfLines = 2
            cell.selectionStyle = .default
        case 2:
            cell.textLabel?.text = location?.hours
            cell.textLabel?.numberOfLines = 20
            cell.selectionStyle = .none
        case 3:
            cell.textLabel?.text = location?.start
            cell.selectionStyle = .none
        case 4:
            cell.textLabel?.text = location?.end
            cell.selectionStyle = .none
        case 5:
            cell.textLabel?.text = location?.notes
            cell.textLabel?.numberOfLines = 20
            cell.selectionStyle = .none
        default:
            break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Name"
        case 1:
            return "Address"
        case 2:
            return "Hours"
        case 3:
            return "Start Date"
        case 4:
            return "End Date"
        case 5:
            return "Notes"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if location?.latitude != -100000 && location?.longitude != -100000 {
                addressTapped()
            } else {
                let alert = UIAlertController(title: "Sorry", message: "The location does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        case 1:
            return 70
        case 2:
            return 150
        case 3:
            return 50
        case 4:
            return 50
        case 5:
            return 100
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 15)!
        header.textLabel?.textColor = .systemPink
    }
    
}
