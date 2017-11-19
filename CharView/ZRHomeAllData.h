//
//  ZRHomeAllData.h
//  NetEcoSite
//
//  Created by Waki on 17/3/22.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRBarView.h"

@interface ZRHomeAllData : NSObject


//柱状图的数据
@property (strong, nonatomic) NSArray *datas;
@property (nonatomic, assign) ShowTextType showTextType;
//组数
@property (nonatomic, assign) NSInteger barViewNum;
/**  左边的数字 */
@property (assign, nonatomic) BOOL leftTotalNumberIsIntegerValue;
@property (assign, nonatomic) BOOL barNumberIsFloatValue;
@property (assign, nonatomic) CGFloat leftTotalNumber;
/**  右边的数字 */
@property (assign, nonatomic) CGFloat righrTotalNumber;
@property (nonatomic, assign) BOOL rightStringIsNumber;

//折线图的数据
@property (nonatomic, strong) NSArray *pointArr;

@property (nonatomic, strong) NSArray *bottomTitleArr;


@property (nonatomic, strong) NSArray *counterValueListModels;

@end
