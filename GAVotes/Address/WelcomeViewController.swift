//
//  ViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/1/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let dataSource = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    
    let background: UIImageView = {
        let background = UIImageView()
        background.image = UIImage(named: "background")
        return background
    }()
    
    private let welcome: UILabel = {
        let welcome = UILabel()
        welcome.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 55)!
        welcome.textAlignment = .center
        welcome.textColor = .white
        welcome.numberOfLines = 3
        welcome.text = "Welcome to GAVotes"
        return welcome
    }()
    
    private let address: UITextField = {
        let address = UITextField()
        address.textColor = .black
        address.layer.borderWidth = 1
        address.layer.borderColor = UIColor.lightGray.cgColor
        address.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        address.leftViewMode = .always
        address.backgroundColor = .white
        address.tintColor = .link
        let placeholderText = NSAttributedString(string: "Enter Address", attributes: [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        address.attributedPlaceholder = placeholderText
        address.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!
        return address
    }()
    
    private let city: UITextField = {
        let city = UITextField()
        city.textColor = .black
        city.layer.borderWidth = 1
        city.layer.borderColor = UIColor.lightGray.cgColor
        city.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        city.leftViewMode = .always
        city.backgroundColor = .white
        city.tintColor = .link
        let placeholderText = NSAttributedString(string: "Enter City", attributes: [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        city.attributedPlaceholder = placeholderText
        city.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!
        return city
    }()
    
    private let state: UITextField = {
        let state = UITextField()
        state.textColor = .black
        state.layer.borderWidth = 1
        state.layer.borderColor = UIColor.lightGray.cgColor
        state.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        state.leftViewMode = .always
        state.backgroundColor = .white
        state.tintColor = .link
        let placeholderText = NSAttributedString(string: "Enter State", attributes: [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        state.attributedPlaceholder = placeholderText
        state.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!
        return state
    }()
    
    private let states: UIPickerView = {
        let states = UIPickerView()
        return states
    }()
    
    private let zipcode: UITextField = {
        let zipcode = UITextField()
        zipcode.textColor = .black
        zipcode.layer.borderWidth = 1
        zipcode.layer.borderColor = UIColor.lightGray.cgColor
        zipcode.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        zipcode.leftViewMode = .always
        zipcode.backgroundColor = .white
        zipcode.tintColor = .link
        let placeholderText = NSAttributedString(string: "Enter Zipcode", attributes: [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        zipcode.attributedPlaceholder = placeholderText
        zipcode.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!
        return zipcode
    }()
    
    private let submit: UIButton = {
        let submit = UIButton()
        submit.setTitle("Submit", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        submit.layer.masksToBounds = true
        submit.titleLabel?.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 22)!
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return submit
    }()
    
    private let links: UITextView = {
        let links = UITextView()
        let text = "By continuing, you agree to our Terms and Conditions and Privacy Policy"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: "https://github.com/andrewmo15/GAVotes", range: NSRange(location: 32, length: 20))
        attributedString.addAttribute(.link, value: "https://github.com/andrewmo15/GAVotes", range: NSRange(location: 57, length: text.count - 57))
        links.attributedText = attributedString
        links.textColor = UIColor.white
        links.font = UIFont(name: "PerspectiveSans", size: 12)
        links.tintColor = .link
        links.isEditable = false
        links.backgroundColor = .clear
        return links
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(WelcomeViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WelcomeViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.backgroundColor = .green
        states.delegate = self
        state.inputView = states
        configureToolBar()
        configureNavBar()
        address.addTarget(self, action: #selector(WelcomeViewController.textFieldShouldReturn(_:)), for: UIControl.Event.primaryActionTriggered)
        city.addTarget(self, action: #selector(WelcomeViewController.textFieldShouldReturn(_:)), for: UIControl.Event.primaryActionTriggered)
        state.addTarget(self, action: #selector(WelcomeViewController.textFieldShouldReturn(_:)), for: UIControl.Event.primaryActionTriggered)
        zipcode.addTarget(self, action: #selector(WelcomeViewController.textFieldShouldReturn(_:)), for: UIControl.Event.primaryActionTriggered)
        view.addSubview(background)
        view.addSubview(welcome)
        view.addSubview(address)
        view.addSubview(city)
        view.addSubview(state)
        view.addSubview(zipcode)
        view.addSubview(submit)
        view.addSubview(links)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        background.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        welcome.frame = CGRect(x: 20, y: 40, width: view.frame.width - 40, height: 200)
        address.frame = CGRect(x: 30, y: view.frame.height - 440, width: view.frame.width - 60, height: 52)
        city.frame = CGRect(x: 30, y: address.frame.maxY + 15, width: view.frame.width - 60, height: 52)
        state.frame = CGRect(x: 30, y: city.frame.maxY + 15, width: view.frame.width - 60, height: 52)
        zipcode.frame = CGRect(x: 30, y: state.frame.maxY + 15, width: view.frame.width - 60, height: 52)
        submit.frame = CGRect(x: 30, y: zipcode.frame.maxY + 15, width: view.frame.width - 60, height: 50)
        links.frame = CGRect(x: 30, y: submit.frame.maxY, width: view.frame.width - 60, height: 50)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      self.view.frame.origin.y = 0
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 35)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    private func configureToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        state.inputAccessoryView = toolBar
    }
    
    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func submitTapped() {
        address.resignFirstResponder()
        city.resignFirstResponder()
        state.resignFirstResponder()
        zipcode.resignFirstResponder()
        guard let myAddress = address.text, let myCity = city.text, let myState = state.text, let myZipcode = zipcode.text, !myAddress.isEmpty, !myCity.isEmpty, !myState.isEmpty, !myZipcode.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        UserDefaults.standard.set(myAddress, forKey: "Address")
        UserDefaults.standard.set(myCity, forKey: "City")
        UserDefaults.standard.set(myState, forKey: "State")
        UserDefaults.standard.set(myZipcode, forKey: "Zipcode")
        UserDefaults.standard.set("\(myAddress) \(myCity), \(myState) \(myZipcode)", forKey: "FullAddress")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "enter")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension WelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        state.text = dataSource[row]
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) {
        if textField == address {
            city.becomeFirstResponder()
        } else if textField == city {
            state.becomeFirstResponder()
        } else if textField == state {
            zipcode.becomeFirstResponder()
        } else if textField == zipcode {
            submitTapped()
        }
    }
}
