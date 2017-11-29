//
//  ToolManage.h
//  TuiJI
//
//  Created by ddapp on 17/5/12.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ExtUserModel.h"
//#import "GZModel.h"
typedef void(^asynBlock)(void);
typedef void(^uiBlock)(void);

@interface ToolManage : NSObject
+ (ToolManage *)sharedManager;


/**
 获取国旗图标字符串

 @param citystr 字符串
 @return 国旗图标字符串
 */
+(NSString *)gatCityImgCitystr:(NSString *)citystr;

/**
 获取城市字符串

 @param citystr 字符串
 @return 城市字符串
 */
+(NSString *)gatCityCitystr:(NSString *)citystr;

/**
 判断是否是好友

 @param userid 用户id
 @return yes是好友no不是好友
 */
+(BOOL)ismyfrend:(NSString *)userid;

/**
 判断是否已关注

 @param userid 用户id
 @return yes已关注no没有关注
 */
+(BOOL)isguanzgu:(NSString *)userid;
/**
 json解析字符串

 @param jsonString json字符
 @return 字典数组
 */
+ (id)dictionaryWithJsonString:(NSString *)jsonString;

/**
 数组字典转字符串

 @param obj id
 @return 字符串
 */
+(NSString *)jSonstringwithall:(id)obj;

//+(ExtUserModel *)getExtuserinfo:(NIMUser *)user;

+(void)dispathbeginasyn:(asynBlock)asynblock;
+(void)dispathcreatuiui:(uiBlock)uiblock;

//推己圈信息
+(NSArray *)getTJQData:(NSString *)name;
+(BOOL)wreatTJQData:(NSArray *)data;
//广场信息
+(NSArray *)getGCData:(NSString *)name;
+(BOOL)wreatGCData:(NSArray *)data;
//世界信息
+(NSDictionary *)getSJData:(NSString *)name;
+(BOOL)wreatSJData:(NSDictionary *)data;
//个人信息列表
+(NSArray *)getGRData:(NSString *)name;
+(BOOL)wreatGRData:(NSArray *)data;
//个人图片列表
+(NSArray *)getGRIMGData:(NSString *)name;
+(BOOL)wreatGRIMGData:(NSArray *)data;
//个人用户信息
+(NSDictionary *)getInfoData:(NSString *)name;
+(BOOL)wreatInfoData:(NSDictionary *)data;

//删除缓存数据
+(void)deletePlistDatas;
//清空缓存数据
+(void)emptyPlistDatas;


+(void)user_guangzhu_writhstr:(NSString *)uid;
+(void)user_guangzhu_addwrithrow:(NSInteger)row andgzmodel:(NSDictionary *)gzdict;
@end
