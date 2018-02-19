//
//  CustomPresentAnimationController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/15/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let originFrame: CGRect
    public let CustomAnimatorTag = 99
    private let imageUrl: String
    private let isPresenting: Bool
    init(isPresenting: Bool,originFrame: CGRect, imageUrl: String) {
        self.isPresenting = isPresenting
        self.originFrame = originFrame
        self.imageUrl = imageUrl
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(UINavigationControllerHideShowBarDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            guard let fromVC = transitionContext.viewController(forKey: .from),
                let toVC = transitionContext.viewController(forKey: .to),
                let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
                else {
                    return
            }
            
            // 2
            let containerView = transitionContext.containerView
            let finalFrame = transitionContext.finalFrame(for: toVC)
            let detailView = toVC.view

            // 3
//            snapshot.frame = originFrame
//            //snapshot.layer.cornerRadius = CardViewController.cardCornerRadius
//            snapshot.layer.masksToBounds = true
//
            containerView.addSubview(toVC.view)
            
            
            guard let headerImageView = toVC.view.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
            let blurView = UIView(frame: originFrame)
            blurView.alpha = 0.5
            blurView.backgroundColor = .black
            //headerImageView.image = image
            //headerImageView.alpha = 0
            let transitionView = UIImageView(frame: originFrame)
            transitionView.contentMode = .scaleAspectFill
            transitionView.clipsToBounds = true
            let url = URL(string: imageUrl)
            transitionView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
            containerView.addSubview(transitionView)
            containerView.addSubview(blurView)
            toVC.view.alpha = 0
            //toVC.view.layoutIfNeeded()
            // 2
            //AnimationHelper.perspectiveTransform(for: containerView)
            //snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
            // 3
            let duration = TimeInterval(UINavigationControllerHideShowBarDuration)
            UIView.animate(withDuration: duration, animations: {
                transitionView.frame = headerImageView.frame
                toVC.view.frame = fromVC.view.frame
                toVC.view.alpha = 1
                blurView.frame = headerImageView.frame
                //blurView.alpha = 0.5
    //            detailView?.frame = fromVC.view.frame
    //            detailView?.alpha = 1
                //toVC.view.alpha = 1
            }) { (finished) in
                headerImageView.alpha = 1
                blurView.removeFromSuperview()
                transitionView.removeFromSuperview()
                fromVC.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
//        UIView.animateKeyframes(
//            withDuration: duration,
//            delay: 0,
//            options: .calculationModeCubic,
//            animations: {
//                //2
//                //          UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
//                //            fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
//                //          }
//
//                // 3
//                //          UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
//                //            snapshot.layer.transform = AnimationHelper.yRotation(0.0)
//                //          }
//                //
//                //4
//                UIView.addKeyframe(withRelativeStartTime: 0.0 , relativeDuration: 1) {
//                    //            toVC.view.frame = finalFrame
//                    //            toVC.view.layer.cornerRadius = 0
//                    //snapshot.frame = finalFrame
//                    //snapshot.layer.cornerRadius = 0
//                    transitionView.frame = headerImageView.frame
//                    blurView.frame = headerImageView.frame
//                    blurView.alpha = 0.5
//                }
//        },
//            // 5
//            completion: { _ in
//                toVC.view.isHidden = false
//                headerImageView.isHidden = false
//                blurView.removeFromSuperview()
//                transitionView.removeFromSuperview()
//                fromVC.view.layer.transform = CATransform3DIdentity
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
        }
        else {
            guard let fromVC = transitionContext.viewController(forKey: .from),
                let toVC = transitionContext.viewController(forKey: .to),
                let snapshot = toVC.view.snapshotView(afterScreenUpdates: false)
                else {
                    return
            }
            // 2
            let containerView = transitionContext.containerView
//            let finalFrame = transitionContext.finalFrame(for: toVC)
//            let detailView = toVC.view
           // fromVC.view.alpha = 0
            // 3
//            snapshot.frame = originFrame
//            //snapshot.layer.cornerRadius = CardViewController.cardCornerRadius
//            snapshot.layer.masksToBounds = true
            containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
            containerView.addSubview(snapshot)
            fromVC.view.isHidden = true
//            container.insertSubview(toView, belowSubview: fromView)
//            containerView.addSubview(toVC.view)
            
           // guard let headerImageView = toVC.view.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
//            let blurView = UIView(frame: originFrame)
//            blurView.alpha = 0.5
//            blurView.backgroundColor = .black
            //let url = URL(string: imageUrl)
//            headerImageView.alpha = 0
//            headerImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
//            let transitionView = UIImageView(frame: headerImageView.frame)
//            transitionView.contentMode = .scaleAspectFill
//            transitionView.clipsToBounds = true
//            transitionView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
//            containerView.addSubview(transitionView)
//            //containerView.addSubview(blurView)
//            //toVC.view.frame = CGRect(x: fromVC.view.frame.width, y: 0, width: toVC.view.frame.width, height: toVC.view.frame.height)
//            toVC.view.alpha = 0
            //toVC.view.layoutIfNeeded()
            // 2
            //AnimationHelper.perspectiveTransform(for: containerView)
            //snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
            // 3
            let duration = TimeInterval(UINavigationControllerHideShowBarDuration)
            UIView.animate(withDuration: duration, animations: {
                snapshot.frame = self.originFrame
                //transitionView.frame = self.originFrame
                //toVC.view.frame = fromVC.view.frame
                //toVC.view.alpha = 1
                //blurView.frame = headerImageView.frame
                //blurView.alpha = 0.5
                //            detailView?.frame = fromVC.view.frame
                //            detailView?.alpha = 1
                //toVC.view.alpha = 1
            }) { (finished) in
                toVC.view.isHidden = false
                fromVC.view.isHidden = false
                snapshot.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                //fromVC.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
        
}

