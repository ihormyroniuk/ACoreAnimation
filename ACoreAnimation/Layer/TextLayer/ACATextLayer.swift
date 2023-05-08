import QuartzCore

open class ACATextLayer: CATextLayer {
    
    // MARK: Initializers
    
    public override init() {
        super.init()
        setup()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    open func setup() {
        
    }

}
