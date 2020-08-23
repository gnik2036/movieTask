//
//  UIView+Extension.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

typealias NSLayoutConstraintX = NSLayoutConstraint
typealias NSLayoutConstraintY = NSLayoutConstraint

extension UIView {
    func fillSuperview() {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor)
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: insets.top))
        }
        
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: insets.left))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom))
        }
        
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -insets.right))
        }
        
        NSLayoutConstraint.activate(anchors)
        
        return anchors
    }
    
    @discardableResult
    func anchor(height: CGFloat? = nil, width: CGFloat? = nil) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let width = width {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        
        if let height = height {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        NSLayoutConstraint.activate(anchors)
        
        return anchors
    }
    
    @discardableResult
    func anchorCenterXToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerXAnchor = superview?.centerXAnchor {
            let anchor = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: constant)
            anchor.isActive = true
            return anchor
        }
        
        return nil
    }
    
    @discardableResult
    func anchorCenterYToSuperview(constant: CGFloat = 0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerYAnchor = superview?.centerYAnchor {
            let anchor = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: constant)
            anchor.isActive = true
            return anchor
        }
        
        return nil
    }
    
    @discardableResult
    func anchorCenterSuperview() -> (NSLayoutConstraintX?, NSLayoutConstraintY?) {
        let centerXAnchor = anchorCenterXToSuperview()
        let centerYAnchor = anchorCenterYToSuperview()
        
        return (centerXAnchor, centerYAnchor)
    }
}
