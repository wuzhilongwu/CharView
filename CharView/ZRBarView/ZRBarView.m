//
//  ZRBarView.m
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/19.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRBarView.h"
#import "UIView+ZRFrame.h"

@interface ZRSingleBarView ()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, assign) NSInteger totalNubmer;
@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, assign) CGFloat superViewHeight;

//所有色块的高度
@property (nonatomic, strong) NSArray *heightArr;
@property (nonatomic, strong) NSDictionary *attributes;

@end

@implementation ZRSingleBarView

- (instancetype)initWithFrame:(CGRect)frame barColors:(NSArray *)colors totalNumber:(CGFloat)totalNumber numbers:(NSArray *)numbers superViewHeight:(CGFloat)superViewHeight {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 1;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.colors = colors;
        self.totalNubmer = totalNumber;
        self.numbers = numbers;
        self.superViewHeight = superViewHeight;
        
        CGFloat height = 0.f;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0; i < self.colors.count; i++) {
            CGFloat h = (self.superViewHeight * ([self.numbers[i] floatValue] / self.totalNubmer));
            [arr addObject:@(h)];
            height += h;
        }
        self.heightArr = arr;
        self.height = height;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        self.attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],
                            NSForegroundColorAttributeName:[UIColor whiteColor],
                            NSParagraphStyleAttributeName:paragraphStyle};
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGFloat y = 0.f;
    for (int i = 0; i < self.colors.count; i++) {
        CGRect colorRect = CGRectMake(0, y, rect.size.width, [self.heightArr[i] floatValue]);
        CGContextAddRect(ref, colorRect);
        [self.colors[i] setFill];
        CGContextDrawPath(ref, kCGPathFill);
        
        if (self.showTextType == ShowTextTypeIn) {
            //数值
            NSString *str = nil;
            if (!self.barNumberIsFloatValue) {
                str = [@((NSInteger)[self.numbers[i] floatValue]) stringValue];
            } else {
                str = [NSString stringWithFormat:@"%.1f", [self.numbers[i] floatValue]];
            }
            if (colorRect.size.height > 5) {
                [str drawInRect:[self centerRectWithRect:colorRect] withAttributes:self.attributes];
            }
        }
        
        y += [self.heightArr[i] floatValue];
    }
}

//取rect的中间部分
- (CGRect)centerRectWithRect:(CGRect)rect {
    CGFloat strHeight = 14;
    return CGRectMake(rect.origin.x, (rect.size.height-strHeight)/2+rect.origin.y, rect.size.width, strHeight);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    !self.tapBlock ?: self.tapBlock();
//}

@end






@implementation ZRBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

#define ZRSingleBarViewSpace  5

- (void)setBarWithBarMessages:(NSArray *)messages showTextType:(ShowTextType)showTextType totalNumber:(CGFloat)totalNumber {
    int i = 0;
    CGFloat barWidth = AUTO_Pixel(25) - AUTO_Pixel(8) * (messages.count-1);
//    if (showTextType == ShowTextTypeIn) {
//        barWidth += AUTO_Pixel(10);
//    }
    if (messages.count == 3) {
        barWidth += 5;
    }
    
    for (NSDictionary *messageDic in messages) {
        NSArray *colors = [messageDic objectForKey:ZR_BarCharView_Colors_Key];
        NSArray *numbers = [messageDic objectForKey:ZR_BarCharView_Numbers_Key];
        
        CGFloat startX = (self.width-barWidth*messages.count-ZRSingleBarViewSpace*(messages.count-1))/2 + barWidth*i + ZRSingleBarViewSpace * i;
        ZRSingleBarView *bar = [[ZRSingleBarView alloc] initWithFrame:CGRectMake(startX, 0, barWidth, 0) barColors:colors totalNumber:totalNumber numbers:numbers superViewHeight:self.height];
        bar.showTextType = showTextType;
        bar.totalNumberIsIntegerValue = self.totalNumberIsIntegerValue;
        bar.barNumberIsFloatValue = self.barNumberIsFloatValue;
        [self addSubview:bar];
        bar.bottom = self.height;
        
//        WS(weakSelf);
//        [bar setTapBlock:^{
//            !weakSelf.indexBlock ?: weakSelf.indexBlock(i);
//        }];
        
        //
        if (numbers.count == 1 && showTextType == ShowTextTypeOn && [numbers[0] floatValue] != 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
            if (self.barNumberIsFloatValue) {
                label.text = [NSString stringWithFormat:@"%.1f", [numbers[0] floatValue]];
            } else {
                label.text = [NSString stringWithFormat:@"%zd", [numbers[0] integerValue]];
            }
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.center = bar.center;
            label.bottom = bar.top;
            [self addSubview:label];
        }
        
        i++;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    !self.indexBlock ?: self.indexBlock(0);
}

@end
