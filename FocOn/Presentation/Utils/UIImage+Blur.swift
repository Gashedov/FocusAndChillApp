//
//  UIImage+Blur.swift
//  FocOn
//
//  Created by Artem Gorshkov on 14.09.21.
//

import UIKit

extension UIImage {

    func blurImage(radius: CGFloat = 10) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        let inputCIImage = CIImage(cgImage: cgImage)
        let context = CIContext(options: nil)

        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputCIImage, forKey: kCIInputImageKey)
        filter?.setValue(radius, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage

        if let outputImage = outputImage,
            let cgImage = context.createCGImage(outputImage, from: inputCIImage.extent) {

            return UIImage(
                cgImage: cgImage,
                scale: scale,
                orientation: imageOrientation
            )
        }
        return nil
    }
 }
