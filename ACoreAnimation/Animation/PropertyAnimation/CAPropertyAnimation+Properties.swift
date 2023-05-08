import QuartzCore

/*
 https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html#//apple_ref/doc/uid/TP40004514-CH11-SW2
 https://stackoverflow.com/questions/44230796/what-is-the-full-keypath-list-for-cabasicanimation
*/
public extension CAPropertyAnimation {
    static let backgroundColor = "backgroundColor"
    static let bounds = "bounds"
    static let position = "position"
    static let foregroundColor = "foregroundColor"
    static let fontSize = "fontSize"
    static let font = "font"
    static let contents = "contents"
    static let transformRotation = "transform.rotation"
}
