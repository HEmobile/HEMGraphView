//
//  HEMGraphPlot.h
//
//  Created by Marcilio Junior on 1/15/15.
//  Copyright (c) 2015 HE:mobile. All rights reserved.
//

@import Foundation;
@import CoreGraphics;

@class HEMGraphPlotConfiguration;
@interface HEMGraphPlot : NSObject

@property (nonatomic, strong) NSArray *values;
@property (nonatomic) CGPoint *xPoints;
@property (nonatomic, strong) HEMGraphPlotConfiguration *configuration;

@end

@interface HEMGraphPlotConfiguration : NSObject

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) NSNumber *lineWidth;

@end
