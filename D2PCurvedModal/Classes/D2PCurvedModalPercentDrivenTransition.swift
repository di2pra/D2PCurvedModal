//
//  D2PCurvedModalPercentDrivenTransition.swift
//  D2PCurvedModal
//
//  Created by Pradheep Rajendirane on 18/11/2017.
//

import UIKit

open class D2PCurvedModalPercentDrivenTransition: UIPercentDrivenInteractiveTransition {

    var modalVC: D2PCurvedModal!
    var shouldCompleteTransition = false
    public var transitionInProgress = false
    
    public func attachToViewController(viewController: D2PCurvedModal) {
        modalVC = viewController
        setupGestureRecognizer(view: viewController.view)
    }
    
    private func setupGestureRecognizer(view: UIView) {
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
        
    }
    
    @objc private func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        let velocity = gestureRecognizer.velocity(in:  gestureRecognizer.view!.superview!)
        
        switch gestureRecognizer.state {
        case .began:
            
            if velocity.y > 0 {
                shouldCompleteTransition = false
                transitionInProgress = true
                modalVC.close(animated: true, completion: nil)
            }
            
        case .changed:
            
            if transitionInProgress {
                let const = CGFloat(fminf(fmaxf(Float(translation.y / 250.0), 0.0), 1.0))
                shouldCompleteTransition = const > 0.15
                update(const)
            }
            
            
        case .cancelled, .ended:
            
            if transitionInProgress {
                transitionInProgress = false
                if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                    cancel()
                } else {
                    finish()
                }
            }
            
        default:
            print("Swift switch must be exhaustive, thus the default")
        }
    }
    
}
