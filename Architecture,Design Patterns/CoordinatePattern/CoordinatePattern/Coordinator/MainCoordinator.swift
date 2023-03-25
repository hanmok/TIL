//
//  MainCoordinator.swift
//  CoordinatePattern
//
//  Created by Mac mini on 2023/03/25.
//

import UIKit

class MainCoordinator: Coordinator {
    var children: [Coordinator]? = nil
    
    var provider = Provider()
    
    var navigationController: UINavigationController? //rootVC
    
    func eventOccurred(with type: Event) {
        switch type {
            case .navToYellow:
                provider.color = .yellow
                provider.title = "Yellow ViewController"
                let vc = SecondViewController()
                
                vc.coordinator = self
                navigationController?.pushViewController(vc, animated: true)
                
            case .navToMagenta:
                provider.color = .magenta
                provider.title = "Magenta ViewController"
                let vc = SecondViewController()
                vc.coordinator = self
                navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        let vc = FirstViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
