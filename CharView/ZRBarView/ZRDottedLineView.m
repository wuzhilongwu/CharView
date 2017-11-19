//
//  ZRDottedLineView.m
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/18.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRDottedLineView.h"
#import "UIView+ZRFrame.h"

@implementation ZRDottedLineView

- (void)drawRect:(CGRect)rect {
    
}

- (instancetype)initWithFrame:(CGRect)frame line:(NSInteger)line row:(NSInteger)row {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.line = line;
        self.row = row;
        [self setupLines];
    }
    return self;
}

- (void)setupLines {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 1=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
      [NSNumber numberWithInt:1],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint startPoint;
    CGPoint endPoint;
    for (int i = 0; i <= self.row; i++) {
        if ((i == 0 || i == self.row)) {
            continue;
        }
        
        CGFloat width = self.width/self.row;
        startPoint = CGPointMake(i*width, 0);
        endPoint = CGPointMake(i*width, self.height);
        
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    }
    for (int i = 0; i <= self.line; i++) {
        if ((i == 0 || i == self.line)) {
            continue;
        }
        
        CGFloat height = self.height/self.line;
        startPoint = CGPointMake(0, i*height);
        endPoint = CGPointMake(self.width, i*height);
        
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[self layer] addSublayer:shapeLayer];
    
//    [self setupOutsideLines];
}

- (void)setupOutsideLines {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor
//    [shapeLayer setStrokeColor:[[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f] CGColor]];
    [shapeLayer setStrokeColor:[UIColor lightGrayColor].CGColor];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 1=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
      [NSNumber numberWithInt:0],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint startPoint;
    CGPoint endPoint;
    for (int i = 0; i <= self.row; i++) {
        if (!(i == 0 || i == self.row)) {
            continue;
        }
        
        CGFloat width = self.width/self.row;
        startPoint = CGPointMake(i*width, 0);
        endPoint = CGPointMake(i*width, self.height);
        
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    }
    for (int i = 0; i <= self.line; i++) {
        if (!(i == 0 || i == self.line)) {
            continue;
        }
        CGFloat height = self.height/self.line;
        startPoint = CGPointMake(0, i*height);
        endPoint = CGPointMake(self.width, i*height);
        
        CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[self layer] addSublayer:shapeLayer];
}

@end
