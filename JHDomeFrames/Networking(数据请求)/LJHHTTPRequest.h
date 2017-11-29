//
//  LJHHTTPRequest.h
//  NSURL简单封装
//
//  Created by mac on 16/1/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myBlock)(NSString *obj);
typedef void(^Failed)(NSError *error);
typedef void(^TyBlock)(id obj,NSError *error);
@protocol LJHHTTPRequestDelegate <NSObject>
//数据请求完成时的代理
-(void)HTTPRequestCompletion:(id)obj;
//当获取数据失败时的代理
-(void)HTTPRequestFailed:(NSError *)error;
@end



@interface LJHHTTPRequest : NSObject
//通过代理的方式GET请求
+(void)GET:(NSString *)url params:(id)params delegate:(id)delegate;
//通过代理的方式POST请求
+(void)POST:(NSString *)url params:(id)params delegate:(id)delegate;
+(void)GET:(NSString *)url params:(id)params myBlock:(myBlock)completion failed:(Failed)failed;
+(void)POST:(NSString *)url params:(id)params myBlock:(myBlock)completion failed:(Failed)failed;

+(void)GET:(NSString *)url params:(id)params Tyblock:(TyBlock)block;
@end
