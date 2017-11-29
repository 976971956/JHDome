//
//  HTTPSessionManager.m
//  ILimitFree
//
//  Created by iJeff on 16/1/6.
//  Copyright (c) 2016年 iJeff. All rights reserved.
//

#import "HTTPSessionManager.h"

#import "AFNetworking.h"
@implementation HTTPSessionManager

//单例
+ (HTTPSessionManager *)sharedManager
{
    static HTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPSessionManager alloc] init];
    });
    return instance;
}


- (void)GET:(NSString *)url params:(id)params result:(ResultBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    超时时间
    manager.requestSerializer.timeoutInterval = 20;

//    设置数据返回的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/javascript",@"application/json",@"text/json",nil];
//    开始请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"%@",downloadProgress);
        result(nil, nil, downloadProgress);
        //对任务进度对象的完成比例进行监听
        [downloadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求数据成功后回传
        if (result) {
            
            result(responseObject, nil, nil);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        if (result) {
            result(nil, error,nil);
        }
    }];
}
- (void)GETHEADER:(NSString *)url params:(id)params headToken:(NSString *)token result:(ResultBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    超时时间
    manager.requestSerializer.timeoutInterval = 10;
    [self clearcookei];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//请求数据为二进制数据

    //    设置数据返回的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/javascript",@"application/json",@"text/json",nil];
    //    开始请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"%@",downloadProgress);
//        result(nil, nil, downloadProgress);
//        //对任务进度对象的完成比例进行监听
//        [downloadProgress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求数据成功后回传
        if (result) {
            
            NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            result(dict, nil, nil);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        if (result) {
            result(nil, error,nil);
        }
    }];
}

-(void)clearcookei
{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}
-(void)POST:(NSString *)url params:(id)params resulf:(ResultBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//text/html
//   设置超时时间
    manager.requestSerializer.timeoutInterval = 20;
    [self clearcookei];
  
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//请求数据为二进制数据
//    设置基本的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/javascript",@"application/json",@"text/json",nil];
//     开始请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (result) {
//            result(nil,nil,uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            result(dict,nil,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil,error,nil);
        }
    }];

}
-(void)POSTHEADER:(NSString *)url params:(id)params headToken:(NSString *)token resulf:(ResultBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//text/html
    
    //   设置超时时间
    manager.requestSerializer.timeoutInterval = 10;
    [self clearcookei];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//请求数据为二进制数据
    //    设置基本的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/javascript",@"application/json",@"text/json",nil];
    //     开始请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (result) {
//            //            result(nil,nil,uploadProgress);
//        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            result(dict,nil,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil,error,nil);
        }
    }];
    
}
-(void)DELETEHEADER:(NSString *)url params:(id)params headToken:(NSString *)token resulf:(ResultBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//text/html
    
    //   设置超时时间
    manager.requestSerializer.timeoutInterval = 10;
    [self clearcookei];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//请求数据为二进制数据
    //    设置基本的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/javascript",@"application/json",@"text/json",nil];
    //     开始请求
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            result(dict,nil,nil);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil,error,nil);
        }

    }];
    
}
-(void)PUTHEADER:(NSString *)url params:(id)params headToken:(NSString *)token resulf:(ResultBlock)result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//text/html
    
    //   设置超时时间
    manager.requestSerializer.timeoutInterval = 10;
    [self clearcookei];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//请求数据为二进制数据
    //    设置基本的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/xml",@"text/plain",@"application/javascript",@"application/json",@"text/json",nil];
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (result) {
            NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            result(dict,nil,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (result) {
            result(nil,error,nil);
        }
    }];
}
//网络监听
- (void)Networkresult:(NetworkBlock)result
{
    //创建网络监测管理器对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //设置网络监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                //无网络
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSString *str = @"网络已断开";
                if (result) {
                    result(AFNetworkReachabilityStatusNotReachable);
                }
            } break;
                
                //有网络 WIFI
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSString *str = @"正在使用WIFI";
                if (result) {
                    result(AFNetworkReachabilityStatusReachableViaWiFi);
                }
            }
                break;
                
                //有网络 流量
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                
                NSString *str = @"正在使用流量";
                if (result) {
                    result(AFNetworkReachabilityStatusReachableViaWWAN);
                }
            } break;
                
                //未知网络
            case AFNetworkReachabilityStatusUnknown:
            {
                NSString *str = @"未知网络";
                if (result) {
                    result(str);
                }
            } break;
                
            default:
                break;
        }
        
    }];
    
    //开启监听
    [manager startMonitoring];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    NSLog(@"jiangting:%@",[object valueForKey:keyPath]);
}





@end








