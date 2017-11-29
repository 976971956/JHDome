//
//  GRDatabaseManager.m
//  TuiJI
//
//  Created by ddapp on 17/7/2.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "GRDatabaseManager.h"
//表名
#define TJQTable @"TJQTable"
@implementation GRDatabaseManager
{
    //数据库操作对象
    FMDatabase *db;
}

//单例
+ (GRDatabaseManager *)sharedManager
{
    static GRDatabaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GRDatabaseManager alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        //1, 创建or打开数据库
        db = [FMDatabase databaseWithPath:[self dbPath]];
        
        //打开数据库
        BOOL ret = [db open];
        NSLog(@"打开数据库:%@", ret ? @"成功" : @"失败");
        
        //2, 创建表
        BOOL ret2 = [self createTable];
        NSLog(@"创建表:%@", ret2 ? @"成功, 或者已经存在" : @"失败");
    }
    return self;
}

//2, 创建表
-(BOOL)createTable
{
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(id integer primary key autoincrement, uid text, bg_pic text, title text , sub_title text , like_count text)",TJQTable];
    
    return [db executeUpdate:sql];
}

//3.1, 插入数据
- (BOOL)insertApp:(NSDictionary *)dict
{
    NSString *sql = [NSString stringWithFormat:@"insert into %@(uid, bg_pic, title, sub_title, like_count) values(?,?,?,?,?)",TJQTable];
    
    return [db executeUpdate:sql, dict[@"uid"], dict[@"bg_pic"],dict[@"title"],dict[@"sub_title"],dict[@"like_count"]];
}

//3.2, 查询数据
- (NSArray *)getApps
{
    NSMutableArray *mArray = [NSMutableArray new];
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@",TJQTable];
    
    FMResultSet *set = [db executeQuery:sql];
    
    while (set.next) {
        
        NSString *uid = [set stringForColumn:@"uid"];
        NSString *bg_pic = [set stringForColumn:@"bg_pic"];
        NSString *title = [set stringForColumn:@"title"];
        NSString *sub_title = [set stringForColumn:@"sub_title"];
        NSString *like_count = [set stringForColumn:@"like_count"];
        //用字典封装
        NSDictionary *dict = @{@"uid":uid, @"bg_pic":bg_pic, @"title":title,@"sub_title":sub_title,@"like_count":like_count};
        
        [mArray addObject:dict];
    }
    
    return mArray;
}

//3.3, 删除数据
- (BOOL)deleteApp:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where uid=?",TJQTable];
    
    return [db executeUpdate:sql, uid];
}


//返回数据库文件存储路径
-(NSString *)dbPath
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"dbpath: %@", path);
    
    return [path stringByAppendingPathComponent:@"Application.db"];
}
@end
