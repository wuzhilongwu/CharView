//
//  ZRDottedLineView.h
//  NetEcoSite
//
//  Created by Mr.wu on 2017/3/18.
//  Copyright © 2017年 ZR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ZRDottedLineView : UIView

@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithFrame:(CGRect)frame line:(NSInteger)line row:(NSInteger)row;

@end
