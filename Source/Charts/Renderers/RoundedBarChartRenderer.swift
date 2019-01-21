//
//  BarChartRenderer.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import CoreGraphics

#if !os(OSX)
    import UIKit
#endif

open class RoundedBarChartRenderer: BarChartRenderer
{
    var _radius: CGFloat = 15
    var _threshold : CGFloat = 100
    var _underThresholdColor: CGColor = UIColor.green.cgColor
    var _overThresholdColor: CGColor = UIColor.red.cgColor
    
    @objc override public init(dataProvider: BarChartDataProvider, animator: Animator, viewPortHandler: ViewPortHandler)
    {
        super.init(dataProvider: dataProvider, animator: animator, viewPortHandler: viewPortHandler)
    }
    
    override open func drawBarPath(context: CGContext, bar: CGRect, dataSet: IBarChartDataSet) {
        var roundRect = UIBezierPath(roundedRect: bar, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: _radius, height: _radius))
        context.addPath(roundRect.cgPath)
        context.closePath()
        context.setFillColor(_overThresholdColor)
        context.fillPath()
        context.saveGState()
        
        if let offsetView = dataProvider as? BarChartView {
            let xMax = CGFloat(offsetView.getAxis(dataSet.axisDependency)._axisMaximum)
            var thresholdedBar = CGRect(origin: bar.origin, size: bar.size)
            thresholdedBar.origin.y = xMax - _threshold
            thresholdedBar.size.height = _threshold
            roundRect = UIBezierPath(roundedRect: thresholdedBar, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: _radius, height: _radius))
            context.addPath(roundRect.cgPath)
            context.closePath()
            context.setFillColor(_underThresholdColor)
            context.fillPath()
        }
        
    }
}
