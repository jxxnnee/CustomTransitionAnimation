//
//  DismissTransition.swift
//  CustomViewAnimation
//
//  Created by OODDY MAC on 2020/07/14.
//  Copyright © 2020 MIN KYUNG JUN. All rights reserved.
//

import Foundation
import UIKit

class DismissTransition:  UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            fromView.alpha = 0
        }, completion: { res in
            transitionContext.completeTransition(res)
        })
    }
    
    
    
}
