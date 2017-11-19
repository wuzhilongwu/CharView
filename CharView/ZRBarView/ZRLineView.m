//
//  ZRLineView.m
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/20.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRLineView.h"

@implementation ZRLineView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
//        self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI, 1, 0, 0);//旋转
    }
    return self;
}

- (void)drawRect:(CGRect)rect {    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint p = CGPointFromString(self.pointArr[0]);
    CGPathMoveToPoint(path, NULL, p.x, p.y);
    for (int i = 1; i < self.pointArr.count; i++) {
        p = CGPointFromString(self.pointArr[i]);
        CGPathAddLineToPoint(path, NULL, p.x, p.y);
    }
    CGContextAddPath(ref, path);
    CFRelease(path);
    CGContextSetLineWidth(ref, 1);
    [[UIColor orangeColor] setStroke];
    CGContextStrokePath(ref);

    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],
                        NSForegroundColorAttributeName:[UIColor orangeColor],
                        NSParagraphStyleAttributeName:paragraphStyle};
    
    for (int i = 0; i < self.pointArr.count; i++) {
        [[UIColor orangeColor] setFill];
        CGPoint p = CGPointFromString(self.pointArr[i]);
        CGContextAddArc(ref, p.x, p.y, 3, 0, 2*M_PI, 1);
        CGContextDrawPath(ref, kCGPathFill);
        
        //百分比
        CGRect percentRect = CGRectMake(p.x-30, p.y-20, 60, 20);
        NSString *str = self.percentArr[i];
        [str drawInRect:percentRect withAttributes:attributes];
    }
    
    for (int i = 0; i < self.pointArr.count; i++) {
        [[UIColor whiteColor] setFill];
        CGPoint p = CGPointFromString(self.pointArr[i]);
        CGContextAddArc(ref, p.x, p.y, 2, 0, 2*M_PI, 1);
        CGContextDrawPath(ref, kCGPathFill);
    }
}

- (void)setPointArr:(NSArray *)pointArr {
    _pointArr = pointArr;
    [self setNeedsDisplay];
}

@end
