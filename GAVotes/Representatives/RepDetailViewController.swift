//
//  RepDetailViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/2/20.
//

import UIKit
import MessageUI

class RepDetailViewController: UIViewController, MFMailComposeViewControllerDelegate, UIScrollViewDelegate {
    
    var currentOfficial: Officials?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let photo: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!
        name.textAlignment = .center
        name.textColor = .black
        name.numberOfLines = 2
        return name
    }()
    
    private let occuParty: UILabel = {
        let occuParty = UILabel()
        occuParty.font = UIFont(name: "LouisGeorgeCafe", size: 23)!
        occuParty.textAlignment = .center
        occuParty.textColor = .black
        occuParty.numberOfLines = 3
        return occuParty
    }()
    
    private let address: UILabel = {
        let address = UILabel()
        address.font = UIFont(name: "LouisGeorgeCafe", size: 17)!
        address.textColor = .black
        address.numberOfLines = 2
        return address
    }()
    
    private let phone: UILabel = {
        let phone = UILabel()
        phone.font = UIFont(name: "LouisGeorgeCafe", size: 17)!
        phone.textColor = .black
        phone.numberOfLines = 2
        return phone
    }()
    
    private let phoneButton: UIButton = {
        let phoneButton = UIButton()
        phoneButton.titleLabel?.font = UIFont(name: "LouisGeorgeCafe", size: 17)!
        phoneButton.setTitleColor(.link, for: .normal)
        phoneButton.addTarget(self, action: #selector(phoneButtonTapped), for: .touchUpInside)
        phoneButton.contentHorizontalAlignment = .left
        return phoneButton
    }()
    
    private let email: UILabel = {
        let email = UILabel()
        email.font = UIFont(name: "LouisGeorgeCafe", size: 17)!
        email.textColor = .black
        email.numberOfLines = 2
        return email
    }()
    
    private let emailButton: UIButton = {
        let emailButton = UIButton()
        emailButton.titleLabel?.font = UIFont(name: "LouisGeorgeCafe", size: 17)!
        emailButton.setTitleColor(.link, for: .normal)
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        emailButton.contentHorizontalAlignment = .left
        return emailButton
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
        configureNavBar()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        name.text = currentOfficial!.name
        occuParty.text = "\(currentOfficial!.title)\n\(currentOfficial!.party)"
        address.text = "Address: " + currentOfficial!.address
        if currentOfficial!.phone == "Not Available" {
            phone.text = "Phone: " + currentOfficial!.phone
            scrollView.addSubview(phone)
        } else {
            phoneButton.setTitle("Phone: " + currentOfficial!.phone, for: .normal)
            scrollView.addSubview(phoneButton)
        }
        if currentOfficial!.emails == "Not Available" {
            email.text = "Email: " + currentOfficial!.emails
            scrollView.addSubview(email)
        } else {
            emailButton.setTitle("Email: " + currentOfficial!.emails, for: .normal)
            scrollView.addSubview(emailButton)
        }
        photo.downloaded(from: currentOfficial!.photoURL)
        configureChannels()
        scrollView.addSubview(photo)
        scrollView.addSubview(name)
        scrollView.addSubview(occuParty)
        scrollView.addSubview(address)
        scrollView.addSubview(channels)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        photo.frame = CGRect(x: view.frame.width / 2 - (0.1 * view.frame.height), y: 30, width: 0.2 * view.frame.height, height: 0.25 * view.frame.height)
        name.frame = CGRect(x: 15, y: photo.frame.maxY + 10, width: view.frame.width - 30, height: 60)
        occuParty.frame = CGRect(x: 15, y: name.frame.maxY, width: view.frame.width - 30, height: 85)
        address.frame = CGRect(x: 15, y: occuParty.frame.maxY + 10, width: view.frame.width - 30, height: 60)
        phone.frame = CGRect(x: 15, y: address.frame.maxY, width: view.frame.width - 30, height: 40)
        phoneButton.frame = CGRect(x: 15, y: address.frame.maxY, width: view.frame.width - 30, height: 40)
        email.frame = CGRect(x: 15, y: phone.frame.maxY, width: view.frame.width - 30, height: 40)
        emailButton.frame = CGRect(x: 15, y: phone.frame.maxY, width: view.frame.width - 30, height: 40)
        channels.frame = CGRect(x: 10, y: email.frame.maxY, width: view.frame.width - 30, height: 120)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 25)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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
            case "Not Available":
                url += " Not Available"
            default:
                break
            }
        }
        let attributedString = NSMutableAttributedString(string: url)
        for (key, value) in dict {
            attributedString.addAttribute(.link, value: key, range: NSRange(location: value[0], length: value[1]))
        }
        channels.attributedText = attributedString
        channels.font = UIFont(name: "LouisGeorgeCafe", size: 17)!
    }
    
    @objc private func phoneButtonTapped() {
        let theirPhone = formatPhone(thePhone: currentOfficial!.phone)
        let url = URL(string: "tel://\(theirPhone)")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func formatPhone(thePhone: String) -> String {
        var str = ""
        for char in thePhone {
            if char.isNumber {
                str.append(char)
            }
        }
        return str
    }
    
    @objc private func emailButtonTapped() {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController(title: "Error", message: "You must have Mail app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([currentOfficial!.emails])
        present(composer, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            controller.dismiss(animated: true, completion: nil)
            return
        }
        switch result {
        case .failed:
            let alert = UIAlertController(title: "Error", message: "Email failed to send", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        case .saved:
            let alert = UIAlertController(title: "Saved", message: "Your draft was saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        case .sent:
            let alert = UIAlertController(title: "Success!", message: "Your email sent!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let data = data, error == nil, let image = UIImage(data: data) else {
                    return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {
            return
        }
        downloaded(from: url, contentMode: mode)
    }
}
