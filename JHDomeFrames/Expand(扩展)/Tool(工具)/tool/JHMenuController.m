//
//  JHMenuController.m
//  TuiJI
//
//  Created by ddapp on 17/6/19.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "JHMenuController.h"

@implementation JHMenuController
//单例
+ (JHMenuController *)sharedManager
{
    static JHMenuController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JHMenuController alloc] init];
    });
    return instance;
}
@end
