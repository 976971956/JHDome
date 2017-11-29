//
//  ToolManage.m
//  TuiJI
//
//  Created by ddapp on 17/5/12.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "ToolManage.h"

@implementation ToolManage
//单例
+ (ToolManage *)sharedManager
{
    static ToolManage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ToolManage alloc] init];
    });
    return instance;
}
+(NSString *)gatCityImgCitystr:(NSString *)citystr{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    NSArray *arr = [citystr componentsSeparatedByString:@"_&"];
    for (NSDictionary *citydict in array) {
        if ([citydict[@"_Code"] isEqualToString:[arr lastObject]]) {
            
            NSString *str = [[arr lastObject] lowercaseString];
            
            return str;
        }
    }
    return @"";
}

+(NSString *)gatCityCitystr:(NSString *)citystr
{
    NSArray *arr = [citystr componentsSeparatedByString:@"_&"];
    return [arr firstObject];
}

+ (id)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSString *)jSonstringwithall:(id)obj
{
    //    NSString *jsonstr;
    //
    //    if ([[obj class] isSubclassOfClass:[NSArray class]]) {
    //    }else if([[obj class] isSubclassOfClass:[NSDictionary class]]){
    //
    //    }
    NSData *data=[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonstr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonstr;
}
+(void)dispathbeginasyn:(asynBlock)asynblock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        asynblock();
    });
}
+(void)dispathcreatuiui:(uiBlock)uiblock
{
    dispatch_async(dispatch_get_main_queue(), ^{
        uiblock();
    });
}

+(NSArray *)getTJQData:(NSString *)name{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TJQDatas.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    return array;
}
+(BOOL)wreatTJQData:(NSArray *)data{
    //    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    //获取完整路径
    //    NSString *documentsPath = [path objectAtIndex:0];
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    NSLog(@"%@",documentsPath);
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"TJQDatas.plist"];
    //写入文件
    BOOL bval = [data writeToFile:plistPath atomically:YES];
    
    if(bval)
    {
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
    
    return bval;
}
+(NSArray *)getGCData:(NSString *)name{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GCDatas.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    return array;
}
+(BOOL)wreatGCData:(NSArray *)data{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GCDatas.plist"];
    //写入文件
    BOOL bval = [data writeToFile:plistPath atomically:YES];
    
    if(bval)
    {
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
    
    return bval;
}
+(NSDictionary *)getSJData:(NSString *)name{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"SJDatas.plist"];
    NSDictionary *array = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return array;
}
+(BOOL)wreatSJData:(NSDictionary *)data{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"SJDatas.plist"];
    //写入文件
    BOOL bval = [data writeToFile:plistPath atomically:YES];
    
    if(bval)
    {
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
    
    return bval;
}
+(NSArray *)getGRData:(NSString *)name{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GRDatas.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    return array;
}
+(BOOL)wreatGRData:(NSArray *)data{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GRDatas.plist"];
    //写入文件
    BOOL bval = [data writeToFile:plistPath atomically:YES];
    
    if(bval)
    {
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
    
    return bval;
}
+(NSArray *)getGRIMGData:(NSString *)name{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GRIMGDatas.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    return array;
}
+(BOOL)wreatGRIMGData:(NSArray *)data{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"GRIMGDatas.plist"];
    //写入文件
    BOOL bval = [data writeToFile:plistPath atomically:YES];
    if(bval)
    {
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
    return bval;
}
+(NSDictionary *)getInfoData:(NSString *)name{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"INFODatas.plist"];
    NSDictionary *array = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return array;
}
+(BOOL)wreatInfoData:(NSDictionary *)data
{
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"INFODatas.plist"];
    //写入文件
    BOOL bval = [data writeToFile:plistPath atomically:YES];
    
    if(bval)
    {
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
    
    return bval;
    
}
+(void)deletePlistDatas
{
    NSFileManager *file = [NSFileManager defaultManager];
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    
    NSString *tjqPath = [documentsPath stringByAppendingPathComponent:@"TJQDatas.plist"];
    NSString *gcPath = [documentsPath stringByAppendingPathComponent:@"GCDatas.plist"];
    NSString *sjPath = [documentsPath stringByAppendingPathComponent:@"SJDatas.plist"];
    NSString *grPath = [documentsPath stringByAppendingPathComponent:@"GRDatas.plist"];
    NSString *infoPath = [documentsPath stringByAppendingPathComponent:@"INFODatas.plist"];
    NSString *grImgPath = [documentsPath stringByAppendingPathComponent:@"GRIMGDatas.plist"];
    
    NSError *errorTJQ;
    NSError *errorGC;
    NSError *errorSJ;
    NSError *errorGR;
    NSError *errorINFO;
    NSError *errorGRIMG;
    
    BOOL bvatjq = [file removeItemAtPath:tjqPath error:&errorTJQ];
    BOOL bvagc = [file removeItemAtPath:gcPath error:&errorGC];
    BOOL bvasj = [file removeItemAtPath:sjPath error:&errorSJ];
    BOOL bvagr = [file removeItemAtPath:grPath error:&errorGR];
    BOOL bvainfo = [file removeItemAtPath:infoPath error:&errorINFO];
    BOOL bvagrimg = [file removeItemAtPath:grImgPath error:&errorGRIMG];
    
    if (errorTJQ) {
        NSLog(@"推己圈删除出错");
    }
    if (errorGC) {
        NSLog(@"广场删除出错");
    }
    if (errorSJ) {
        NSLog(@"世界删除出错");
    }
    if (errorGR) {
        NSLog(@"个人删除出错");
    }
    if (errorINFO) {
        NSLog(@"用户信息删除出错");
    }
    if (errorGRIMG) {
        NSLog(@"个人图集删除出错");
    }
    NSLog(@"推己圈删除%@",bvatjq?@"成功":@"失败");
    NSLog(@"广场删除%@",bvagc?@"成功":@"失败");
    NSLog(@"世界删除%@",bvasj?@"成功":@"失败");
    NSLog(@"个人删除%@",bvagr?@"成功":@"失败");
    NSLog(@"用户信息删除%@",bvainfo?@"成功":@"失败");
    NSLog(@"个人图集删除%@",bvagrimg?@"成功":@"失败");
}
+(void)emptyPlistDatas
{
    NSArray *clearArr = [NSArray array];
    NSString *documentsPath = [[NSFileManager defaultManager] Createdirectory:NSTemporaryDirectory() directory:@"PlistHC"];
    
    
    NSString *tjqPath = [documentsPath stringByAppendingPathComponent:@"TJQDatas.plist"];
    NSString *gcPath = [documentsPath stringByAppendingPathComponent:@"GCDatas.plist"];
    NSString *sjPath = [documentsPath stringByAppendingPathComponent:@"SJDatas.plist"];
    NSString *grPath = [documentsPath stringByAppendingPathComponent:@"GRDatas.plist"];
    NSString *infoPath = [documentsPath stringByAppendingPathComponent:@"INFODatas.plist"];
    NSString *grImgPath = [documentsPath stringByAppendingPathComponent:@"GRIMGDatas.plist"];
    
    //写入文件
    BOOL bvatjq = [clearArr writeToFile:tjqPath atomically:YES];
    BOOL bvagc = [clearArr writeToFile:gcPath atomically:YES];
    BOOL bvasj = [clearArr writeToFile:sjPath atomically:YES];
    BOOL bvagr = [clearArr writeToFile:grPath atomically:YES];
    BOOL bvainfo = [clearArr writeToFile:infoPath atomically:YES];
    BOOL bvagrimg = [clearArr writeToFile:grImgPath atomically:YES];
    
    NSLog(@"推己圈清空%@",bvatjq?@"成功":@"失败");
    NSLog(@"广场清空%@",bvagc?@"成功":@"失败");
    NSLog(@"世界清空%@",bvasj?@"成功":@"失败");
    NSLog(@"个人清空%@",bvagr?@"成功":@"失败");
    NSLog(@"用户信息清空%@",bvainfo?@"成功":@"失败");
    NSLog(@"个人图集清空%@",bvagrimg?@"成功":@"失败");
}

+(void)user_guangzhu_addwrithrow:(NSInteger)row andgzmodel:(NSDictionary *)gzdict
{
    NSArray *arr = USER_GUANGZHU_VALUE;
    NSMutableArray *mutarr = [NSMutableArray arrayWithArray:arr];
    [mutarr insertObject:gzdict atIndex:row];
    USER_GUANGZHUWRITH_VALUE(mutarr);
}
@end
