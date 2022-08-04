//
//  UIView + Shadow.swift
//  Eda
//
//  Created by Roman Efimov on 26.07.2022.
//
import UIKit

extension UIView {
    
    
    func dropShadow() {
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowRadius = 7.0
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
    
    
    
    func animateColor(toColor: UIColor, duration: Double) {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.fromValue = layer.backgroundColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "backgroundColor")
        layer.borderColor = toColor.cgColor
    }
}
