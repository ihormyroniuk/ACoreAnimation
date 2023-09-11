import QuartzCore

private var DidStartAnimationHandlersAssotiationKey: UInt8 = 0
private var DidStopAnimationHandlersAssotiationKey: UInt8 = 0

public extension CALayer {
    
    @discardableResult
    func addAnimation(_ animation: CAAnimation) -> String {
        let key = UUID().uuidString
        let animationCopy = animation.copy() as! CAAnimation
        self.add(animationCopy, forKey: key)
        return key
    }
    
    private var didStartAnimationHandlerKey: String { "\(Unmanaged.passUnretained(self).toOpaque())-didStartAnimationHandlerKey" }
    private var didStopAnimationHandlerKey: String { "\(Unmanaged.passUnretained(self).toOpaque())-didStopAnimationHandlerKey" }
    
    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStartAnimationHandler: @escaping () -> Void) -> String {
        let key = UUID().uuidString
        let animationCopy = animation.copy() as! CAAnimation
        animationCopy.delegate = self
        animationCopy.setValue(didStartAnimationHandler, forKey: didStartAnimationHandlerKey)
        self.add(animationCopy, forKey: key)
        return key
    }

    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStopAnimationHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        let animationCopy = animation.copy() as! CAAnimation
        animationCopy.delegate = self
        animationCopy.setValue(didStopAnimationHandler, forKey: didStopAnimationHandlerKey)
        self.add(animationCopy, forKey: key)
        return key
    }
    
    @discardableResult
    func addAnimation(_ animation: CAAnimation, didStartAnimationHandler: @escaping () -> Void, didStopAnimationHandler: @escaping (Bool) -> Void) -> String {
        let key = UUID().uuidString
        let animationCopy = animation.copy() as! CAAnimation
        animationCopy.delegate = self
        animationCopy.setValue(didStartAnimationHandler, forKey: didStartAnimationHandlerKey)
        animationCopy.setValue(didStopAnimationHandler, forKey: didStopAnimationHandlerKey)
        self.add(animationCopy, forKey: key)
        return key
    }

}

extension CALayer: CAAnimationDelegate {

    public func animationDidStart(_ anim: CAAnimation) {
        guard let didStartAnimationHandler = anim.value(forKey: didStartAnimationHandlerKey) as? (() -> Void) else { return }
        didStartAnimationHandler()
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let key = anim.value(forKey: "animationKey") as? String else { return }
        guard let didStopAnimationHandler = anim.value(forKey: didStopAnimationHandlerKey) as? ((Bool) -> Void) else { return }
        didStopAnimationHandler(flag)
    }

}

private class DidStartAnimationHandlerHolder: NSObject {
    
    let didStartAnimationHandler: () -> Void
    
    init(didStartAnimationHandler: @escaping () -> Void) {
        self.didStartAnimationHandler = didStartAnimationHandler
    }
    
}

class DidStopAnimationHandlerHolder: NSObject {
    
    let didStopAnimationHandler: (Bool) -> Void
    
    init(didStopAnimationHandler: @escaping (Bool) -> Void) {
        self.didStopAnimationHandler = didStopAnimationHandler
    }
    
}
