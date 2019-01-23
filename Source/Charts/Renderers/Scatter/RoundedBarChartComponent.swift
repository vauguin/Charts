//
// Created by Vincent Auguin on 2019-01-23.
//

import Foundation

@objc open class RoundedBarChartComponent: NSObject {

    @objc open var threshold: Double = 0
    @objc open var radius: Double = 15
    @objc open var maxWidth: Double = 20

    @objc open var backgroundColor: CGColor = UIColor.black.cgColor
    @objc open var underThresholdColor: CGColor = UIColor.green.cgColor
    @objc open var overThresholdColor: CGColor = UIColor.red.cgColor

    @objc public init(withThreshold: Double, radii: Double) {
        super.init()

        self.threshold = withThreshold
        self.radius = radii
    }
}
