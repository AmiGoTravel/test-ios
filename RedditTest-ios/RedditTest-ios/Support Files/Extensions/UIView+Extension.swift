//
//  UIView+Extension.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

extension UIView {
   
    
    // MARK: - Layout

    func setUpContraints(pattern: String, options: NSLayoutConstraint.FormatOptions?,
                         views: UIView...) {
        var myViews: [String : UIView] = [:]
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            myViews["v\(index)"] = view
            
        }
        
        var customOptions = NSLayoutConstraint.FormatOptions()
        if options != nil {
            customOptions = options ?? NSLayoutConstraint.FormatOptions()
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: pattern, options: customOptions, metrics: nil, views: myViews))
    }
    
    func attachAll(in superview: UIView) {
        centerViewLayout(in: superview)
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0)
            .isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0)
            .isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0)
            .isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0)
            .isActive = true
        
    }
    
    func centerViewLayout(in superview: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerHorizontally(in superview: UIView, width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
            .isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func centerVertically(in superview: UIView, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
            .isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // MARK: - Appearance
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func insertLine(width: CGFloat, color: UIColor) {
        let lineView = UIView()
        lineView.backgroundColor = color
        
        self.addSubview(lineView)
        self.setUpContraints(pattern: "H:|[v0]|", options: nil, views: lineView)
        self.setUpContraints(pattern: "V:[v0(\(width))]|", options: nil,
                             views: lineView)
        
    }
    
    func setGlow(radius: CGFloat, opacity: Float, color: [UIColor]) {
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = 0.6
        var index = 0
        let duration = TimeInterval(color.count - 1)
        UIView.animate(withDuration: duration){
            self.layer.shadowOpacity += opacity
            index += 1
            self.layer.shadowColor = color[color.count - 1 - index].cgColor
            self.backgroundColor = color[index]
            
        }
        let path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowPath = path
    }
}
