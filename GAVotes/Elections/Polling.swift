//
//  Elections.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/4/20.
//

import Foundation

class Polling {
    
    let available: Bool
    let name: String
    let date: String
    let pollingLocations: [Location]
    let earlyLocations: [Location]
    let absenteeLocations: [Location]
    
    init (json: [String: Any]) {
        let dict = json["election"] as? [String: String] ?? ["data": "Not Available"]
        if dict["data"] == "Not Available" {
            self.available = false
            self.name = "Not Available"
            self.date = "Not Available"
            self.pollingLocations = [Location]()
            self.earlyLocations = [Location]()
            self.absenteeLocations = [Location]()
        } else {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
            self.available = true
            self.name = dict["name"] ?? "Not Available"
            let tempDate = dict["electionDay"] ?? "Not Available"
            if let date = dateFormatterGet.date(from: tempDate) {
                self.date = dateFormatterPrint.string(from: date)
            } else {
                self.date = "Not Available"
            }
            if let array = json["pollingLocations"] as? [[String: Any]] {
                var temp = [Location]()
                for i in 0 ..< array.count {
                    let dict = array[i]["address"] as! [String: String]
                    let myAddress = "\(dict["line1"]!) \(dict["city"]!) \(dict["state"]!) \(dict["zip"]!)"
                    let myHours = array[i]["pollingHours"] as? String ?? "Not Available"
                    let tempStart = array[i]["startDate"] as? String ?? "Not Available"
                    var startDate = ""
                    if let date = dateFormatterGet.date(from: tempStart) {
                        startDate = dateFormatterPrint.string(from: date)
                    } else {
                        startDate = "Not Available"
                    }
                    let tempEnd = array[i]["endDate"] as? String ?? "Not Available"
                    var endDate = ""
                    if let date = dateFormatterGet.date(from: tempEnd) {
                        endDate = dateFormatterPrint.string(from: date)
                    } else {
                        endDate = "Not Available"
                    }
                    let myName = dict["locationName"] ?? "Not Available"
                    let myLongitude = array[i]["longitude"] as? Double ?? -100000.00
                    let myLatitude = array[i]["latitude"] as? Double ?? -100000.00
                    let myNotes = array[i]["notes"] as? String ?? ""
                    let thing = Location(name: myName, address: myAddress, hours: myHours, start: startDate, end: endDate, longitude: myLongitude, latitude: myLatitude, notes: myNotes)
                    temp.append(thing)
                }
                self.pollingLocations = temp
            } else {
                self.pollingLocations = [Location]()
            }
        
            if let array = json["dropOffLocations"] as? [[String: Any]] {
                var temp2 = [Location]()
                for i in 0 ..< array.count {
                    let dict = array[i]["address"] as! [String: String]
                    let myAddress = "\(dict["line1"]!) \(dict["city"]!) \(dict["state"]!) \(dict["zip"]!)"
                    let myHours = array[i]["pollingHours"] as? String ?? "Not Available"
                    let tempStart = array[i]["startDate"] as? String ?? "Not Available"
                    var startDate = ""
                    if let date = dateFormatterGet.date(from: tempStart) {
                        startDate = dateFormatterPrint.string(from: date)
                    } else {
                        startDate = "Not Available"
                    }
                    let tempEnd = array[i]["endDate"] as? String ?? "Not Available"
                    var endDate = ""
                    if let date = dateFormatterGet.date(from: tempEnd) {
                        endDate = dateFormatterPrint.string(from: date)
                    } else {
                        endDate = "Not Available"
                    }
                    let myName = dict["locationName"] ?? "Not Available"
                    let myLongitude = array[i]["longitude"] as? Double ?? -100000.00
                    let myLatitude = array[i]["latitude"] as? Double ?? -100000.00
                    let myNotes = array[i]["notes"] as? String ?? ""
                    let thing = Location(name: myName, address: myAddress, hours: myHours, start: startDate, end: endDate, longitude: myLongitude, latitude: myLatitude, notes: myNotes)
                    temp2.append(thing)
                }
                self.absenteeLocations = temp2
            } else {
                self.absenteeLocations = [Location]()
            }
            if let array = json["earlyVoteSites"] as? [[String: Any]] {
                var temp3 = [Location]()
                for i in 0 ..< array.count {
                    let dict = array[i]["address"] as! [String: String]
                    let myAddress = "\(dict["line1"]!) \(dict["city"]!) \(dict["state"]!) \(dict["zip"]!)"
                    let myHours = array[i]["pollingHours"] as? String ?? "Not Available"
                    let tempStart = array[i]["startDate"] as? String ?? "Not Available"
                    var startDate = ""
                    if let date = dateFormatterGet.date(from: tempStart) {
                        startDate = dateFormatterPrint.string(from: date)
                    } else {
                        startDate = "Not Available"
                    }
                    let tempEnd = array[i]["endDate"] as? String ?? "Not Available"
                    var endDate = ""
                    if let date = dateFormatterGet.date(from: tempEnd) {
                        endDate = dateFormatterPrint.string(from: date)
                    } else {
                        endDate = "Not Available"
                    }
                    let myName = dict["locationName"] ?? "Not Available"
                    let myLongitude = array[i]["longitude"] as? Double ?? -100000.00
                    let myLatitude = array[i]["latitude"] as? Double ?? -100000.00
                    let myNotes = array[i]["notes"] as? String ?? ""
                    let thing = Location(name: myName, address: myAddress, hours: myHours, start: startDate, end: endDate, longitude: myLongitude, latitude: myLatitude, notes: myNotes)
                    temp3.append(thing)
                }
                self.earlyLocations = temp3
            } else {
                self.earlyLocations = [Location]()
            }
        }
    }
}
