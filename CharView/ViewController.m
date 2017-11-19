//
//  ViewController.m
//  CharView
//
//  Created by Mr.wu on 2017/11/19.
//  Copyright © 2017年 ZR. All rights reserved.
//

#define ZRColorRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define ZRColors  @[ZRColorRGBA(206, 99, 96, 1), ZRColorRGBA(227, 159, 74, 1), ZRColorRGBA(113, 198, 106, 1)]


#import "ViewController.h"
#import "ZRBarCharViewCell.h"
#import "ZRHomeAllData.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        ZRHomeAllData *homeData = [[ZRHomeAllData alloc] init];
        homeData.showTextType = arc4random()%3;
        homeData.leftTotalNumberIsIntegerValue = YES;
        homeData.righrTotalNumber = 100;
        
        NSMutableArray *datas = [NSMutableArray arrayWithCapacity:5];
        NSMutableArray *bottomsTitleArr = [NSMutableArray arrayWithCapacity:5];
        NSMutableArray *pointArr = [NSMutableArray arrayWithCapacity:5];
        
        NSInteger tempMaxLeftTotalNumber = 0;
        __block CGFloat maxLeftTotalNumber = 0;

        for (int i = 0; i < 5; i++) {
            NSMutableArray *singleBarViewMsgArr = [NSMutableArray arrayWithCapacity:6];
            NSMutableArray *onBarColors = [NSMutableArray arrayWithCapacity:6];
            NSMutableArray *numberArr = [NSMutableArray arrayWithCapacity:6];
            for (int i = 0; i < 3; i++) {
                [onBarColors addObject:ZRColors[i]];
                
                CGFloat cvNum = arc4random()%20;
                [numberArr addObject:@(cvNum)];
                tempMaxLeftTotalNumber += cvNum;
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
                [dic setObject:onBarColors forKey:ZR_BarCharView_Colors_Key];
                [dic setObject:numberArr forKey:ZR_BarCharView_Numbers_Key];
                [singleBarViewMsgArr addObject:dic];
            }
            
            [bottomsTitleArr addObject:@"sfdsfd"];
            [datas addObject:singleBarViewMsgArr];
        }
        homeData.datas = datas;
        homeData.bottomTitleArr = bottomsTitleArr;
        homeData.pointArr = pointArr;
        homeData.leftTotalNumber = tempMaxLeftTotalNumber;
        
        [arr addObject:homeData];
    }
    self.dataSource = arr;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZRHomeAllData *data = self.dataSource[indexPath.row];
    NSString *cellID = @"22";
    
    ZRBarCharViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ZRBarCharViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell initBarCharViewWithBarMessages:data];
    }
    
    cell.barData = data;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [ZRBarCharViewCell rowHeight];
}

@end
