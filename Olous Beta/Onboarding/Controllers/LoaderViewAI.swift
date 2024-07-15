//
//  LoaderViewAI.swift
//  Olous Beta
//
//  Created by Salt Technologies on 15/07/24.
//

import Foundation
import UIKit

class LoadingView: UIView {
    private let shapeLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let animationDuration: CFTimeInterval = 3 // Adjusted for a smoother animation
    private var cornerRadius: CGFloat = 20
    private let gapPercentage: CGFloat = 0.9 // 20% gap

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }
    
    
    @objc private func appDidBecomeActive() {
        startAnimating()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    

    private func setupLayer() {
        // Set up the shape layer
        gradientLayer.cornerRadius = cornerRadius
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.black.cgColor // Temporary color to see the line

        // Set up the gradient layer
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.8, y: 0.5)
        gradientLayer.colors = [
            UIColor(red: 0.35, green: 0.15, blue: 0.91, alpha: 1.0).cgColor, // #5A27E8
            UIColor(red: 0.71, green: 0.4, blue: 0.32, alpha: 1.0).cgColor // #B66652
        ]
        gradientLayer.locations = [0, 0.5, 0.5, 1]
        gradientLayer.mask = shapeLayer

        // Add the gradient layer to the view
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let rectPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        shapeLayer.path = rectPath.cgPath
        shapeLayer.frame = bounds
        gradientLayer.frame = bounds
    }

    func startAnimating() {
        let headAnimation = CABasicAnimation(keyPath: "strokeEnd")
        headAnimation.fromValue = 0
        headAnimation.toValue = 1
        headAnimation.duration = animationDuration
        headAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        headAnimation.repeatCount = .infinity

        let tailAnimation = CABasicAnimation(keyPath: "strokeStart")
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1 - gapPercentage
        tailAnimation.duration = animationDuration
        tailAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        tailAnimation.repeatCount = .infinity

        shapeLayer.add(headAnimation, forKey: "headAnimation")
        shapeLayer.add(tailAnimation, forKey: "tailAnimation")
    }

    func stopAnimating() {
        shapeLayer.removeAllAnimations()
    }
}
