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
        
//        let firstView1 = UIView(frame: CGRect(origin: CGPoint(x: 10, y: 100), size: CGSize(width: 200, height: 200)))
//        firstView1.backgroundColor = .magenta
//
//        let secondView1 = UIView()
//        secondView1.frame = CGRect(origin: CGPoint(x: 10, y: 20), size: CGSize(width: 100, height: 100))
//        secondView1.backgroundColor = .cyan
//        view.addSubview(firstView1)
//        firstView1.addSubview(secondView1)
        
//        let scrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 200)))
        let scrollView = UIScrollView()
        self.view.contentview
        scrollView.frame = view.frame
        scrollView.contentSize = CGSize(width: 2000, height: 5000)
        scrollView.backgroundColor = .magenta
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.contentOffset



            }
    

}


extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("bounds.origin: \(scrollView.bounds.origin), size: \(scrollView.bounds.size)")
    }
    
}
