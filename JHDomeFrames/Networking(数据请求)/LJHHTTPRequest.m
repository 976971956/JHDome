//
//  LJHHTTPRequest.m
//  NSURL简单封装
//
//  Created by mac on 16/1/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "LJHHTTPRequest.h"

@interface LJHHTTPRequest () <NSURLConnectionDataDelegate>

@end

@implementation LJHHTTPRequest
{
    NSMutableData *myData;
//    调用代理的方法
    id <LJHHTTPRequestDelegate> _delegate;
//    调用完成时的block
    myBlock comletion;
    Failed faileds;
    TyBlock blocks;
}
+(void)GET:(NSString *)url params:(id)params Tyblock:(TyBlock)block
{
    LJHHTTPRequest *request = [[LJHHTTPRequest alloc]init];
    [request httpRequest:url params:params delegate:nil myBlock:nil failed:nil TyBlock:block method:@"GET"];
}

+(void)GET:(NSString *)url params:(id)params myBlock:(myBlock)completion failed:(Failed)failed
{
    LJHHTTPRequest *request = [[LJHHTTPRequest alloc]init];
    [request httpRequest:url params:params delegate:nil myBlock:completion failed:failed TyBlock:nil method:@"GET"];
}
+(void)POST:(NSString *)url params:(id)params myBlock:(myBlock)completion failed:(Failed)failed
{
    LJHHTTPRequest *request = [[LJHHTTPRequest alloc]init];
    [request httpRequest:url params:params delegate:nil myBlock:completion failed:failed TyBlock:nil method:@"POST"];
}
+(void)GET:(NSString *)url params:(id)params delegate:(id)delegate
{
    LJHHTTPRequest *request = [[LJHHTTPRequest alloc]init];
    [request httpRequest:url params:params delegate:delegate myBlock:nil failed:nil TyBlock:nil method:@"GET"];
}
+(void)POST:(NSString *)url params:(id)params delegate:(id)delegate
{
    LJHHTTPRequest *request = [[LJHHTTPRequest alloc]init];
    [request httpRequest:url params:params delegate:delegate myBlock:nil failed:nil TyBlock:nil method:@"POST"];

}
//统一数据请求
-(void)httpRequest:(NSString *)url params:(id)params delegate:(id)delegate myBlock:(myBlock)completion failed:(Failed)failed TyBlock:(TyBlock)block method:(NSString *)method
{
    _delegate=delegate;
    comletion=completion;
    faileds=failed;
    blocks=block;
//    username=45454&password=212
//    拼接字典中的值key＝value
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (NSString *key in params) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,params[key]];
        [tmp addObject:str];
    }
//    用&拼接数组中的每一项
    NSString *paramStr = [tmp componentsJoinedByString:@"&"];

//创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
//    判断请求方式
    if ([method isEqualToString:@"GET"]) {
//先追加参数
        url = [url stringByAppendingFormat:@"?%@",paramStr];
        request.URL= [NSURL URLWithString:url];
//        设置url
        
    }else if ([method isEqualToString:@"POST"]){
        request.URL = [NSURL URLWithString:url];
        request.HTTPBody = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    [NSURLConnection connectionWithRequest:request delegate:self];

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    初始化
    if (myData==nil) {
        myData = [[NSMutableData alloc]init];
    }else{
        myData.length=0;
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    追加数据
    [myData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    接收解析时的错误信息
    NSError *error = nil;
//解析数据
    id obj = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:&error];
    if (error==nil) {
        if (_delegate && [_delegate respondsToSelector:@selector(HTTPRequestCompletion:)]) {
            [_delegate HTTPRequestCompletion:obj];
        }
//        调用完成时的block
        if (comletion) {
            comletion(obj);
        }
        if (blocks) {
            blocks(obj,nil);
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(HTTPRequestFailed:)]) {
            [_delegate HTTPRequestFailed:error];
        }
        if (faileds) {
            faileds(error);
        }
        if (blocks) {
            blocks(nil,error);
        }
    }
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

}
@end
