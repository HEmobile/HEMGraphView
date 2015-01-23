//
//  HEMGraphPlot.m
//
//  Created by Marcilio Junior on 1/15/15.
//  Copyright (c) 2015 HE:mobile. All rights reserved.
//

@import UIKit;

#import "HEMGraphPlot.h"

@implementation HEMGraphPlot

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setupInitialValues];
    }
    
    return self;
}

#pragma mark - Helpers

- (void)setupInitialValues
{
    self.configuration = [[HEMGraphPlotConfiguration alloc] init];
    self.configuration.lineColor = [UIColor blackColor];
    self.configuration.lineWidth = @1;
}

@end

#pragma mark -

@implementation HEMGraphPlotConfiguration

@end
