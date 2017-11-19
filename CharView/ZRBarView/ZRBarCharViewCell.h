//
//  ZRBarCharViewCell.h
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/21.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import "ZRBarCharView.h"
#import "ZRHomeAllData.h"

@interface ZRBarCharViewCell : UITableViewCell


@property (nonatomic, strong) ZRHomeAllData *barData;

@property (nonatomic, strong) NSMutableArray *drillBarDatas;

- (void)initBarCharViewWithBarMessages:(ZRHomeAllData *)barMessages;

+ (CGFloat)rowHeight;

@end
