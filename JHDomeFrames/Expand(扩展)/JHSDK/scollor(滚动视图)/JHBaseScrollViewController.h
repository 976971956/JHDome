//
//  JHBaseScrollViewController.h
//  项目基本框架
//
//  Created by 李江湖 on 2017/3/18.
//  Copyright © 2017年 李江湖. All rights reserved.
//  自定义的滚动视图

#import <UIKit/UIKit.h>
#import "JHScrollTitleView.h"
@interface JHBaseScrollViewController : UIViewController

@property (nonatomic, strong) JHScrollTitleView *titleView;
//标题数组
@property(nonatomic ,strong) NSArray *titles;
@property(nonatomic ,strong) NSArray *cotrollorArr;

@end
