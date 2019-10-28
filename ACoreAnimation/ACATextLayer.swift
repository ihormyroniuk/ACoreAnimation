//
//  ACATextLayer.swift
//  ACoreAnimation
//
//  Created by Ihor Myroniuk on 10/28/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit

public class ACATextLayer : CATextLayer {
    
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
