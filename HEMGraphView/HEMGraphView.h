//
//  HEMGraphView.h
//
//  Created by Marcilio Junior on 1/15/15.
//  Copyright (c) 2015 HE:mobile. All rights reserved.
//

@import UIKit;

#import "HEMGraphPlot.h"

@class HEMGraphViewConfiguration;
@interface HEMGraphView : UIView

@property (nonatomic, strong) NSArray *xAxisValues;
@property (nonatomic, strong) NSNumber *yAxisNumberOfValues;
@property (nonatomic, strong) HEMGraphViewConfiguration *configuration;

- (void)addGraphPlot:(HEMGraphPlot *)graphPlot;
- (void)draw;

@end

@interface HEMGraphViewConfiguration : NSObject

@property (nonatomic, strong) UIFont *axisLabelFont;
@property (nonatomic, strong) UIColor *axisLabelColor;
@property (nonatomic, strong) UIColor *axisLinesColor;

@end
