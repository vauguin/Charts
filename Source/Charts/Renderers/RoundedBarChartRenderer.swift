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
    var threshold : CGFloat = 30
    var radius: CGFloat = 15
    var backgroundColor: CGColor = UIColor(red:0.91, green:0.90, blue:0.90, alpha:1.0).cgColor
    var underThresholdColor: CGColor = UIColor(red:0.31, green:0.74, blue:0.93, alpha:1.0).cgColor
    var overThresholdColor: CGColor = UIColor(red:0.13, green:0.48, blue:0.75, alpha:1.0).cgColor
    
    var _maxWidth : CGFloat = 15.4
    
    @objc override public init(dataProvider: BarChartDataProvider, animator: Animator, viewPortHandler: ViewPortHandler)
    {
        super.init(dataProvider: dataProvider, animator: animator, viewPortHandler: viewPortHandler)
    }
    
    override open func drawBarPath(context: CGContext, bar: CGRect, data: ChartDataEntry?) {
        let width = bar.size.width > _maxWidth ? _maxWidth : bar.size.width
        
        let height = viewPortHandler.contentHeight
        let y = CGFloat(data?.y ?? 0)
        
        // Background bar
        let yOrigin = (2 * radius) / 3
        let backgroundBar = CGRect(origin: CGPoint(x: bar.origin.x, y: yOrigin), size: CGSize(width: width, height: height))
        var roundRect = UIBezierPath(roundedRect: backgroundBar, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        context.addPath(roundRect.cgPath)
        context.closePath()
        context.setFillColor(backgroundColor)
        context.fillPath()
        context.saveGState()
        
        // Over bar
        if y >= threshold {
            let fullBar = CGRect(origin: bar.origin, size: CGSize(width: width, height: bar.size.height))
            roundRect = UIBezierPath(roundedRect: fullBar, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
            context.addPath(roundRect.cgPath)
            context.closePath()
            context.setFillColor(overThresholdColor)
            context.fillPath()
            context.saveGState()
        }

        // Under bar
        var thresholdedBar = CGRect(origin: bar.origin, size: CGSize(width: width, height: bar.size.height))
        if y >= threshold {
            thresholdedBar.size.height = (threshold * thresholdedBar.size.height) / y
            // Recalculate the origin
            thresholdedBar.origin.y += bar.size.height - thresholdedBar.size.height
        }
        roundRect = UIBezierPath(roundedRect: thresholdedBar, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        context.addPath(roundRect.cgPath)
        context.closePath()
        context.setFillColor(underThresholdColor)
        context.fillPath()
        context.saveGState()
    }
}
