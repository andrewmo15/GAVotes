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
    private var numLines = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        numLines = (location?.hours.split(separator: "\n").count ?? 0) + 1
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell.fill"), style: .done, target: self, action: #selector(alert))
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
    
    private func createNotification(time: String) {
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
                    let alert = UIAlertController(title: "Success!", message: "You will be notified on \(time)!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    strongSelf.present(alert, animated: true)
                }
                let content = UNMutableNotificationContent()
                content.title = "Vote now!"
                content.body = "This is a reminder to go vote at \(strongSelf.location!.name)!"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
                let date = dateFormatter.date(from: time)
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date!)
                
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
    
    @objc private func alert() {
        let alert = UIAlertController(title: "Reminder Schedule", message: "When would you like to be reminded?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "MM/DD/YYYY"
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "HH:MM"
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "AM or PM"
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if !self.checkDate(str: alert.textFields![0].text!) {
                let error = UIAlertController(title: "Try again!", message: "Date field not formatted correctly.", preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                    self.alert()
                }))
                self.present(error, animated: true, completion: nil)
            } else if !self.checkTime(str: alert.textFields![1].text!) {
                let error = UIAlertController(title: "Try again!", message: "Time field not formatted correctly.", preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                    self.alert()
                }))
                self.present(error, animated: true, completion: nil)
            } else if alert.textFields![2].text?.uppercased() != "AM" && alert.textFields![2].text?.uppercased() != "PM" {
                let error = UIAlertController(title: "Try again!", message: "AM/PM field not formatted correctly.", preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (_) in
                    self.alert()
                }))
                self.present(error, animated: true, completion: nil)
            } else {
                var temp = ""
                let date = alert.textFields?[0].text!.split(separator: "/")
                let time = alert.textFields?[1].text!.split(separator: ":")
                let m = alert.textFields?[2].text!.uppercased()
                
                if Int(date![0])! < 10 {
                    temp += "0" + String(Int(date![0])!)
                } else {
                    temp += date![0]
                }
                temp += "-"
                if Int(date![1])! < 10 {
                    temp += "0" + String(Int(date![1])!)
                } else {
                    temp += date![1]
                }
                temp += "-"
                if Int(date![2])! < 31 {
                    temp += "20" + String(Int(date![2])!)
                } else {
                    temp += date![2]
                }
                
                temp += " "
                
                if time![0] == "12" && m == "AM" {
                    temp += "00:" + time![1]
                } else if time![0] != "12" && m == "PM" {
                    temp += String(Int(time![0])! + 12) + ":" + time![1]
                } else if Int(time![0])! < 10 {
                    temp += "0" + String(Int(time![0])!) + ":" + time![1]
                } else {
                    temp += (alert.textFields?[1].text!)!
                }
                self.createNotification(time: temp)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func checkTime(str: String) -> Bool {
        if str.count != 5 && str.count != 4 {
            print("1")
            return false
        }
        if !str.contains(":") || (str[1] != ":" && str[2] != ":") {
            print("2")
            return false
        }
        let temp = str.split(separator: ":")
        if Int(temp[0]) == nil || Int(temp[1]) == nil {
            print("3")
            return false
        } else if Int(temp[0])! > 12 || Int(temp[0])! < 1 {
            print("4")
            return false
        } else if Int(temp[1])! > 59 || Int(temp[1])! < 1 {
            print("5")
            return false
        } else {
            return true
        }
    }
    
    private func checkDate(str: String) -> Bool {
        let temp = str.split(separator: "/")
        if temp.count != 3 {
            return false
        }
        if temp[0].count > 2 || temp[1].count > 2 || (temp[2].count != 2 && temp[2].count != 4) {
            return false
        }
        if Int(temp[0]) == nil || Int(temp[1]) == nil || Int(temp[2]) == nil {
            return false
        } else if Int(temp[0])! > 12 || Int(temp[0])! < 1 {
            return false
        } else if Int(temp[1])! > 31 || Int(temp[1])! < 1 {
            return false
        } else if (Int(temp[2])! < 2019 && Int(temp[2])! > 2030) || (Int(temp[2])! < 20 && Int(temp[2])! > 30) {
            return false
        } else {
            return true
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
            cell.textLabel?.textColor = .link
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
            return 25 * CGFloat(numLines)
        case 3:
            return 50
        case 4:
            return 50
        case 5:
            if location?.notes == "" {
                return 0
            }
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
