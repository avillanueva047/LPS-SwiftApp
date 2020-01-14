//
//  MenuEnTransicion.swift
//  spaceMines
//
//  Created by Aula11 on 14/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class MenuEnTransicion: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentig = false
    var dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewCotroller = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewCotroller.view.bounds.width * 0.6
        let finalHeight = toViewCotroller.view.bounds.height
        
        if isPresentig {
            //Add dimming view
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            
            //Add menu view conroller to container
            containerView.addSubview(toViewCotroller.view)
            
            //Init frame off the screen
            toViewCotroller.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animate on screen
        let transform = {
            self.dimmingView.alpha = 0.5
            toViewCotroller.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        //Animate back off screen
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        //Animation of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresentig ? transform() : identity()
        }) {(_) in
            transitionContext.completeTransition(!isCancelled)
        }
        
    }
}
