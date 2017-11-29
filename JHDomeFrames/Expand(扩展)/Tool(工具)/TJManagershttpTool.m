//
//  TJManagershttpTool.m
//  TuiJI
//
//  Created by ddapp on 17/5/17.
//  Copyright © 2017年 LJH. All rights reserved.
//  推己帮助共有类帮助文件

#import "TJManagershttpTool.h"

@implementation TJManagershttpTool
//单例
+ (TJManagershttpTool *)sharedManager
{
    static TJManagershttpTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TJManagershttpTool alloc] init];
    });
    return instance;
}
/**
 删除好友
 
 @param uid 用户id
 @param fid 好友id
 @param success 删除成功
 @param errors 失败
 */
+(void)deletFrenduid:(NSString *)uid andfrendId:(NSString *)fid success:(succesBlock)success error:(errorBlock)errors
{
//    NSDictionary *dict = @{@"username":fid};
    NSString *url = [NSString stringWithFormat:@"%@/%@",NSStringCenS(DELETEFREND),fid];
    [[HTTPSessionManager sharedManager] DELETEHEADER:url params:@{@"username":fid} headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];
}

/**
 添加好友请求

 @param parm 参数
 @param userid 用户推己号
 @param success 成功
 @param errors 失败
 */
+(void)ADDfrendrequst:(NSDictionary *)parm anduserid:(NSString *)userid success:(succesBlock)success error:(errorBlock)errors
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",NSStringCenS(INSERTFRIEND),userid];
    [[HTTPSessionManager sharedManager] POSTHEADER:url params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];

}
/**
 (通讯录)同意或拒绝添加好友
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)frendrequst:(NSDictionary *)parm anduserid:(NSString *)userid success:(succesBlock)success error:(errorBlock)errors{
    NSString *url = [NSString stringWithFormat:@"%@/%@",NSStringCenS(FRIENDREQUEST),userid];
    [[HTTPSessionManager sharedManager] POSTHEADER:url params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 (通讯录)添加备注名
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)addBeizhuNameparm:(NSDictionary *)parm anduserid:(NSString *)userid success:(succesBlock)success error:(errorBlock)errors
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",NSStringCenS(UPDATEREMARK),userid];
    [[HTTPSessionManager sharedManager] PUTHEADER:url params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];
}
/**
 (通讯录)获取用户所有好友
 
 @param uid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)findallfrendUid:(NSString *)uid success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(FINDALL) params:nil headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 点赞 如该推文已被该用户点赞，则会取消点赞；如没点赞则点赞
 
 @param tid 推文id
 @param hostid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)dianzanHttpgetTid:(NSString *)tid hostid:(NSString *)hostid success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparam = @{@"tId":tid,@"hostId":hostid};
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(TJQDIANZAN) params:dictparam headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                success(responseObj[@"desc"]);
            }
        }else{
            errors(error);
        }
        
    }];
}
/**
 删除推文
 
 @param tid 推文id
 @param success 成功回调
 @param errors 失败回调
 
 */
+(void)deleteTweetTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparam = @{@"tId":tid,@"uId":USER_USERID};
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(DELETETWEET) params:dictparam headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                success(responseObj[@"desc"]);
            }
        }else{
            errors(error);
        }
        
    }];

}
/**
 修改推文
 
 @param tid 推文id
 @param texts 文字
 @param success 成功回调
 @param errors 失败回调
 */
+(void)editTweetTid:(NSString *)tid edittext:(NSString *)texts success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparam = @{@"tId":tid,@"uId":USER_USERID,@"modifiedText":texts};
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(EDITTWEET) params:dictparam headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
            errors(error);
        }
        
    }];

}
/**
 (推己圈)看小视频时统计播放次数,并通知主人
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)watchVideoTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors{
    NSDictionary *dictparams = @{@"uid":USER_USERID,@"tid":tid};
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(WATCHVIDEO) params:dictparams headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
            errors(error);
        }

    }];
}
/**
 获取单条推文(推己圈)
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)tweetparm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(TWEET) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 (广场)看小视频时统计播放次数,并通知主人
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)GCwatchVideoTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparams = @{@"uid":USER_USERID,@"tid":tid};
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(GCWATCHVIDEO) params:dictparams headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];

}
/**
 (广场)通过推文id获取推文信息
 
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)gettweetInfoTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors
{
    if (!tid) {
        return;
    }
    NSDictionary *dictparams = @{@"ID":tid,@"type":@"0"};
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(SELECTTWEETCONTEXT) params:dictparams headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];

}
/**
 (广场)推文点赞
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)dianzanGCgetParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(GCDIANZAN) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 (广场)推文取消点赞
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)dianzanCancelGCgetParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(CANCELPRAISE) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 (世界)收藏
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)worldShouchanParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(COLLECTION) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 (世界)搜索
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)searchNameparm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(SEARCHNAME) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 转发推文
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)zhuanfaTuiwenParm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(TURNTWEET) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];
}

/**
 查看推文点赞列表
 
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)getPraiseTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors{
    NSDictionary *dictparams = @{@"hostId":USER_USERID,@"tId":tid};
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(GETPRAISE) params:dictparams headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
            errors(error);
        }
        
    }];

}
/**
 (推己圈)查看推文评论列表
 
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)getCommentsTid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparams = @{@"currentUid":USER_USERID,@"tId":tid};
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(GETCOMMENTS) params:dictparams headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
//            errors(error);
        }
        
    }];
}
+(void)helpInfoparm:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
[[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(HELP_INFO) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
    if (!error) {
        success(responseObj);
    }else{
        errors(error);
    }
}];

}
#pragma 广场
/**
 (广场)查询某推文的父评论
 
 @param tid 推文id
 @param type 推文类型
 @param success 成功
 @param errors 失败
 */
+(void)selectfathercommentTid:(NSString *)tid type:(NSString *)type success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparams = @{@"ID":tid,@"type":type};
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(SELECTFATHERCOMMENT) params:dictparams headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
        
    }];
}
/**
 (广场)查询某推文的子评论
 
 @param tid 推文id
 @param fatherid 父评论id
 @param type 推文类型
 @param success 成功
 @param errors 失败
 */
+(void)selectsoncommentTid:(NSString *)tid fatherid:(NSString *)fatherid type:(NSString *)type success:(succesBlock)success error:(errorBlock)errors
{
    NSDictionary *dictparams = @{@"TweetID":tid,@"fatherCommentID":fatherid,@"type":type};

    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(SELECTSONCOMMENT) params:dictparams headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];

}
/**
 (广场)删除一条评论
 
 @param delid 要删除的评论ID
 @param success 成功
 @param errors 失败
 */
+(void)deleteselectcommentdeleteid:(NSString *)delid success:(succesBlock)success error:(errorBlock)errors{
    NSDictionary *dictparams = @{@"commentID":delid};

    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(GCDELETECOMMENT) params:dictparams headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
        
    }];

}
/**
 我关注的所有用户关注列表
 
 @param uid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)getUserGZuid:(NSString *)uid success:(succesBlock)success error:(errorBlock)errors{
    NSDictionary *dicts = @{@"userID":uid};
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(SELECTATTENTION) params:dicts headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[0][@"code"] intValue] == 200) {
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
            errors(error);
        }

    }];
}

/**
 别人关注我的关注者

 @param uid 用户id
 @param success 成功
 @param errors 失败
 */
+(void)getUserGZZuid:(NSString *)uid success:(succesBlock)success error:(errorBlock)errors{
    NSDictionary *dicts = @{@"attentionID":uid};
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(SELECTATTENTIONED) params:dicts headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[0][@"code"] integerValue]==200) {
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
            errors(error);
        }
        
    }];
}
/**
 (广场)收藏他人推文
 
 @param uid 用户id
 @param tid 推文id
 @param type 推文类型
 @param success 成功
 @param errors 失败
 */
+(void)collectUid:(NSString *)uid tid:(NSString *)tid type:(NSString *)type success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(COLLECTTWEET) params:@{@"userID":uid,@"ID":tid,@"type":type} headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 (推己圈)收藏推文
 
 @param uid 用户id
 @param tid 推文id
 @param success 成功
 @param errors 失败
 */
+(void)tuijiquancollectUid:(NSString *)uid tid:(NSString *)tid success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(COLLECT) params:@{@"collectorId":uid,@"tId":tid} headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
/**
 初始化用户信息
 
 @param userid 用户id
 @param username 用户名
 @param success 成功
 @param errors 失败
 */
+(void)gethttpuserInfo:(NSString *)userid orusername:(NSString *)username success:(succesBlock)success error:(errorBlock)errors
{
    if (userid==nil) {
        return;
    }
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(GETUSERInfo) params:@{@"uId":userid,@"username":username} headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            if ([responseObj[@"code"] intValue] == 200) {
                success(responseObj);
            }else{
                success(responseObj);
            }
        }else{
                errors(error);
        }
    }];
}
/**
 编辑个人信息
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)editmessageInfo:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(EDITMESSAGEINFO) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];
}
/**
 (推己圈)写个人推文
 
 @param parm 参数
 @param success 成功
 @param errors 失败
 */
+(void)writetuiwenInfo:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(WRITETWEET) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
        
    }];
}
/**
 (广场)**获取用户关注的所有广场信息
 
 @param parm 用户id
 @param success 成功
 @param errors 失败
 */
+(void)getguangchangInfo:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(SELECTTWEET) params:parm headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }

    }];
}
//编辑用户扩展信息=
+(void)getEdituserex:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] POSTHEADER:NSStringCenS(EDITUINFOEX) params:parm headToken:USER_ACCESS_TOKEN resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
}
//获取用户扩展信息
+(void)getUserex:(NSDictionary *)parm success:(succesBlock)success error:(errorBlock)errors
{
    [[HTTPSessionManager sharedManager] GETHEADER:NSStringCenS(UINFOEX) params:parm headToken:USER_ACCESS_TOKEN result:^(id responseObj, NSError *error, NSProgress *progress) {
        if (!error) {
            success(responseObj);
        }else{
            errors(error);
        }
    }];
 
}

+(void)baiduapiparm:(NSString *)text success:(succesBlock)success error:(errorBlock)errors
{
    NSString *salt = [NSDate getnewdate];
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",BAIDUAPPID,text,salt,BAIDUKEY];
    
    NSDictionary *parm = @{@"q":text,@"from":@"auto",@"to":@"auto",@"appid":BAIDUAPPID,@"salt":salt,@"sign":[sign set_md5]};
    [[HTTPSessionManager sharedManager] POST:BAIDUFANYIAPI params:parm resulf:^(id responseObj, NSError *error, NSProgress *progress) {
        if (error) {
            errors(error);
        }else{
         NSDictionary *fanyidict = responseObj[@"trans_result"][0];
            
        success(fanyidict[@"dst"]);
        }
    }];
}
+(NSString *)qiniushuanfa
{
    NSMutableString *ttt=[NSMutableString stringWithFormat:@""];
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    
    //    时间搓
    ino64_t timeint = interval*1000;
    
    NSString *timestr = [NSString stringWithFormat:@"%llu",timeint];
    
    NSMutableString *s =[NSMutableString string];
    while (timeint>0) {
        NSString *str = [NSString stringWithFormat:@"%llu",timeint%7];
        [s appendString:str];
        timeint /= 7;
    }
    NSString *timest =[s substringWithRange:NSMakeRange(0, 6)];
    
    int bb = arc4random() % 100000;
    
    [ttt appendString:timestr];
    
    [ttt appendString:[s substringWithRange:NSMakeRange(0, 2)]];
    
    [ttt appendString:[NSString stringWithFormat:@"%d",bb]];
    
    [ttt appendString:[s substringWithRange:NSMakeRange(timest.length-4, 4)]];
    
    
    return ttt;
}

@end
