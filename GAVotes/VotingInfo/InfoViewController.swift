//
//  InfoViewController.swift
//  GAVotes
//
//  Created by Andrew Mo on 12/22/20.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Here's some information about how to register and how to vote."
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "LouisGeorgeCafe-Bold", size: 20)
        label.numberOfLines = 3
        label.backgroundColor = .white
        return label
    }()
    
    private let vr: UIButton = {
        let vr = CustomButton()
        vr.setTitle("Voter Registration", for: .normal)
        vr.addTarget(self, action: #selector(vrTapped), for: .touchUpInside)
        return vr
    }()
    
    private let ev: UIButton = {
        let ev = CustomButton()
        ev.setTitle("Early Voting", for: .normal)
        ev.addTarget(self, action: #selector(evTapped), for: .touchUpInside)
        return ev
    }()
    
    private let avbm: UIButton = {
        let avbm = CustomButton()
        avbm.setTitle("Absentee Voting By Mail", for: .normal)
        avbm.addTarget(self, action: #selector(avbmTapped), for: .touchUpInside)
        return avbm
    }()
    
    private let vip: UIButton = {
        let vip = CustomButton()
        vip.setTitle("Voting in Person", for: .normal)
        vip.addTarget(self, action: #selector(vipTapped), for: .touchUpInside)
        return vip
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(label)
        view.addSubview(vr)
        view.addSubview(ev)
        view.addSubview(avbm)
        view.addSubview(vip)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        vr.translatesAutoresizingMaskIntoConstraints = false
        vr.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        vr.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        vr.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        vr.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        ev.translatesAutoresizingMaskIntoConstraints = false
        ev.topAnchor.constraint(equalTo: vr.bottomAnchor, constant: 0).isActive = true
        ev.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        ev.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        ev.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        avbm.translatesAutoresizingMaskIntoConstraints = false
        avbm.topAnchor.constraint(equalTo: ev.bottomAnchor, constant: 0).isActive = true
        avbm.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        avbm.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        avbm.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        vip.translatesAutoresizingMaskIntoConstraints = false
        vip.topAnchor.constraint(equalTo: avbm.bottomAnchor, constant: 0).isActive = true
        vip.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        vip.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        vip.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func configureNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 14.0 / 255.0, green: 26.0 / 255.0, blue: 82.0 / 255.0, alpha: 1)
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "LouisGeorgeCafe-Bold", size: 40)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(showAddress))
        self.title = "Voting Info"
    }
    
    @objc private func showAddress() {
        let vc = EditAddressViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc private func vrTapped() {
        navigationController?.pushViewController(VRViewController(), animated: true)
    }
    
    @objc private func evTapped() {
        navigationController?.pushViewController(EVViewController(), animated: true)
    }
    
    @objc private func avbmTapped() {
        navigationController?.pushViewController(AVBMViewController(), animated: true)
    }
    
    @objc private func vipTapped() {
        navigationController?.pushViewController(VIPViewController(), animated: true)
    }

}
