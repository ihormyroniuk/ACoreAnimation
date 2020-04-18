//
//  dfdf.swift
//  ACoreAnimation
//
//  Created by Ihor Myroniuk on 12/11/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import QuartzCore

private var AssociatedObjectHandle: UInt8 = 0

public extension CALayer {

    private var animationsCompletionHandlers: NSMutableDictionary {
        get {
            guard let nsDictionary = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? NSMutableDictionary else {
                let nsDictionary = NSMutableDictionary()
                objc_setAssociatedObject(self, &AssociatedObjectHandle, nsDictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return self.animationsCompletionHandlers
            }
            return nsDictionary
        }
    }

    func addAnimation(_ animation: CAAnimation, completionHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        animation.delegate = self
        animationsCompletionHandlers.setObject(completionHandler, forKey: key as NSString)
        self.add(animation, forKey: key)
        return key
    }

}

extension CALayer: CAAnimationDelegate {

    public func animationDidStart(_ anim: CAAnimation) {

    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let keys = animationKeys() else { return }
        for key in keys  {
            guard anim == animation(forKey: key) else { continue }
            guard let completion = animationsCompletionHandlers.object(forKey: key as NSString) as? ((Bool) -> Void) else { return }
            animationsCompletionHandlers.removeObject(forKey: key as NSString)
            removeAnimation(forKey: key)
            completion(flag)
        }
    }

}
