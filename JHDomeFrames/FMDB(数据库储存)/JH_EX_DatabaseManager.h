//
//  JH_EX_DatabaseManager.h
//  TuiJI
//
//  Created by ddapp on 17/6/2.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface JH_EX_DatabaseManager : NSObject
//单例
+ (JH_EX_DatabaseManager *)sharedManager;

//插入数据
- (BOOL)insertApp:(NSDictionary *)dict;

//查询数据
- (NSArray *)getApps;

//删除数据
- (BOOL)deleteApp:(NSString *)appId;

@end
