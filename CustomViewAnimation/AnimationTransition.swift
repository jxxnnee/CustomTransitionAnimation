//
//  AnimationTransition.swift
//  CustomViewAnimation
//
//  Created by OODDY MAC on 2020/07/14.
//  Copyright © 2020 MIN KYUNG JUN. All rights reserved.
//

import Foundation
import UIKit

class AnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    var originPoint: CGPoint?
    var originFrame: CGRect?
    
    func setPoint(_ point: CGPoint?) {
        self.originPoint = point
    }
    
    func setFrame(_ frame: CGRect?) {
        self.originFrame = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // Defining animation action time
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Define Animation Effects
        
        // 다음에 띄울 뷰를 담을 컨테이너
        let containerView = transitionContext.containerView
        
        /*
         .to: 앞으로 보여질 View
         .from: 앞으로 가려질 View
         */
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        // 나타낼 View의 첫 위치 적용
        toView.frame = originFrame!
        toView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
        toView.layer.masksToBounds = true
        toView.layer.cornerRadius = 20
        toView.alpha = 0
        
        
        /*
         withDuration: 애니메이션을 완료하는데 걸리는 시간
         delay: 시작하기 전까지 걸리는 시간
         usingSpringWithDamping: 정지 상태에 도달 할 때 진동 애니메이션 감쇠 비율
         initialSpringVelocity: 애니메이션 시작 할 때 진동 애니메이션 속도
         options: 애니메이션 수행 방법을 나타내는 옵션 마스크
         */
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            // alpha를 1로 변경하여 나타나게 하고 scale을 원래대로 늘려 커지는 듯한 효과
            toView.transform = .identity
            toView.alpha = 1
            
        }, completion: { _ in
            // view의 X,Y Anchor를 화면 중앙으로 오토레이아웃을 잡아준다.
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            toView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            
            UIView.animate(withDuration: 1, animations: {
                // view 레이아웃 새로고침
                containerView.layoutIfNeeded()
            }, completion: { _ in
                // view의 top, bottom, left, right Anchor 를 화면 전체에 맞도록 오토레이아웃을 잡아준다.
                toView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
                toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
                toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
                toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
                
                UIView.animate(withDuration: 1, animations: {
                    // view 레이아웃 새로고침
                    containerView.layoutIfNeeded()
                })
            })
        })
        
        transitionContext.completeTransition(true)
    }
}
