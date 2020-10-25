//
//  EditAddressViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/3/20.
//

import UIKit

class EditAddressViewController: UIViewController, UITextFieldDelegate {
    
    private let dataSource = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

    private let address: UITextField = {
        let address = UITextField()
        address.textColor = .black
        address.layer.borderWidth = 1
        address.layer.borderColor = UIColor.lightGray.cgColor
        address.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        address.leftViewMode = .always
        address.backgroundColor = .white
        address.tintColor = .link
        let placeholderText = NSAttributedString(string: "Enter Address", attributes: [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        address.attributedPlaceholder = placeholderText
        address.font = UIFont(name: "Louis George Cafe Bold", size: 17)!
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
        let placeholderText = NSAttributedString(string: "Enter City", attributes: [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        city.attributedPlaceholder = placeholderText
        city.font = UIFont(name: "Louis George Cafe Bold", size: 17)!
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
        let placeholderText = NSAttributedString(string: "Enter State", attributes: [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        state.attributedPlaceholder = placeholderText
        state.font = UIFont(name: "Louis George Cafe Bold", size: 17)!
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
        let placeholderText = NSAttributedString(string: "Enter Zipcode", attributes: [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        zipcode.attributedPlaceholder = placeholderText
        zipcode.font = UIFont(name: "Louis George Cafe Bold", size: 17)!
        return zipcode
    }()
    
    private let submit: UIButton = {
        let submit = UIButton()
        submit.setTitle("Submit", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        submit.layer.masksToBounds = true
        submit.titleLabel?.font = UIFont(name: "Louis George Cafe Bold", size: 22)!
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return submit
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        states.delegate = self
        state.inputView = states
        configureToolBar()
        configureNavBar()
        view.addSubview(address)
        view.addSubview(city)
        view.addSubview(state)
        view.addSubview(zipcode)
        view.addSubview(submit)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        address.frame = CGRect(x: 30, y: 120, width: view.frame.width - 60, height: 52)
        city.frame = CGRect(x: 30, y: 190, width: view.frame.width - 60, height: 52)
        state.frame = CGRect(x: 30, y: 260, width: view.frame.width - 60, height: 52)
        zipcode.frame = CGRect(x: 30, y: 330, width: view.frame.width - 60, height: 52)
        submit.frame = CGRect(x: 30, y: 400, width: view.frame.width - 60, height: 45)
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 35)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Louis George Cafe Bold", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
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
        guard let myAddress = address.text, let myCity = city.text, let myState = state.text, let myZipcode = zipcode.text else {
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
        dismiss(animated: true, completion: nil)
    }
}

extension EditAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case address:
            textField.resignFirstResponder()
            city.becomeFirstResponder()
        case city:
            textField.resignFirstResponder()
            state.becomeFirstResponder()
        case state:
            textField.resignFirstResponder()
            zipcode.becomeFirstResponder()
        case zipcode:
            textField.resignFirstResponder()
            submitTapped()
        default:
            break
        }
        return true
    }
}
