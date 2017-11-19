//
//  ZRBarView.h
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/19.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AUTO_RATIO (SCREEN_WIDTH/375.0)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define AUTO_Pixel(x) (x * AUTO_RATIO)

#define ZR_BarCharView_Colors_Key @"ZR_BarCharView_Colors_Key"
#define ZR_BarCharView_Numbers_Key @"ZR_BarCharView_Numbers_Key"

typedef NS_ENUM(NSInteger, ShowTextType) {
    ShowTextTypeNone = 0,
    ShowTextTypeIn,
    ShowTextTypeOn
};

@interface ZRSingleBarView : UIView

@property (nonatomic, assign) ShowTextType showTextType;
@property (nonatomic, copy) void(^tapBlock)();

//是否要浮点显示
@property (nonatomic, assign) BOOL totalNumberIsIntegerValue;
@property (nonatomic, assign) BOOL barNumberIsFloatValue;

- (instancetype)initWithFrame:(CGRect)frame barColors:(NSArray *)colors totalNumber:(CGFloat)totalNumber numbers:(NSArray *)numbers superViewHeight:(CGFloat)superViewHeight;

@end





@interface ZRBarView : UIView

@property (nonatomic, copy) void(^indexBlock)(NSInteger index);

//是否要浮点显示
@property (nonatomic, assign) BOOL totalNumberIsIntegerValue;
@property (nonatomic, assign) BOOL barNumberIsFloatValue;

- (void)setBarWithBarMessages:(NSArray *)messages showTextType:(ShowTextType)showTextType totalNumber:(CGFloat)totalNumber;

@end
