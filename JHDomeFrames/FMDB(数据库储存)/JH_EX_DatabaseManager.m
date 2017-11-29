//
//  JH_EX_DatabaseManager.m
//  TuiJI
//
//  Created by ddapp on 17/6/2.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "JH_EX_DatabaseManager.h"

@implementation JH_EX_DatabaseManager
{
    //数据库操作对象
    FMDatabase *db;
    NSArray *tableArrkey;
    NSArray *tableArrkeyValue;
    NSString *tableNames;
}

//单例
+ (JH_EX_DatabaseManager *)sharedManager
{
    static JH_EX_DatabaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JH_EX_DatabaseManager alloc] init];
    });
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        
//        //1, 创建or打开数据库
//        db = [FMDatabase databaseWithPath:[self dbPath]];
//        
//        //打开数据库
//        BOOL ret = [db open];
//        NSLog(@"打开数据库:%@", ret ? @"成功" : @"失败");
//        
//        //2, 创建表
//        BOOL ret2 = [self createTable];
//        NSLog(@"创建表:%@", ret2 ? @"成功, 或者已经存在" : @"失败");
    }
    return self;
}
-(void)initDataArr:(NSArray *)arr andTablename:(NSString *)tablename andDBName:(NSString *)dbname
{
    tableArrkey = arr;
    tableNames = tablename;
    //1, 创建or打开数据库
    db = [FMDatabase databaseWithPath:[self dbPathName:dbname]];
    
    //打开数据库
    BOOL ret = [db open];
    NSLog(@"打开(创建)数据库:%@", ret ? @"成功" : @"失败");
    
    //2, 创建表
    BOOL ret2 = [self createTable:arr andTableName:tablename];
    NSLog(@"创建表:%@", ret2 ? @"成功, 或者已经存在" : @"失败");

}
//2, 创建表
-(BOOL)createTable:(NSArray *)arr andTableName:(NSString *)tablename
{
    NSString *sql ;
    NSString *sqltablename = [NSString stringWithFormat:@"create table if not exists %@(id integer primary key autoincrement",tablename];
    for (NSString *titlename in arr) {
        NSString *title = [NSString stringWithFormat:@",%@ text",titlename];
      sql = [sqltablename stringByAppendingString:title];
    }
    sql = [sql stringByAppendingString:@")"];
//    NSString *sql = @"create table if not exists App(id integer primary key autoincrement, uid text, bg_pic text, title text , sub_title text , like_count text)";
    
    return [db executeUpdate:sql];
}

//3.1, 插入数据
- (BOOL)insertApp:(NSDictionary *)dict
{
    NSMutableString *sqlname = [NSMutableString string];
    NSString *sqltablename = [NSString stringWithFormat:@"insert into %@(",tableNames];
    for (NSString *name in tableArrkey) {
      NSString *names = [sqltablename stringByAppendingString:[NSString stringWithFormat:@"%@,",name]];
        [sqlname appendString:names];
    }
    [sqlname deleteCharactersInRange:NSMakeRange(sqlname.length-2, 1)];
    [sqlname appendString:@") values("];
    for (NSString *title in tableArrkey) {
        [sqlname appendFormat:@"%@,",[dict objectForKey:title]];
    }
    [sqlname deleteCharactersInRange:NSMakeRange(sqlname.length-2, 1)];
    [sqlname appendString:@")"];
    NSString *sql = @"insert into App(uid, bg_pic, title, sub_title, like_count) values(?,?,?,?,?)";
    
    return [db executeUpdate:sql];
}

//3.2, 查询数据
- (NSArray *)getTableData
{
    NSMutableArray *mArray = [NSMutableArray new];
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableNames];
    
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
    NSString *sql = @"delete from App where uid=?";
    
    return [db executeUpdate:sql, uid];
}


//返回数据库文件存储路径
-(NSString *)dbPathName:(NSString *)pathname
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"dbpath: %@", path);
    
    return [path stringByAppendingPathComponent:pathname];
}
@end
