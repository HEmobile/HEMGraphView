//
//  HEMGraphView.m
//
//  Created by Marcilio Junior on 1/15/15.
//  Copyright (c) 2015 HE:mobile. All rights reserved.
//

#import "HEMGraphView.h"

static NSUInteger const HEMGraphViewBottomMargin    = 30;
static NSUInteger const HEMGraphViewSideMargin      = 20;

@interface HEMGraphView()

@property (nonatomic, strong) NSMutableArray *graphPlots;
@property (nonatomic) float leftMargin;

@end

@implementation HEMGraphView

- (instancetype)init
{
    self = [super init];

    if (self) {
        [self setupInitialValues];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self setupInitialValues];
    }

    return self;
}

- (void)awakeFromNib
{
    [self setupInitialValues];
}

#pragma mark - Private Methods

- (void)setupInitialValues
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.graphPlots = [NSMutableArray array];
    
    self.configuration = [[HEMGraphViewConfiguration alloc] init];
    self.configuration.axisLabelFont = [UIFont systemFontOfSize:11];
    self.configuration.axisLabelColor = [UIColor blackColor];
    self.configuration.axisLinesColor = [UIColor lightGrayColor];
}

- (void)drawYAxisForGraphPlot:(HEMGraphPlot *)graphPlot
{
    double maxValue = [self maxValueOfAllGraphPlots];
    double intervalValue = maxValue / self.yAxisNumberOfValues.integerValue;
    double pixelInterval = (CGRectGetHeight(self.bounds) - HEMGraphViewBottomMargin) / (self.yAxisNumberOfValues.integerValue + 1);
    
    NSMutableArray *labels = [NSMutableArray array];
    float maxWidth = 0;
        
    for (NSInteger i= self.yAxisNumberOfValues.integerValue + 1; i >= 0; i--) {
        CGPoint currentLinePoint = CGPointMake(self.leftMargin, i * pixelInterval);
        CGRect lableFrame = CGRectMake(0, currentLinePoint.y - (pixelInterval / 2), 100, pixelInterval);
        
        if (i != 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:lableFrame];
            label.backgroundColor = [UIColor clearColor];
            label.font = self.configuration.axisLabelFont;
            label.textColor = self.configuration.axisLabelColor;
            label.textAlignment = NSTextAlignmentCenter;

            float value = (intervalValue * ((self.yAxisNumberOfValues.integerValue + 1) - i));
            label.text = [NSString stringWithFormat:@"%.0f", value];
            
            [label sizeToFit];
            CGRect newLabelFrame = CGRectMake(0.0f, currentLinePoint.y - (CGRectGetHeight(label.layer.frame) / 2), CGRectGetWidth(label.frame), CGRectGetHeight(label.layer.frame));
            label.frame = newLabelFrame;
            
            if (newLabelFrame.size.width > maxWidth) {
                maxWidth = newLabelFrame.size.width;
            }
            
            [labels addObject:label];
            [self addSubview:label];
        }
    }
    
    self.leftMargin = maxWidth + HEMGraphViewSideMargin;
    
    for (UILabel *label in labels) {
        CGSize newSize = CGSizeMake(self.leftMargin, CGRectGetHeight(label.frame));
        CGRect newFrame = label.frame;
        newFrame.size = newSize;
        label.frame = newFrame;
    }
}

- (void)drawXAxisForGraphPlot:(HEMGraphPlot *)graphPlot
{
    double pixelInterval = [self graphWidth] / self.xAxisValues.count;
    graphPlot.xPoints = calloc(sizeof(CGPoint), self.xAxisValues.count);
    
    for (NSUInteger i = 0; i < self.xAxisValues.count; i++) {
        CGPoint currentLabelPoint = CGPointMake((pixelInterval * i) + self.leftMargin, CGRectGetHeight(self.bounds) - 30);
        CGRect labelFrame = CGRectMake(currentLabelPoint.x, currentLabelPoint.y, pixelInterval, 30);
        
        graphPlot.xPoints[i] = CGPointMake(CGRectGetMinX(labelFrame) + (CGRectGetWidth(labelFrame) /2), 0);
        
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.configuration.axisLabelFont;
        label.textColor = self.configuration.axisLabelColor;
        label.textAlignment = NSTextAlignmentCenter;        
        
        NSDictionary *dict = self.xAxisValues[i];
        label.text = [NSString stringWithFormat:@"%@", dict.allValues.firstObject];

        // TODO: Need to make some changes here. Sometimes the label isn't centered to axis point.
//        [label sizeToFit];
//        CGRect newLabelFrame = CGRectMake(currentLabelPoint.x, currentLabelPoint.y, CGRectGetWidth(label.frame), 30);
//        label.frame = newLabelFrame;
        
        [self addSubview:label];
    }
}

- (void)drawLinesForGraphPlot:(HEMGraphPlot *)graphPlot
{
    CAShapeLayer *axisLineLayer = [CAShapeLayer layer];
    axisLineLayer.frame = self.bounds;
    axisLineLayer.fillColor = [UIColor clearColor].CGColor;
    axisLineLayer.backgroundColor = [UIColor clearColor].CGColor;
    axisLineLayer.strokeColor = self.configuration.axisLinesColor.CGColor;
    axisLineLayer.lineWidth = 1;
    
    CGMutablePathRef axisLinePath = CGPathCreateMutable();
    double pixelsInterval = (CGRectGetHeight(self.bounds) - HEMGraphViewBottomMargin) / (self.yAxisNumberOfValues.integerValue + 1);
    CGPoint currentLinePoint = CGPointMake(self.leftMargin, ((self.yAxisNumberOfValues.integerValue + 1) * pixelsInterval));
    
    CGPathMoveToPoint(axisLinePath, NULL, currentLinePoint.x, currentLinePoint.y);
    CGPathAddLineToPoint(axisLinePath, NULL, currentLinePoint.x, currentLinePoint.y - CGRectGetHeight(self.bounds) + 40);
    
    CGPathMoveToPoint(axisLinePath, NULL, currentLinePoint.x, currentLinePoint.y);
    CGPathAddLineToPoint(axisLinePath, NULL, currentLinePoint.x + [self graphWidth], currentLinePoint.y);
    
    // draw lines to mark the points on x-axis
    for (NSUInteger i = 0; i < graphPlot.values.count; i++) {
        CGPoint point = graphPlot.xPoints[i];
        CGPathMoveToPoint(axisLinePath, NULL, point.x, currentLinePoint.y);
        CGPathAddLineToPoint(axisLinePath, NULL, point.x, currentLinePoint.y - 2.5);
    }
    
    // draw lines to mark the points on y-axis
    for (NSInteger i = self.yAxisNumberOfValues.integerValue; i > 0; i--) {
        CGPoint point = CGPointMake(self.leftMargin, i * pixelsInterval);
        CGPathMoveToPoint(axisLinePath, NULL, point.x, point.y);
        CGPathAddLineToPoint(axisLinePath, NULL, point.x + 2.5, point.y);
    }
    
    axisLineLayer.path = axisLinePath;
    [self.layer addSublayer:axisLineLayer];
}

- (void)drawValuesForGraphPlot:(HEMGraphPlot *)graphPlot
{
    CAShapeLayer *graphLayer = [CAShapeLayer layer];
    graphLayer.frame = self.bounds;
    graphLayer.fillColor = [UIColor clearColor].CGColor;
    graphLayer.backgroundColor = [UIColor clearColor].CGColor;
    graphLayer.strokeColor = graphPlot.configuration.lineColor.CGColor;
    graphLayer.lineWidth = graphPlot.configuration.lineWidth.intValue;
    
    CGMutablePathRef graphPath = CGPathCreateMutable();
    
    double yIntervalValue = [self maxValueOfAllGraphPlots] / self.yAxisNumberOfValues.integerValue;
    
    [graphPlot.values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dict = (NSDictionary *)obj;
        
        NSNumber *key = dict.allKeys.firstObject;
        NSNumber *value = dict[key];
        
        NSUInteger xIndex = [self indexForValue:key forPlot:graphPlot];
        
        double height = CGRectGetHeight(self.bounds) - HEMGraphViewBottomMargin;
        double y = height - ((height / ([self maxValueOfAllGraphPlots] + yIntervalValue)) * [value doubleValue]);
        (graphPlot.xPoints[xIndex]).x = ceil((graphPlot.xPoints[xIndex]).x);
        (graphPlot.xPoints[xIndex]).y = ceil(y);
    }];
    
    CGPathMoveToPoint(graphPath, NULL, graphPlot.xPoints[0].x, graphPlot.xPoints[0].y);
    for (NSUInteger i = 0; i < graphPlot.values.count; i++) {
        CGPoint point = graphPlot.xPoints[i];
        CGPathAddLineToPoint(graphPath, NULL, point.x, point.y);
    }
    
    graphLayer.path = graphPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1;
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    [graphLayer addAnimation:animation forKey:@"strokeEnd"];
    
    graphLayer.zPosition = 0;
    
    [self.layer addSublayer:graphLayer];
}

- (void)drawGraphPlot:(HEMGraphPlot *)graphPlot
{
    [self drawYAxisForGraphPlot:graphPlot];
    [self drawXAxisForGraphPlot:graphPlot];
    [self drawLinesForGraphPlot:graphPlot];
    [self drawValuesForGraphPlot:graphPlot];
}

#pragma mark - Helpers

- (double)maxValueOfAllGraphPlots
{
    NSMutableArray *allValues = [NSMutableArray array];
    for (HEMGraphPlot *graphPlot in self.graphPlots) {
        for (NSDictionary *dict in graphPlot.values) {
            [allValues addObject:dict.allValues.firstObject];
        }
    }
    
    NSNumber *max = [allValues valueForKeyPath:@"@max.intValue"];
    
    return [max doubleValue];
}

- (NSUInteger)indexForValue:(NSNumber *)value forPlot:(HEMGraphPlot *)graphPlot
{
    for (NSUInteger i = 0; i < self.xAxisValues.count; i++) {
        NSDictionary *dict = self.xAxisValues[i];
        
        __block BOOL foundValue = NO;
        [dict enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
            foundValue = [key isEqualToNumber:value];
            *stop = foundValue;
        }];
        
        if (foundValue) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (CGFloat)graphWidth
{
    return CGRectGetWidth(self.bounds) - self.leftMargin;
}

#pragma mark - Public Methods

- (void)addGraphPlot:(HEMGraphPlot *)graphPlot
{
    NSAssert(graphPlot != nil, @"Graph Plot should not be nil");
    NSAssert(graphPlot.values.count > 0, @"Graph Plot should have at lease one value");
    NSAssert(graphPlot.values.count <= self.xAxisValues.count, @"Graph Plot should not have more values than specified in xAxisValues property");
    
    [self.graphPlots addObject:graphPlot];
}

- (void)draw
{
    NSAssert(self.graphPlots.count > 0, @"This graph should have values to draw");
    
    for (HEMGraphPlot *graph in self.graphPlots) {
        [self drawGraphPlot:graph];
    }
}

@end

#pragma mark -

@implementation HEMGraphViewConfiguration

@end
