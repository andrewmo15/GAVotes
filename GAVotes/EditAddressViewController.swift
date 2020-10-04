//
//  EditAddressViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 10/3/20.
//

import UIKit

class EditAddressViewController: UIViewController {

    private let address: UITextField = {
        let address = UITextField()
        address.textColor = .black
        address.layer.borderWidth = 1
        address.layer.borderColor = UIColor.lightGray.cgColor
        address.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        address.leftViewMode = .always
        address.backgroundColor = .white
        address.tintColor = .link
        address.placeholder = "Enter Address"
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
        city.placeholder = "Enter City"
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
        state.placeholder = "Enter State"
        return state
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
        zipcode.placeholder = "Enter Zip Code"
        return zipcode
    }()
    
    private let submit: UIButton = {
        let submit = UIButton()
        submit.setTitle("Submit", for: .normal)
        submit.setTitleColor(.white, for: .normal)
        submit.backgroundColor = .black
        submit.layer.masksToBounds = true
        submit.titleLabel?.font = .systemFont(ofSize: 23)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return submit
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(address)
        view.addSubview(city)
        view.addSubview(state)
        view.addSubview(zipcode)
        view.addSubview(submit)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        address.frame = CGRect(x: 30, y: 120, width: view.frame.width - 60, height: 52)
        city.frame = CGRect(x: 30, y: 190, width: view.frame.width - 60, height: 52)
        state.frame = CGRect(x: 30, y: 260, width: view.frame.width - 60, height: 45)
        zipcode.frame = CGRect(x: 30, y: 330, width: view.frame.width - 60, height: 50)
        submit.frame = CGRect(x: 30, y: 400, width: view.frame.width - 60, height: 40)
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
        dismiss(animated: true, completion: nil)
    }
}
