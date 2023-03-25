//
//  SecondViewController.swift
//  CoordinatePattern
//
//  Created by Mac mini on 2023/03/25.
//

import UIKit

class SecondViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = coordinator?.provider.color ?? .white
        title = coordinator?.provider.title ?? "Some Title"
    }
}
