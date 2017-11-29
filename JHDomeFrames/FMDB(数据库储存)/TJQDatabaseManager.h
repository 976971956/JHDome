//
//  TJQDatabaseManager.h
//  TuiJI
//
//  Created by ddapp on 17/7/2.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface TJQDatabaseManager : NSObject
//单例
+ (TJQDatabaseManager *)sharedManager;

//插入数据
- (BOOL)insertApp:(NSDictionary *)dict;

//查询数据
- (NSArray *)getApps;

//删除数据
- (BOOL)deleteApp:(NSString *)appId;
@end
