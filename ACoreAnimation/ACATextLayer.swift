//
//  ACATextLayer.swift
//  ACoreAnimation
//
//  Created by Ihor Myroniuk on 10/28/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit

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
    
    // MARK: Layout
    
    open override func layoutSublayers() {
        super.layoutSublayers()
        layout()
    }
    
    open func layout() {
        
    }
    
}

public class ACATextLayer2: CATextLayer {
    
    public override func draw(in context: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let yDiff = (height - fontSize) / 2 - fontSize / 10
        
        context.saveGState()
        context.translateBy(x: 0, y: yDiff) // Use -yDiff when in non-flipped coordinates (like macOS's default)
        super.draw(in: context)
        context.restoreGState()
    }
    
}
