//
//  UIView+Geeko.swift
//  Onboarding
//
//  Created by Kuldeep Bhatt on 2021/09/01.
//

import UIKit

private let topSeparatorTag = 101
private let bottomSeparatorTag = 102

public extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func constrainEdges(to containerView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
}

public extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func applyDropShadowOnClearBackground(opacity: Float,
                                          offset: CGSize,
                                          radius: CGFloat,
                                          color: UIColor?) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color?.cgColor
        self.layer.masksToBounds = false
    }
}

extension UIView {
    func addTapGesture(requiredTaps: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = requiredTaps
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
}

struct ContainerViewInsets {
    var top: CGFloat = 0
    var bottom: CGFloat = 0
    var left: CGFloat = 0
    var right: CGFloat = 0
}

extension UIView {
    func constrainEdges(to containerView: UIView,
                        insets: ContainerViewInsets,
                        isRelativeToLeadingAndTrailingMargin: Bool = false,
                        isBottomConstraintLessThanOrEqual: Bool = false) {
        let margins = containerView.layoutMarginsGuide
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: insets.top).isActive = true
        
        if isBottomConstraintLessThanOrEqual {
            self.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: insets.bottom).isActive = true
        } else {
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: insets.bottom).isActive = true
        }
        
        self.leadingAnchor.constraint(equalTo: isRelativeToLeadingAndTrailingMargin ? margins.leadingAnchor : containerView.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: isRelativeToLeadingAndTrailingMargin ? margins.trailingAnchor : containerView.trailingAnchor, constant: insets.right).isActive = true
    }
}
