//
//  ElectDetailViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    var location: [Location]?
    var count = 0
    var num = 0
    
    private let error: UILabel = {
        let error = UILabel()
        error.font = .systemFont(ofSize: 30)
        error.textAlignment = .center
        error.textColor = .black
        error.numberOfLines = 2
        return error
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePollingLocations()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func done() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configurePollingLocations() {
        if location!.count == 0 {
            error.text = "No data for locations near your address"
            error.frame = CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 120)
            view.addSubview(error)
        } else {
            for num in 0 ..< location!.count {
                self.num = num
                let thing = UIView(frame: CGRect(x: 10, y: (CGFloat(count) * 210) + 75, width: view.frame.width - 20, height: 200))
                let name = UILabel()
                name.frame = CGRect(x: 0, y: 0, width: thing.frame.width, height: 100)
                name.font = .systemFont(ofSize: 35, weight: .bold)
                name.textAlignment = .center
                name.textColor = .black
                name.numberOfLines = 2
                name.text = "\(location![num].name)"
                if location![num].latitude == -100000.00 || location![num].longitude == -100000.00 {
                    let address = UILabel()
                    address.frame = CGRect(x: 0, y: 150, width: thing.frame.width, height: 50)
                    address.font = .systemFont(ofSize: 20)
                    address.textAlignment = .center
                    address.textColor = .black
                    address.numberOfLines = 2
                    address.text = "Address: \(location![num].address)"
                    thing.addSubview(address)
                } else {
                    let address = UIButton()
                    address.frame = CGRect(x: 0, y: 150, width: thing.frame.width, height: 50)
                    address.titleLabel?.font = .systemFont(ofSize: 20)
                    address.titleLabel?.numberOfLines = 2
                    address.titleLabel?.textAlignment = .center
                    address.setTitleColor(.link, for: .normal)
                    address.setTitle("Address: \(location![num].address)", for: .normal)
                    address.addTarget(self, action: #selector(addressTapped), for: .touchUpInside)
                    thing.addSubview(address)
                }
                let times = UILabel()
                times.frame = CGRect(x: 0, y: 100, width: thing.frame.width, height: 50)
                times.font = .systemFont(ofSize: 20)
                times.textAlignment = .center
                times.textColor = .black
                times.numberOfLines = 2
                times.text = "Start date: \(location![num].start)\nEnd date: \(location![num].end)"
                thing.addSubview(name)
                thing.addSubview(times)
                view.addSubview(thing)
                count += 1
            }
        }
    }
    
    @objc private func addressTapped() {
        let latitude: CLLocationDegrees = location![num].latitude
        let longitude: CLLocationDegrees = location![num].longitude
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location![num].name
        mapItem.openInMaps(launchOptions: options)
    }
}
