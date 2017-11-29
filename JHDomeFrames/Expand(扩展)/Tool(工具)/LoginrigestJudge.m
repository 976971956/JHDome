//
//  LoginrigestJudge.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/16.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import "LoginrigestJudge.h"
//MD5加密类
#import <CommonCrypto/CommonDigest.h>

@implementation LoginrigestJudge
+(LoginrigestJudge *)shardManager
{
    static LoginrigestJudge *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LoginrigestJudge alloc] init];
    });
    return instance;
}

//判断是不是正则表达式的基类guizhe：传入规则。name:传入字符串
-(BOOL)Zhengzheguize:(NSString *)guizhe andstr:(NSString *)name
{
    //    不能以0开头
    //    全部是数字
    //    5到11为数字
    NSRegularExpression *pression = [[NSRegularExpression alloc]initWithPattern:guizhe options:0 error:nil];
    NSArray *results = [pression matchesInString:name options:0 range:NSMakeRange(0, name.length)];
    
    return results.count>0;
}
//判断是不是手机号
-(BOOL)JudgePhoneNum:(NSString *)username
{
    //    不能以0开头
    //    全部是数字
    //    5到11为数字
    return [self Zhengzheguize:@"^1[23578]\\d{9}$" andstr:username];
}
//判断密码
-(BOOL)JudgePassword:(NSString *)password Passwordindex:(NSRange)index
{
    
//    return [self Zhengzheguize:@"^[a-zA-Z0-9]{6,20}+$" andstr:password];
    return [self Zhengzheguize:[NSString stringWithFormat:@"^[a-zA-Z0-9]{%ld,%ld}+$",index.location,index.location+index.length] andstr:password];
}
-(BOOL)JudgeCode:(NSString *)code codeindex:(NSInteger)index
{
    return [self Zhengzheguize:[NSString stringWithFormat:@"^[a-zA-Z0-9]{%ld}+$",index] andstr:code];
}

//判断邮箱
-(BOOL)JudgedateEmail:(NSString *)email {
    return [self Zhengzheguize:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" andstr:email];
}
//验证身份证号
-(BOOL)JudgedateIdentityCard:(NSString *)identityCard{
    return [self Zhengzheguize:@"^(\\d{14}|\\d{17})(\\d|[xX])$" andstr:identityCard];
}

- (NSString *)login_md5:(NSString *) input{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
