//
//  FadeInPresentaionManager.swift
//  FocOn
//
//  Created by Artem Gorshkov on 16.09.21.
//

import UIKit

class FadeInPresentaionManager: NSObject {

}

// MARK: - UIViewControllerTransitioningDelegate
extension FadeInPresentaionManager: UIViewControllerTransitioningDelegate {
    func presentationController(
      forPresented presented: UIViewController,
      presenting: UIViewController?,
      source: UIViewController
    ) -> UIPresentationController? {
      let presentationController = FadeInPresentationController(
        presentedViewController: presented,
        presenting: presenting
      )
      return presentationController
    }

//    func animationController(
//      forPresented presented: UIViewController,
//      presenting: UIViewController,
//      source: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//      return FadeInPresentationAnimator()
//    }
//
//    func animationController(
//      forDismissed dismissed: UIViewController
//    ) -> UIViewControllerAnimatedTransitioning? {
//      return FadeInPresentationAnimator()
//    }
}
