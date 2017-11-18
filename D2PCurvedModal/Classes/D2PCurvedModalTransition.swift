//
//  D2PCurvedModalTransition.swift
//  D2PCurvedModal
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//

import UIKit

open class D2PCurvedModalTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private let duration:TimeInterval = 0.5
    public var opening:Bool = true
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if opening {
            
            guard let modalVC = transitionContext.viewController(forKey: .to) as? D2PCurvedModal else { return }
            
            modalVC.container.transform = CGAffineTransform.init(translationX: 0, y: modalVC.container.frame.height)
            
            containerView.addSubview(modalVC.view)
            
            modalVC.visualEffectView.alpha = 1.0
            modalVC.visualEffectView.effect = nil
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                
                modalVC.container.transform = .identity
                modalVC.visualEffectView.effect = UIBlurEffect(style: .dark)
                
            }, completion: { (terminated) in
                
                if transitionContext.transitionWasCancelled {
                    modalVC.view.removeFromSuperview()
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
            
        } else {
            
            guard let modalVC = transitionContext.viewController(forKey: .from) as? D2PCurvedModal else { return }
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                
                modalVC.visualEffectView.alpha = 0.0
                modalVC.container.transform = CGAffineTransform.init(translationX: 0, y: modalVC.container.frame.height)
                
            }, completion: { (terminated) in
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
            
        }
        
    }
}
