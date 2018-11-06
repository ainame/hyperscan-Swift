struct Debug {
    
    @inline(__always)
    static func run<T>(_ handler: @autoclosure ()->T) {
        #if DEBUG
        _ = handler()
        #endif
    }
}
