//
//  dfdf.swift
//  ACoreAnimation
//
//  Created by Ihor Myroniuk on 12/11/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit

private var AssociatedObjectHandle: UInt8 = 0

public extension CALayer {

    private var animationsCompletions: NSMutableDictionary {
        get {
            guard let nsDictionary = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? NSMutableDictionary else {
                let nsDictionary = NSMutableDictionary()
                objc_setAssociatedObject(self, &AssociatedObjectHandle, nsDictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return self.animationsCompletions
            }
            return nsDictionary
        }
    }

    func addAnimation(_ animation: CAAnimation, onComplete completion: @escaping (Bool) -> Void) {
        let key = UUID().uuidString
        animation.delegate = self
        animationsCompletions.setObject(completion, forKey: key as NSString)
        self.add(animation, forKey: key)
    }

}

extension CALayer: CAAnimationDelegate {

    public func animationDidStart(_ anim: CAAnimation) {

    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let keys = animationKeys() else { return }
        for key in keys  {
            guard anim == animation(forKey: key) else { continue }
            guard let completion = animationsCompletions.object(forKey: key as NSString) as? ((Bool) -> Void) else { return }
            animationsCompletions.removeObject(forKey: key as NSString)
            removeAnimation(forKey: key)
            completion(flag)
        }
    }

}
