//
//  ViewController.swift
//  Practice
//
//  Created by Mac mini on 2023/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let firstView = UIView()
//        view.addSubview(firstView)
//        firstView.frame.origin = .zero
//        firstView.frame.size = CGSize(width: 300, height: 300)
//        firstView.backgroundColor = .magenta
//        firstView.autoresizingMask = [.flexibleLeftMargin]
//
//        UIView.animate(withDuration: 3.0, delay: 2.0) {
//            firstView.bounds.size = CGSize(width: 200, height: 200)
//        }
        
        let superView = UIView(frame: CGRect(origin: CGPoint(x: 100, y: 300),
                                        size: CGSize(width: 200, height: 200)))
        superView.backgroundColor = .green
        view.addSubview(superView)
        
        let subview = UIView(frame: CGRect(origin: CGPoint(x: 100, y: 100),
                                           size: CGSize(width: 100, height: 100)))
        subview.backgroundColor = .systemBlue
        superView.addSubview(subview)
        
//        subview.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
//        subview.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
//        subview.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
        
//        subview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
//        subview.autoresizingMask = [.flexibleBottomMargin]
        
        subview.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]

        UIView.animate(withDuration: 2.5) {
            superView.bounds.size = CGSize(width: 300, height: 300)
        }
        
        
    }
}
