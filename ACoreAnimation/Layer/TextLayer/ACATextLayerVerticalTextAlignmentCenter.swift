import QuartzCore

public class ACATextLayerVerticalTextAlignmentCenter: ACATextLayer {

    open override func draw(in context: CGContext) {
        let height = self.bounds.size.height
        let fontSize = self.fontSize
        let y = (height - fontSize) / 2 - fontSize / 10
        context.saveGState()
        context.translateBy(x: 0, y: y)
        super.draw(in: context)
        context.restoreGState()
    }

}
