//
//  UIImageExtension.swift
//  CustomViewAnimation
//
//  Created by OODDY MAC on 2020/07/14.
//  Copyright © 2020 MIN KYUNG JUN. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resized(to aspect: CGFloat) -> UIImage {
        let w = self.size.width
        let h = self.size.height
        
        var ratio = CGFloat()
        
        // 더 큰쪽의 사이즈를 가지고 줄어든 비율 계산
        if w < h {
            ratio = aspect / h
        } else {
            ratio = aspect / w
        }
        
        // 줄어든 비율을 길이와 높이에 적용
        let aspectRatio = max(ratio, ratio)
        let newSize = CGSize(width: w * aspectRatio, height: h * aspectRatio)
        
        if #available(iOS 10, *) {
            return UIGraphicsImageRenderer(size: newSize).image { _ in
                draw(in: CGRect(origin: .zero, size: newSize))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(
                /* size: */ newSize,
                /* opaque: */ false,
                /* scale: */ self.scale
            )
            
            // defer: 함수 종료 직전에 호출하는 코드 뭉치
            defer { UIGraphicsEndImageContext() }

            self.draw(in: CGRect(origin: .zero, size: newSize))
            return UIGraphicsGetImageFromCurrentImageContext()!
        }
    }
}
