//
//  NSDate+extation.m
//  TuiJI
//
//  Created by ddapp on 17/4/12.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "NSDate+extation.h"

@implementation NSDate (extation)
+ (NSString *)timeStringWithTimeInterval:(NSTimeInterval)timeInterval
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //今天
    if ([date isToday]) {
        
        formatter.dateFormat = @"今天HH:mm";

        return [formatter stringFromDate:date];
        
    }else{
        
        //昨天
        if ([date isYesterday]) {
            
            formatter.dateFormat = @"昨天HH:mm";
            return [formatter stringFromDate:date];
            
            //一周内 [date weekdayStringFromDate]
        }else if ([date isSameWeek]){
            
            formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date weekdayStringFromDate],@"HH:mm"];
            return [formatter stringFromDate:date];
            
            //直接显示年月日
        }else{
            
            formatter.dateFormat = @"yyyy-MM-dd  HH:mm";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}
+ (NSString *)timeStringWithTimeIntervalUTC:(NSTimeInterval)timeInterval
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setTimeZone:sourceTimeZone];
    //今天
    if ([date isToday]) {
        
        formatter.dateFormat = @"今天HH:mm";
        
        return [formatter stringFromDate:date];
        
    }else{
        
        //昨天
        if ([date isYesterday]) {
            
            formatter.dateFormat = @"昨天HH:mm";
            return [formatter stringFromDate:date];
            
            //一周内 [date weekdayStringFromDate]
        }else if ([date isSameWeek]){
            
            formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date weekdayStringFromDate],@"HH:mm"];
            return [formatter stringFromDate:date];
            
            //直接显示年月日
        }else{
            
            formatter.dateFormat = @"yyyy-MM-dd  HH:mm";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}

+ (NSString *)timeStringWithTimeInterval1000:(NSTimeInterval)timeInterval
{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //今天
//    if ([date isToday]) {
//        
//        formatter.dateFormat = @"今天HH:mm";
//        
//        return [formatter stringFromDate:date];
//    }else{
//        
//        //昨天
//        if ([date isYesterday]) {
//            
//            formatter.dateFormat = @"昨天HH:mm";
//            return [formatter stringFromDate:date];
//            
//            //一周内 [date weekdayStringFromDate]
//        }else if ([date isSameWeek]){
//            
//            formatter.dateFormat = [NSString stringWithFormat:@"%@%@",[date weekdayStringFromDate],@"HH:mm"];
//            return [formatter stringFromDate:date];
//            
//            //直接显示年月日
//        }else{
    
            formatter.dateFormat = @"MM 月 dd 日 HH:mm";
            return [formatter stringFromDate:date];
//        }
//    }
    return nil;
}
//是否在同一周
- (BOOL)isSameWeek
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}
//根据日期求星期几
- (NSString *)weekdayStringFromDate{
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}
//是否为今天
- (BOOL)isToday
{
    //now: 2015-09-05 11:23:00
    //self 调用这个方法的对象本身
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

//是否为昨天
- (BOOL)isYesterday
{
    //2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    //2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    //获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}
/**
 * 计算两日期之间时间之差
 * date1<date2
 */
+(long) compareDate1:(NSTimeInterval )date1 withDate2:(NSTimeInterval)date2 type:(int)type
{
    NSDate *date11 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDate *date22 = [NSDate dateWithTimeIntervalSince1970:date2];
    
    NSTimeInterval  timeInterval = [date11 timeIntervalSinceDate:date22];
    timeInterval = -timeInterval;
    long result;
    switch (type) {
        case 1:
            result = (long)timeInterval;    //秒
            break;
        case 2:
            result = (long)timeInterval/60;    //分
            break;
        case 3:
            result = (long)timeInterval/60/60;    //时
            break;
        case 4:
            result = (long)timeInterval/60/60/24;    //天
            break;
        case 5:
            result = (long)timeInterval/60/60/24/30;    //月
            break;
        case 6:
            result = (long)timeInterval/60/60/24/365;    //年
            break;
        case 7:
            result = (long)timeInterval/60/60/24/7;    //周
            break;
        default:
            break;
    }
    return result;
}

//格式化
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
+(NSString *)dateToString:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@", strDate);
    return strDate;
}
+(NSDate *)stringToDate:(NSString *)string format:(NSString *)format
{
    if (format==nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}
+(NSString *)getnewdate
{
    NSDate *senddate = [NSDate date];
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *date1 = [dateformatter stringFromDate:senddate];
    NSString *date1 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];

    return date1;
}
//格式化获取当前时间搓
+(NSString *)getnewdategeshi:(NSString *)geshi
{
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:geshi];
    NSString *date1 = [dateformatter stringFromDate:senddate];
    return date1;
}
@end
