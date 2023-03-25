//
//  ViewController.swift
//  CoordinatePattern
//
//  Created by Mac mini on 2023/03/25.
//

import UIKit

class FirstViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        title = "Home"
        
        view.addSubview(gateToYellowViewController)
        view.addSubview(gateToMagentaViewController)
        
                gateToYellowViewController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
                    gateToYellowViewController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    gateToYellowViewController.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    gateToYellowViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    gateToYellowViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                    
                    gateToMagentaViewController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    gateToMagentaViewController.centerYAnchor.constraint(equalTo: gateToYellowViewController.bottomAnchor, constant: 100),
                    gateToMagentaViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    gateToMagentaViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        gateToYellowViewController.addTarget(self, action: #selector(didTapBtn(_:)), for: .touchUpInside)
        gateToMagentaViewController.addTarget(self, action: #selector(didTapBtn(_:)), for: .touchUpInside)
    }
    
    @objc func didTapBtn(_ sender: UIButton) {
        if sender.tag == 2 {
            self.coordinator?.eventOccurred(with: .navToYellow)
        } else if sender.tag == 3 {
            self.coordinator?.eventOccurred(with: .navToMagenta)
        }
    }

    private let gateToYellowViewController: UIButton = {
        let button = UIButton()
        button.setTitle("To Yellow ViewController", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 2
        return button
    }()
    
    private let gateToMagentaViewController: UIButton = {
        let button = UIButton()
        button.setTitle("To Magenta ViewController", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .magenta
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 3
        return button
    }()
}
