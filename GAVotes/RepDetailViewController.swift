//
//  RepDetailViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit

class RepDetailViewController: UIViewController {
    
    var currentOfficial: Officials?
    
    private let photo: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: 30)
        name.textAlignment = .center
        name.textColor = .black
        name.numberOfLines = 2
        return name
    }()
    
    private let occupation: UILabel = {
        let occupation = UILabel()
        occupation.font = .systemFont(ofSize: 20)
        occupation.textAlignment = .center
        occupation.textColor = .black
        occupation.numberOfLines = 2
        return occupation
    }()
    
    private let party: UILabel = {
        let party = UILabel()
        party.font = .systemFont(ofSize: 20)
        party.textAlignment = .center
        party.textColor = .black
        party.numberOfLines = 2
        return party
    }()
    
    private let address: UILabel = {
        let address = UILabel()
        address.font = .systemFont(ofSize: 15)
        address.textColor = .black
        address.numberOfLines = 2
        return address
    }()
    
    private let phone: UILabel = {
        let phone = UILabel()
        phone.font = .systemFont(ofSize: 15)
        phone.textColor = .black
        phone.numberOfLines = 2
        return phone
    }()
    
    private let email: UILabel = {
        let email = UILabel()
        email.font = .systemFont(ofSize: 15)
        email.textColor = .black
        email.numberOfLines = 2
        return email
    }()
    
    private let channels: UITextView = {
        let channels = UITextView()
        channels.textColor = UIColor.black
        channels.backgroundColor = .white
        channels.tintColor = .link
        channels.isEditable = false
        return channels
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = currentOfficial?.name
        occupation.text = currentOfficial?.title
        party.text = currentOfficial?.party
        address.text = "Address: " + currentOfficial!.address
        phone.text = "Phone: " + currentOfficial!.phone
        email.text = "Email: " + currentOfficial!.emails
        photo.downloaded(from: currentOfficial!.photoURL)
        configureChannels()
        view.addSubview(photo)
        view.addSubview(name)
        view.addSubview(occupation)
        view.addSubview(party)
        view.addSubview(address)
        view.addSubview(phone)
        view.addSubview(channels)
        view.addSubview(email)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photo.frame = CGRect(x: 30, y: 100, width: 100, height: 125)
        name.frame = CGRect(x: 30, y: 200, width: view.frame.width - 60, height: 60)
        occupation.frame = CGRect(x: 30, y: 260, width: view.frame.width - 60, height: 60)
        party.frame = CGRect(x: 30, y: 320, width: view.frame.width - 60, height: 60)
        address.frame = CGRect(x: 30, y: 380, width: view.frame.width - 60, height: 60)
        phone.frame = CGRect(x: 30, y: 440, width: view.frame.width - 60, height: 60)
        email.frame = CGRect(x: 30, y: 500, width: view.frame.width - 60, height: 60)
        channels.frame = CGRect(x: 30, y: 560, width: view.frame.width - 60, height: 180)
    }
    
    private func configureChannels() {
        var url = "Channels: |"
        var dict = [String: [Int]]()
        var start = 0
        var length = 0
        for social in currentOfficial!.channels {
            start = url.count + 1
            switch (social["type"]) {
            case "Facebook":
                let temp = "https://www.facebook.com/" + social["id"]!
                url += " Facebook |"
                length = 8
                dict[temp] = [start, length]
                break
            case "Twitter":
                let temp = "https://www.twitter.com/" + social["id"]!
                url += " Twitter |"
                length = 7
                dict[temp] = [start, length]
                break
            case "YouTube":
                let temp = "https://www.youtube.com/" + social["id"]!
                url += " YouTube |"
                length = 7
                dict[temp] = [start, length]
                break
            case "Not available":
                url += "Not available"
            default:
                break
            }
        }
        let attributedString = NSMutableAttributedString(string: url)
        for (key, value) in dict {
            attributedString.addAttribute(.link, value: key, range: NSRange(location: value[0], length: value[1]))
        }
        channels.attributedText = attributedString
        channels.font = .systemFont(ofSize: 15)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
