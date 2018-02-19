//
//  PinterestPresentAnimatinController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/15/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class PinterestPresentViewController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval
    private let isPresenting: Bool
    private let originFrame: CGRect
    private let imageUrl: String
    let interactionController: SwipeInteractionController?

    //private let SubcategoriesBackImageID = 1
    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect, imageUrl: String, interactionController: SwipeInteractionController?) {
        self.duration = duration
        self.interactionController = interactionController
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.imageUrl = imageUrl

    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            guard let fromVC = transitionContext.viewController(forKey: .from),
                let toVC = transitionContext.viewController(forKey: .to),
                let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
                else {
                    return
            }
            let containerView = transitionContext.containerView
            snapshot.frame = originFrame
            containerView.addSubview(toVC.view)
            guard let headerImageView = toVC.view.viewWithTag(Constants.ElementId.SUBCATEGORY_IMAGE_ID) as? UIImageView else { return }
            let blurView = UIView(frame: originFrame)
            blurView.alpha = 0.6
            blurView.backgroundColor = .black

            let transitionView = UIImageView(frame: originFrame)
            transitionView.contentMode = .scaleAspectFill
            transitionView.clipsToBounds = true
            transitionView.translatesAutoresizingMaskIntoConstraints = false
            let url = URL(string: imageUrl)
            transitionView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
            containerView.addSubview(transitionView)
            containerView.addSubview(blurView)
            toVC.view.alpha = 0
            UIView.animateKeyframes(
                withDuration: duration,
                delay: 0,
                options: .calculationModeCubic,
                animations: {
                    // 2
    //                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
    //                    fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
    //                }
    //
    //                // 3
    //                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
    //                    snapshot.layer.transform = AnimationHelper.yRotation(0.0)
    //                }
    //
    //                // 4
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                        transitionView.frame = headerImageView.frame
                        blurView.frame = headerImageView.frame
                        blurView.alpha = 0.6
                        toVC.view.alpha = 1

                    }
            },
                // 5
                completion: { _ in
                    blurView.removeFromSuperview()
                    transitionView.removeFromSuperview()
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        else {
            guard let fromVC = transitionContext.viewController(forKey: .from),
                let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
            }
            let snapshot = (fromVC as! CoursesBySubcategoryViewController).headerView
            let containerView = transitionContext.containerView
            containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
            let backImageTransitionView = snapshot.backImageView
            let blurView = snapshot.blurView
            containerView.addSubview(backImageTransitionView)
            containerView.addSubview(blurView)
            fromVC.view.isHidden = true
            UIView.animateKeyframes(
                withDuration: duration,
                delay: 0,
                options: .calculationModeCubic,
                animations: {
                    // 2
                    //                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    //                    fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
                    //                }
                    //
                    //                // 3
                    //                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    //                    snapshot.layer.transform = AnimationHelper.yRotation(0.0)
                    //                }
                    //
                    //                // 4
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                        blurView.frame = self.originFrame
                        backImageTransitionView.frame = self.originFrame
                        blurView.alpha = 0.6
                    }
            },
                // 5
                completion: { _ in
                    fromVC.view.isHidden = false
                    blurView.removeFromSuperview()
                    backImageTransitionView.removeFromSuperview()
                    if transitionContext.transitionWasCancelled {
                        toVC.view.removeFromSuperview()
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    
}
