//
//  Coordinator.swift
//  CoordinatePattern
//
//  Created by Mac mini on 2023/03/25.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? {get set } // root controller for our app
    var children: [Coordinator]? { get set }
    var provider: Provider { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

enum Event {
    case navToYellow
    case navToMagenta
}
