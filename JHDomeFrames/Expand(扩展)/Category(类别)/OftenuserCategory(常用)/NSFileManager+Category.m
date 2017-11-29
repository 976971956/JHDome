//
//  NSFileManager+Category.m
//  TuiJI
//
//  Created by ddapp on 17/5/5.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "NSFileManager+Category.h"

@implementation NSFileManager (Category)
/**
 创建目录
 
 @param directoryPath 沙盒地址
 @param dirName 创建目录的名称
 */
-(NSString *)Createdirectory:(NSString *)directoryPath directory:(NSString *)dirName
{
    //创建语音聊天目录
    BOOL ret = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@%@",directoryPath,dirName]];
    if (ret) {
        NSLog(@"目录已经存在");
    }else{
        ret =  [[NSFileManager defaultManager] createDirectoryAtPath:[NSTemporaryDirectory() stringByAppendingString:dirName] withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"目录%@",ret?@"创建成功":@"创建失败");
    }
    return [NSString stringWithFormat:@"%@%@",directoryPath,dirName];
    
}
-(void)deletefile:(NSString *)path name:(NSString *)pathname
{
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *obj in array) {
        if ([obj isEqualToString:pathname]) {
            BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@",path,pathname] error:nil];
            NSLog(@"文件%@",ret?@"删除成功":@"删除失败");
        }
    }

}
+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
    //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1000.0/1000.0;
        return folderSize;
    }
    return 0;
}
+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1000.0/1000.0;
    }
    return 0;
}
+ (NSInteger)fileSize:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:path isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:path];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:path error:nil][NSFileSize] integerValue];
    }
}

@end
