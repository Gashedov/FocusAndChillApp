//
//  CustomSlider.swift
//  FocOn
//
//  Created by Artem Gorshkov on 28.09.21.
//

import UIKit

class CustomSlider: UISlider {
    var trackHeight: CGFloat = 3
    var thumbRadius: CGFloat = 5

    private lazy var thumbView: UIView = {
        let thumb = UIView()
        thumb.backgroundColor = thumbTintColor
        thumb.layer.borderWidth = 0.4
        thumb.layer.borderColor = UIColor.darkGray.cgColor
        return thumb
    }()

    func thumbImage(radius: CGFloat) {
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumbView.layer.cornerRadius = radius / 2

        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        let image = renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
        
        setThumbImage(image, for: .normal)
        setThumbImage(image, for: .highlighted)
    }

    func setThumbSize(_ size: CGSize) {
        let backgroundColor = thumbTintColor ?? .white
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setThumbImage(image, for: .normal)
        setThumbImage(image, for: .highlighted)
    }

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }

}
