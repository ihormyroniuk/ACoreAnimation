import QuartzCore

private var DidStartAnimationHandlersAssotiationKey: UInt8 = 0
private var DidStopAnimationHandlersAssotiationKey: UInt8 = 0

public extension CALayer {
    
    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStartAnimationHandler: @escaping () -> Void, didStopAnimationHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        self.add(animation, forKey: key)
        return key
    }
    
    private var didStartAnimationHandlers: NSMutableDictionary {
        get {
            guard let nsDictionary = objc_getAssociatedObject(self, &DidStartAnimationHandlersAssotiationKey) as? NSMutableDictionary else {
                let nsDictionary = NSMutableDictionary()
                objc_setAssociatedObject(self, &DidStartAnimationHandlersAssotiationKey, nsDictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return self.didStartAnimationHandlers
            }
            return nsDictionary
        }
    }
    
    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStartAnimationHandler: @escaping () -> Void) -> String {
        let key = UUID().uuidString
        animation.delegate = self
        didStartAnimationHandlers.setObject(didStartAnimationHandler, forKey: key as NSString)
        self.add(animation, forKey: key)
        return key
    }

    private var didStopAnimationHandlers: NSMutableDictionary {
        get {
            guard let nsDictionary = objc_getAssociatedObject(self, &DidStopAnimationHandlersAssotiationKey) as? NSMutableDictionary else {
                let nsDictionary = NSMutableDictionary()
                objc_setAssociatedObject(self, &DidStopAnimationHandlersAssotiationKey, nsDictionary, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return self.didStopAnimationHandlers
            }
            return nsDictionary
        }
    }

    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStopAnimationHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        animation.delegate = self
        didStopAnimationHandlers.setObject(didStopAnimationHandler, forKey: key as NSString)
        self.add(animation, forKey: key)
        return key
    }
    
    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStartAnimationHandler: @escaping () -> Void, didStopAnimationHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        animation.delegate = self
        didStartAnimationHandlers.setObject(didStartAnimationHandler, forKey: key as NSString)
        didStopAnimationHandlers.setObject(didStopAnimationHandler, forKey: key as NSString)
        self.add(animation, forKey: key)
        return key
    }

}

extension CALayer: CAAnimationDelegate {

    public func animationDidStart(_ anim: CAAnimation) {
        guard let key = animationKeys()?.first(where: { anim == animation(forKey: $0) }) else { return }
        guard let didStartAnimationHandler = didStartAnimationHandlers.object(forKey: key as NSString) as? (() -> Void) else { return }
        didStartAnimationHandlers.removeObject(forKey: key as NSString)
        didStartAnimationHandler()
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let key = animationKeys()?.first(where: { anim == animation(forKey: $0) }) else { return }
        guard let didStopAnimationHandler = didStopAnimationHandlers.object(forKey: key as NSString) as? ((Bool) -> Void) else { return }
        didStopAnimationHandlers.removeObject(forKey: key as NSString)
        didStopAnimationHandler(flag)
    }

}
