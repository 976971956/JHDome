//
//  TJManagershttpTool.h
//  TuiJI
//
//  Created by ddapp on 17/5/17.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UserJsonModel.h"

typedef void(^succesBlock)(id responseObj);
typedef void(^errorBlock)(NSError *err);

@interface TJManagershttpTool : NSObject

+ (TJManagershttpTool *)sharedManager;
#pragma mark 通讯录
/**
 (通讯录)删除好友

 @param uid 用户id
 @param fid 好友id
 @param success 删除成功
 @param errors 失败
 */
+(void)deletFrenduid:(NSString *)uid andfrendId:(NSString *)fid success:(succesBlock)success error:(errorBlock)errors;
/**
 添加好友请求
 
 @param parm 参数
 @param userid 用户推己号
 @param success 成功
 @param errors 失败
 */
+(void)ADDfrendrequst:(NSDictionary *)parm anduserid:(NSString *)userid success:(succesBlock)success error:(errorBlock)errors;
/**
 (通讯录)同意或拒绝添加好友

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)frendrequst:(NSDictionary *)parm anduserid:(NSString *)userid success:(succesBlock)success error:(errorBlock)errors;
/**
 (通讯录)获取用户所有好友

 @param uid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)findallfrendUid:(NSString *)uid success:(succesBlock)success error:(errorBlock)errors;

/**
 (通讯录)添加备注名

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)addBeizhuNameparm:(NSDictionary *)parm anduserid:(NSString *)userid success:(succesBlock)success error:(errorBlock)errors;
#pragma mark 推己圈
/*-------------------------------------------------推己圈---------------------------------------------------------*/

/**
 (推己圈)看小视频时统计播放次数,并通知主人
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)watchVideoTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;
/**
 (推己圈)点赞 如该推文已被该用户点赞，则会取消点赞；如没点赞则点赞
 
 @param tid 推文id
 @param hostid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)dianzanHttpgetTid:(NSString *)tid hostid:(NSString *)hostid success:(succesBlock)success error:(errorBlock)errors;

/**
 (推己圈)查看推文点赞列表

 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
// 查看推文点赞列表
+(void)getPraiseTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;

/**
 (推己圈)查看推文评论列表

 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)getCommentsTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;
/**
 (推己圈)写个人推文
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)writetuiwenInfo:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;

/**
 (推己圈)收藏推文
 
 @param uid 用户id
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)tuijiquancollectUid:(NSString *)uid tid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;
/**
 获取单条推文（推己圈）

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)tweetparm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;
#pragma mark 广场
/*--------------------------------------------------广场-----------------------------------------------------------*/
/**
 (广场)查询某推文的父评论

 @param tid 推文id
 @param type 推文类型
 @param success 成功
 @param errors 失败
 */
+(void)selectfathercommentTid:(NSString *)tid type:(NSString *)type success:(succesBlock)success error:(errorBlock)errors;
/**
 (广场)查询某推文的子评论
 
 @param tid 推文id
 @param fatherid 父评论id
 @param type 推文类型
 @param success 成功
 @param errors 失败
 */
+(void)selectsoncommentTid:(NSString *)tid fatherid:(NSString *)fatherid type:(NSString *)type success:(succesBlock)success error:(errorBlock)errors;

/**
 (广场)删除一条评论

 @param delid 要删除的评论ID
 @param success 成功
 @param errors 失败
 */
+(void)deleteselectcommentdeleteid:(NSString *)delid success:(succesBlock)success error:(errorBlock)errors;
/**
 (广场)收藏他人推文
 
 @param uid 用户id
 @param tid 推文id
 @param type 推文类型
 @param success 成功
 @param errors 失败
 */
+(void)collectUid:(NSString *)uid tid:(NSString *)tid type:(NSString *)type success:(succesBlock)success error:(errorBlock)errors;
/**
 (广场)**获取用户关注的所有广场信息
 
 @param parm 用户id
 @param success 成功
 @param errors 失败
 */
+(void)getguangchangInfo:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;
/**
 (广场)看小视频时统计播放次数,并通知主人
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)GCwatchVideoTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;

/**
 (广场)通过推文id获取推文信息

 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)gettweetInfoTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;

/**
 (广场)推文点赞

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)dianzanGCgetParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;

/**
 (广场)推文取消点赞

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)dianzanCancelGCgetParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;

/**
 (世界)收藏

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)worldShouchanParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;

/**
 (世界)搜索

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)searchNameparm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;
/**
 转发推文

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)zhuanfaTuiwenParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;
#pragma mark 个人
/*----------------------------------个人------------------------------------------------*/
/**
 (个人)获取用户关注列表

 @param uid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)getUserGZuid:(NSString *)uid success:(succesBlock)success error:(errorBlock)errors;
/**
 (个人)获取用户被关注的关注者 
 @param uid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)getUserGZZuid:(NSString *)uid success:(succesBlock)success error:(errorBlock)errors;


//+(void)getPraiseTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;

/**
 (个人)初始化用户信息

 @param userid 用户id
 @param username 用户名
 @param success 成功
 @param errors 失败
 */
+(void)gethttpuserInfo:(NSString *)userid orusername:(NSString *)username success:(succesBlock)success error:(errorBlock)errors;

/**
 (个人)编辑个人信息

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)editmessageInfo:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;
/**
 (个人)删除推文
 
 @param tid 推文id
 @param success 成功回调
 @param errors 失败回调
 
 */
+(void)deleteTweetTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors;

/**
 (个人)修改推文
 
 @param tid 推文id
 @param texts 文字
 @param success 成功回调
 @param errors 失败回调
 */
+(void)editTweetTid:(NSString *)tid edittext:(NSString *)texts success:(succesBlock)success error:(errorBlock)errors;

/**
 (个人)发送帮助中心

 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)helpInfoparm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;

//(个人)编辑用户扩展信息
+(void)getEdituserex:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;
//(个人)获取用户扩展信息
+(void)getUserex:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors;

/**
 百度api接口

 @param text 参数
 @param success 成功
 @param errors 失败
 */
+(void)baiduapiparm:(NSString *)text success:(succesBlock)success error:(errorBlock)errors;
//上传到
+(NSString *)qiniushuanfa;
@end
