//
//  ZMXibTableViewController.m
//  ZMDemo
//
//  Created by ddapp on 17/1/12.
//  Copyright © 2017年 Hzming. All rights reserved.
//

#import "ZMXibTableViewController.h"

@interface ZMXibTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ZMXibTableViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.isReload && self.tableView.mj_header) {
        
        [self.tableView.mj_header beginRefreshing];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.isReload && !self.tableView.mj_header) {
        
        [self requestData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    
    self.start = 1;
    self.limit = 20;
    self.down = YES;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.allowsSelection = NO;
    if (self.tableView.tableFooterView == nil) {
        self.tableView.tableFooterView = [UIView new];
    }
//    if (@available(iOS 11.0, *)){
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
//        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
//    }
    [self initRefresh];
    
    [self addNoDataButton];
}


- (void)addNoDataButton {
    
    [self.noDataBtn addTarget:self action:@selector(requestData) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:self.noDataBtn belowSubview:self.tableView];
    
}


- (void)initRefresh
{
    KWeakSelf(self)
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        weakself.start = 1;
        weakself.page = 1;

        weakself.down = YES;
        [weakself requestData];
        
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        weakself.start += weakself.limit;
        weakself.page ++;

        weakself.down = NO;
        [weakself requestData];
        
    }];
    //    ;
    
}

- (void)removeRefresh {
    _tableView.mj_header = nil;
    
    _tableView.mj_footer = nil;
}

- (void)removeHeaderRefresh {
    _tableView.mj_header = nil;
}


- (void)removeFooterRefresh {
    _tableView.mj_footer = nil;
}



- (void)reloadData {
    
    [self reloadDataWithArray:nil];
}

- (void)reloadDataWithArray:(NSArray *)data
{
    [self reloadDataWithArray:data needNoDataBtn:YES];
}


- (void)reloadDataWithArray:(NSArray *)data needNoDataBtn:(BOOL)isNeed
{
    if (data) {
        if (self.down)    [self.dataSource removeAllObjects];
        
        [self.dataSource addObjectsFromArray:data];
        
    }
    [self.tableView reloadData];
    
    
    if (self.dataSource.count < self.page * self.limit) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer resetNoMoreData];
    }
    
    if (isNeed) {
        self.noDataBtn.center = self.tableView.center;
        
        self.tableView.hidden = self.dataSource.count == 0;
    }
    
    self.reload = YES;
    
}


#pragma mark - tableview数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMDataModel *model = self.dataSource[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellIdentifier];
        
    [cell paddingDataModel:self.dataSource[indexPath.row] indexPath:indexPath delegate:self];
    
    return cell;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMDataModel *model = self.dataSource[indexPath.row];
    
    return model.rowHeight;
}

-(void)ios11
{
    if (@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
}

@end
