//
//  UIControl+JHButtonSel.h
//  TuiJI
//
//  Created by ddapp on 17/5/17.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (JHButtonSel)
@property (nonatomic, assign) NSTimeInterval LJH_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) BOOL noClick;
@end
