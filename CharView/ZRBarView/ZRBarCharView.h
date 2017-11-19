//
//  ZRBarCharView.h
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/18.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRDottedLineView.h"
#import "ZRBarCharView.h"
#import "ZRBarView.h"
#import "ZRLineView.h"

#define AUTO_RATIO (SCREEN_WIDTH/375.0)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define AUTO_Pixel(x) (x * AUTO_RATIO)


@interface ZRBarCharView : UIView

//子站点
@property (nonatomic, assign) BOOL haveSubInfo;

//不为0
@property (nonatomic, assign) CGFloat leftTotalNumber;
//百分比
@property (nonatomic, assign) CGFloat rightTotalNumber;
@property (nonatomic, assign) BOOL rightStringIsNumber;

@property (nonatomic, copy) NSString *unitString;

//总数是否要浮点显示
@property (nonatomic, assign) BOOL leftTotalNumberIsIntegerValue;
@property (nonatomic, assign) BOOL rightTotalNumberIsIntegerValue;
@property (nonatomic, assign) BOOL barNumberIsFloatValue;
@property (nonatomic, strong) NSArray *bottomStringArr;;

@property (nonatomic, copy) void(^tapBarBlock)(NSInteger group, NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame line:(NSInteger)line row:(NSInteger)row;
- (void)setBarWithBarMessages:(NSArray *)messages showTextType:(ShowTextType)showTextType;
- (void)setLineViewWithPointDatas:(NSArray *)datas;

@end
