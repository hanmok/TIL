//
//  UIView+Ext.swift
//  Practice
//
//  Created by Mac mini on 2023/03/24.
//

import UIKit

// MARK: - Add border on Specific Sides

extension UIView {
    enum ViewSide {
        case top
        case left
        case bottom
        case right
    }

    func addBorders(to sides: [ViewSide], in color: UIColor, width: CGFloat) {
        sides.forEach { addBorder(to: $0, in: color, width: width) }
    }

    func addBorder(to side: ViewSide, in color: UIColor, width: CGFloat) {
        switch side {
        case .top:
            addTopBorder(in: color, width: width)
        case .left:
            addLeftBorder(in: color, width: width)
        case .bottom:
            addBottomBorder(in: color, width: width)
        case .right:
            addRightBorder(in: color, width: width)
        }
    }
    
    

    func addTopBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        addSubview(border)
    }

    func addBottomBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(border)
    }

    func addLeftBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(in color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin] // Resizing performed by expanding or shrinking a view in the direction of the left margin.
        addSubview(border)
    }
}

/*
 autoresizingMask ??
 An integer bit mask that determines how the receiver resizes itself when its superview’s bounds change.
 
 When a view’s bounds change, that view automatically resizes its subviews according to each subview’s autoresizing mask.
 You specify the value of this mask by combining the constants described in UIView.AutoresizingMask using the C bitwise OR operator.
 Combining these constants lets you specify which dimensions of the view should grow or shrink relative to the superview.
 The default value of this property is none, which indicates that the view should not be resized at all.
 
 When more than one option along the same axis is set, the default behavior is to distribute the size difference proportionally among the flexible portions.
 The larger the flexible portion, relative to the other flexible portions, the more it is likely to grow.
 For example, suppose this property includes the flexibleWidth and flexibleRightMargin constants but does not include the flexibleLeftMargin constant,
 thus indicating that the width of the view’s left margin is fixed but that the view’s width and right margin may change.
 Thus, the view appears anchored to the left side of its superview while both the view width and the gap to the right of the view increase.
 
 If the autoresizing behaviors do not offer the precise layout that you need for your views, you can use a custom container view and override its layoutSubviews() method to position your subviews more precisely.
 */
