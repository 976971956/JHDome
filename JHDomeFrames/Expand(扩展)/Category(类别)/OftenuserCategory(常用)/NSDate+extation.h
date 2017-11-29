//
//  NSDate+extation.h
//  TuiJI
//
//  Created by ddapp on 17/4/12.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (extation)
//是否为今天
- (BOOL)isToday;
//是否为昨天
- (BOOL)isYesterday;
//是否在同一周
- (BOOL)isSameWeek;
/**
 将时间转化语言式格式

 @param timeInterval 时间搓
 @return 带格式的字符串
 */
+ (NSString *)timeStringWithTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)timeStringWithTimeInterval1000:(NSTimeInterval)timeInterval;
+ (NSString *)timeStringWithTimeIntervalUTC:(NSTimeInterval)timeInterval;

/**
 将对比两个时间搓相差的时间间隔

 @param date1 时间1
 @param date2 时间2
 @param type 1秒 2分 3时 4天 5月 6年
 @return 相差的时间值
 */
+(long) compareDate1:(NSTimeInterval )date1 withDate2:(NSTimeInterval)date2 type:(int)type;

/**
 date转字符串

 @param date date
 @param format 格式
 @return 字符串
 */
+(NSString *)dateToString:(NSDate *)date format:(NSString *)format;
/**
 字符串转nsdate

 @param string 字符串
 @param format 格式
 @return date
 */
+(NSDate *)stringToDate:(NSString *)string format:(NSString *)format;
//获取当前时间
+(NSString *)getnewdate;
+(NSString *)getnewdategeshi:(NSString *)geshi;

@end
