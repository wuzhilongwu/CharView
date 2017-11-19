//
//  ZRBarCharViewCell.m
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/21.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRBarCharViewCell.h"

//#define ZRArcColor  ZRColorRGBA(arc4random()%255, arc4random()%255, arc4random()%255, 1)

@interface ZRBarCharViewCell ()

@property (nonatomic, strong) ZRBarCharView *charView;

@end


@implementation ZRBarCharViewCell


- (void)initSubViews {
    
}

- (void)setCharView:(ZRBarCharView *)charView withBarData:(ZRHomeAllData *)data {
    charView.barNumberIsFloatValue = data.barNumberIsFloatValue;
    charView.leftTotalNumberIsIntegerValue = data.leftTotalNumberIsIntegerValue;
    charView.leftTotalNumber = data.leftTotalNumber;
    charView.rightStringIsNumber = data.rightStringIsNumber;
    charView.rightTotalNumber = data.righrTotalNumber;
    charView.bottomStringArr = data.bottomTitleArr;
    [charView setLineViewWithPointDatas:data.pointArr];
    [charView setBarWithBarMessages:data.datas showTextType:data.showTextType];
}

- (void)setBarData:(ZRHomeAllData *)barData {
    _barData = barData;
        
    [self setCharView:_charView withBarData:barData];
}

- (void)initBarCharViewWithBarMessages:(ZRHomeAllData *)barData {
    _charView = [self creatBarCharViewWithBarMessages:barData];
    [self.contentView addSubview:_charView];
}

- (ZRBarCharView *)creatBarCharViewWithBarMessages:(ZRHomeAllData *)barData {
    CGFloat moreRightWidth = 0;
    if (barData.righrTotalNumber == 0) {
        moreRightWidth = AUTO_Pixel(25);
    }
    
    ZRBarCharView *charView = [[ZRBarCharView alloc] initWithFrame:CGRectMake(10, 60, SCREEN_WIDTH-20+moreRightWidth, [[self class] rowHeight]-80) line:4 row:barData.datas.count];
    
    return charView;
}

+ (CGFloat)rowHeight {
    return 240;
}

@end
