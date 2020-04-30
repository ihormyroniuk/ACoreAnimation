//
//  dfdf.swift
//  ACoreAnimation
//
//  Created by Ihor Myroniuk on 12/11/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import QuartzCore

private var DidBeginAnimationHandlersAssotiationKey: UInt8 = 0

public extension CALayer {

    private var didBeginAnimationHandlers: NSMutableDictionary {
        get {
            guard let nsDictionary = objc_getAssociatedObject(self, &DidBeginAnimationHandlersAssotiationKey) as? NSMutableDictionary else {
                let nsDictionary = NSMutableDictionary()
                objc_setAssociatedObject(self, &DidBeginAnimationHandlersAssotiationKey, nsDictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return self.didBeginAnimationHandlers
            }
            return nsDictionary
        }
    }

    func addAnimation(_ animation: CAAnimation, didBeginAnimationHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        animation.delegate = self
        didBeginAnimationHandlers.setObject(didBeginAnimationHandler, forKey: key as NSString)
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
            guard let completion = didBeginAnimationHandlers.object(forKey: key as NSString) as? ((Bool) -> Void) else { return }
            didBeginAnimationHandlers.removeObject(forKey: key as NSString)
            removeAnimation(forKey: key)
            completion(flag)
        }
    }

}
