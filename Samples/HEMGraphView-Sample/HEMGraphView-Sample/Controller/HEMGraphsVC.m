//
//  HEMGraphsVC.m
//  HEMGraphView-Sample
//
//  Created by Marcilio Junior on 1/23/15.
//  Copyright (c) 2015 HE:mobile. All rights reserved.
//

#import "HEMGraphsVC.h"
#import "HEMGraphView.h"

@interface HEMGraphsVC ()

@property (nonatomic, weak) IBOutlet HEMGraphView *graphView;

@end

@implementation HEMGraphsVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupGraphView];
}

#pragma mark - Graph Methods

- (void)setupGraphView
{
    NSArray *xAxisValues = @[
                             @{ @0 : @"0" },
                             @{ @1 : @"" },
                             @{ @2 : @"" },
                             @{ @3 : @"" },
                             @{ @4 : @"" },
                             @{ @5 : @"5" },
                             @{ @6 : @"" },
                             @{ @7 : @"" },
                             @{ @8 : @"" },
                             @{ @9 : @"" },
                             @{ @10 : @"10" },
                             @{ @11 : @"" },
                             @{ @12 : @"" },
                             @{ @13 : @"" },
                             @{ @14 : @"" },
                             @{ @15 : @"15" },
                             @{ @16 : @"" },
                             @{ @17 : @"" },
                             @{ @18 : @"" },
                             @{ @19 : @"" },
                             @{ @20 : @"20" }
                            ];
    
    self.graphView.xAxisValues = xAxisValues;
    self.graphView.yAxisNumberOfValues = @10;
    self.graphView.configuration.axisLinesColor = [UIColor lightGrayColor];
    
    NSArray *yAxisValues = @[
                             @{ @0 : @4 },
                             @{ @1 : @11 },
                             @{ @2 : @3 },
                             @{ @3 : @9 },
                             @{ @4 : @4 },
                             @{ @5 : @6 },
                             @{ @6 : @6 },
                             @{ @7 : @5 },
                             @{ @8 : @11 },
                             @{ @9 : @1 },
                             @{ @10 : @5 },
                             @{ @11 : @3 },
                             @{ @12 : @8 },
                             @{ @13 : @1 },
                             @{ @14 : @3 },
                             @{ @15 : @10 },
                             @{ @16 : @11 },
                             @{ @17 : @3 },
                             @{ @18 : @12 },
                             @{ @19 : @2 },
                             @{ @20 : @0 }
                            ];
    
    HEMGraphPlot *graph = [[HEMGraphPlot alloc] init];
    graph.values = yAxisValues;
    graph.configuration.lineColor = [UIColor blackColor];
    graph.configuration.lineWidth = @1;
    
    [self.graphView addGraphPlot:graph];
    [self.graphView draw];
}

@end
