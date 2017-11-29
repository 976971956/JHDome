//
//  NSFileManager+Category.h
//  TuiJI
//
//  Created by ddapp on 17/5/5.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Category)
/**
 创建目录
 
 @param directoryPath 沙盒地址
 @param dirName 创建目录的名称
 */
-(NSString *)Createdirectory:(NSString *)directoryPath directory:(NSString *)dirName;

/**
删除文件

 @param path 目录路径
 @param pathname /文件名
 */
-(void)deletefile:(NSString *)path name:(NSString *)pathname;

/**
 清理缓存

 @param path 缓存路经
 */
+(void)clearCache:(NSString *)path;
/**
 计算目录大小

 @param path 目录地址
 @return M
 */
+(float)folderSizeAtPath:(NSString *)path;

/**
 目录文件大小

 @param path 路径
 @return 大小
 */
+ (NSInteger)fileSize:(NSString *)path;

@end
