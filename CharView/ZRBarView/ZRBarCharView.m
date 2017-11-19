//
//  ZRBarCharView.m
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/18.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRBarCharView.h"
#import "ZRBarView.h"
#import "UIView+ZRFrame.h"

@interface ZRBarCharView () <UIScrollViewDelegate>

@property (nonatomic, strong) ZRDottedLineView *dottedLineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *leftTextArr;
@property (nonatomic, strong) NSArray *rightTextArr;
@property (nonatomic, strong) NSArray *bottomTextArr;
@property (nonatomic, strong) NSArray *barViewArr;

@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger row;

@property (nonatomic, strong) ZRLineView *lineView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *labelScrollView;

@end

static CGFloat kLabelWidth = 40;

@implementation ZRBarCharView

- (instancetype)initWithFrame:(CGRect)frame line:(NSInteger)line row:(NSInteger)row
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _leftTotalNumberIsIntegerValue = YES;
        _line = line;
        _row = row;
        
        [self addSubview:self.scrollView];
        [self addSubview:self.labelScrollView];
        [self setupScrollViewBgView];
        [self setupDottedLineView];
        [self addSubview:self.titleLabel];
        [self setupLeftLabels];
        [self setupRightLabels];
        [self setupBottomLabels];
        [self setupBarView];
        
        CGRect rect = _scrollView.frame;
        rect.size.height -= _scrollViewMoreHeight;
        rect.size.height += 1.5;
        rect.origin.y += _scrollViewMoreHeight;
        rect.origin.y -= 1;
        UIView *bgView = [[UIView alloc] initWithFrame:rect];
        bgView.layer.borderWidth = 0.8f;
        bgView.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0f].CGColor;
        [self addSubview:bgView];
        [self insertSubview:bgView belowSubview:self.scrollView];
    }
    return self;
}

static CGFloat _scrollViewMoreHeight = 30.f;

#pragma mark ------Views-----
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kLabelWidth+5, 30-_scrollViewMoreHeight, self.width-(kLabelWidth+5)*2, self.height-60+_scrollViewMoreHeight)];
        _scrollView.contentSize = CGSizeMake(_scrollView.width/4*self.row, _scrollView.height);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.clipsToBounds = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIScrollView *)labelScrollView {
    if (!_labelScrollView) {
        _labelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kLabelWidth+5, self.scrollView.bottom, self.width-(kLabelWidth+5)*2, 30)];
        _labelScrollView.contentSize = CGSizeMake(_scrollView.width/4*self.row, _labelScrollView.height);
        _labelScrollView.backgroundColor = [UIColor clearColor];
        _labelScrollView.showsHorizontalScrollIndicator = NO;
        _labelScrollView.userInteractionEnabled = NO;
    }
    return _labelScrollView;
}

- (void)setupScrollViewBgView {
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.top, 100, _scrollView.height+5)];
    bgView1.right = _scrollView.left-.5f;
    bgView1.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView1];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(_scrollView.right+1, _scrollView.top, kLabelWidth+100, _scrollView.height+5)];
    bgView2.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView2];
}

- (void)setupDottedLineView {
    CGFloat width = self.scrollView.contentSize.width > self.scrollView.width ? self.scrollView.contentSize.width : self.scrollView.width;
    self.dottedLineView = [[ZRDottedLineView alloc] initWithFrame:CGRectMake(0, _scrollViewMoreHeight, width, self.scrollView.height-_scrollViewMoreHeight) line:_line row:_row];
    [self.scrollView addSubview:self.dottedLineView];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, 30)];
        _titleLabel.text = @"Unit:KWh";
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (void)setupLeftLabels {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    CGFloat tempY = 0;
    for (int i = 0; i <= self.line; i++) {
        tempY = i * (self.scrollView.height-_scrollViewMoreHeight)/self.line - 10;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-7, tempY+self.scrollView.top+_scrollViewMoreHeight,  kLabelWidth+7, 20)];
//        label.text = @"10000";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:11];
        [self addSubview:label];
        
        [arr addObject:label];
    }
    self.leftTextArr = arr.copy;
}

- (void)setupRightLabels {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    CGFloat tempY = 0;
    
    for (int i = 0; i <= self.line; i++) {
        tempY = i * (self.scrollView.height-_scrollViewMoreHeight)/self.line - 10;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.right+5, tempY+self.scrollView.top+_scrollViewMoreHeight, kLabelWidth+7, 20)];
//        label.text = @"100%";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:11];
        [self addSubview:label];
        
        [arr addObject:label];
    }
    self.rightTextArr = arr.copy;
}

- (void)setupBottomLabels {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    CGFloat tempX = 0;
    CGFloat width = MAX(self.scrollView.contentSize.width, self.scrollView.width);
    for (int i = 0; i < self.row; i++) {
        tempX = i * width/self.row;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tempX, 5, width/self.row, 20)];
        label.text = @"FuTian";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:AUTO_Pixel(11)];
        label.backgroundColor = [UIColor clearColor];
        [self.labelScrollView addSubview:label];
        
        [arr addObject:label];
    }
    self.bottomTextArr = arr.copy;
}

- (void)setupBarView {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    CGFloat tempX = 0;
    for (int i = 0; i < self.row; i++) {
        tempX = i * self.dottedLineView.width/self.row + self.dottedLineView.left;
        ZRBarView *view = [[ZRBarView alloc] initWithFrame:CGRectMake(tempX, self.dottedLineView.top, self.dottedLineView.width/self.row, self.dottedLineView.height)];
        [self.scrollView addSubview:view];
        
        [view setIndexBlock:^(NSInteger index) {

        }];
        
        [arr addObject:view];
    }
    self.barViewArr = arr.copy;
}

- (ZRLineView *)lineView {
    if (!_lineView) {
        CGRect rect = self.dottedLineView.frame;
        rect.size.height += 40;
        rect.origin.y -= 20;
        _lineView = [[ZRLineView alloc] initWithFrame:rect];
        [self.scrollView addSubview:self.lineView];
    }
    return _lineView;
}

#pragma mark ------Views----- end
- (void)setBarWithBarMessages:(NSArray *)messages showTextType:(ShowTextType)showTextType {
    for (int i = 0; i < messages.count; i++) {
        NSArray *arr = messages[i];
        ZRBarView *barView = self.barViewArr[i];
        for (UIView *view in barView.subviews) {
            [view removeFromSuperview];
        }
        barView.totalNumberIsIntegerValue = self.leftTotalNumberIsIntegerValue;
        barView.barNumberIsFloatValue = self.barNumberIsFloatValue;
        [barView setBarWithBarMessages:arr showTextType:showTextType totalNumber:self.leftTotalNumber];
    }
}

- (void)setUnitString:(NSString *)unitString {
    _unitString = unitString;
    self.titleLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Kpi_Unit", nil), unitString];
}

- (void)setBottomStringArr:(NSArray *)bottomStringArr {
    _bottomStringArr = bottomStringArr;
    for (int i = 0; i < _bottomTextArr.count; i++) {
        UILabel *label = _bottomTextArr[i];
        label.text = bottomStringArr[i];
    }
}

- (void)setLeftTotalNumber:(CGFloat)leftTotalNumber {
    _leftTotalNumber = leftTotalNumber;
    for (int i = 0; i < _leftTextArr.count; i++) {
        UILabel *label = _leftTextArr[i];
        NSString *str = nil;
        if (self.leftTotalNumberIsIntegerValue) {
            str = [NSString stringWithFormat:@"%.0f", leftTotalNumber/_line*(_line-i)];
        } else {
            str = [NSString stringWithFormat:@"%.1f", leftTotalNumber/_line*(_line-i)];
        }
        label.text = str;
    }
}

- (void)setRightTotalNumber:(CGFloat)rightTotalNumber {
    _rightTotalNumber = rightTotalNumber;
    
    if (_rightTotalNumber == 0) {
        for (int i = 0; i < _rightTextArr.count; i++) {
            UILabel *label = _rightTextArr[i];
            label.text = @"";
        }
    } else {
        for (int i = 0; i < _rightTextArr.count; i++) {
            UILabel *label = _rightTextArr[i];
            if (self.rightStringIsNumber) {
                label.text = [NSString stringWithFormat:@"%.0f", _rightTotalNumber/_line*(_line-i)];
            } else {
                label.text = [NSString stringWithFormat:@"%.0f%%", _rightTotalNumber/_line*(_line-i)];
            }
        }
    }
}

- (void)setLineViewWithPointDatas:(NSArray *)datas {
    if (datas.count < 1) {
        return;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:datas.count];
    NSMutableArray *percentArr = [NSMutableArray arrayWithCapacity:datas.count];
    int i = 0;
    for (NSNumber *num in datas) {
        CGFloat x = i*self.lineView.width/self.row+self.lineView.width/self.row/2;
        CGFloat y = num.floatValue/self.rightTotalNumber*(self.lineView.height-40)+20;
        [arr addObject:NSStringFromCGPoint(CGPointMake(x, self.lineView.height-y))];
        
        if (self.rightStringIsNumber) {
            //右边显示的数字
            [percentArr addObject:[NSString stringWithFormat:@"%.0f", num.floatValue]];
        } else {
            //右边显示的百分比
            if (self.rightTotalNumber==100) {
                [percentArr addObject:[NSString stringWithFormat:@"%.1f%%", num.floatValue/self.rightTotalNumber*100]];
            }else{
            
                [percentArr addObject:[NSString stringWithFormat:@"%.1f%%", num.floatValue]];
            }
            
        }
        
        i++;
    }
    self.lineView.percentArr = percentArr;
    self.lineView.pointArr = arr;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *hitView = [super hitTest:point withEvent:event];
//    NSLog(@"hitView %@", NSStringFromClass([hitView class]));
    
    BOOL isExist = NO;
//    ZRSingleBarView *singleBarView;
    ZRBarView *tBarView = nil;
    for (ZRBarView *barView in self.barViewArr) {
//        for (ZRSingleBarView *bar in barView.subviews) {
//            CGPoint btnP = [self convertPoint:point toView:bar];
//            // 判断点在不在bar上
//            if ([bar pointInside:btnP withEvent:event]) {
//                singleBarView = bar;
//                isExist = YES;
//                break;
//            }
//        }
        
        CGPoint btnP = [self convertPoint:point toView:barView];
        // 判断点在不在bar上
        if ([barView pointInside:btnP withEvent:event]) {
            tBarView = barView;
            isExist = YES;
            break;
        }
    }
    
    if (isExist) {
        return tBarView;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.labelScrollView.contentOffset = scrollView.contentOffset;
}

@end
