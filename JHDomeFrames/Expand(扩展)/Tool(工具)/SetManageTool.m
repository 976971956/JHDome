//  系统设置权限管理类
//  SetManageTool.m
//  TuiJI
//
//  Created by ddapp on 17/7/14.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "SetManageTool.h"

@implementation SetManageTool
//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
+(BOOL)canRecordcotroller:(id)cotroller
{
    __block BOOL bCanRecord = YES;
    //    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    //    {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            }
            else {
                bCanRecord = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ShowManage showManageshow1:^{
                        [self gotoSetingurl:@"prefs:root=Privacy"];
                    } andshow2:^{
                        
                    } orcontroll:cotroller title:@"麦克风权限" message:@"APP需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                });
            }
        }];
    }
    //    }
    return bCanRecord;
}
-(void)gotoWIFI
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];  //跳转 wifi列表页面
}
-(void)gotoAbout
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=About"]];  //跳转 关于
}
+(void)gotoyingshi
{
//    [[[UIDevice currentDevice] systemVersion] compare:10.0 options:NSNumericSearch] == NSOrderedAscending;
    if (SYSTEM_VERSION_LESS_THAN(@"10")) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"]];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Privacy"] options:@{} completionHandler:nil];
    }

}
//只要给出对应的URL，系统就可以直接跳：
////拨打电话
//[NSURL URLWithString:@"tel://123456"]
////发送短信
//[NSURL URLWithString:@"sms://123456"]
////发邮件
//[NSURL URLWithString:@"mailto://123456@163.com"]
////前往App Store
//[NSURL URLWithString:@"itms-apps://"]
////使用Safari访问网址
//[NSURL URLWithString:@"http://www.baidu.com"]
////前往iBook
//[NSURL URLWithString:@"itms-books://"]
////发起Facetime
//[NSURL URLWithString:@"facetime://"]
////8、调用 地图Map
//[NSURL URLWithString:@"maps://"]
////9、调用 Music
//[NSURL URLWithString:@"music://"]
////10、跳转到系统设置相关界面
//// iOS10 以前
//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION"] options:@{} completionHandler:nil];
//// iOS10 以后
//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=LOCATION"] options:@{} completionHandler:nil];
//
//#pragma mark - 以下为跳转设置的对应方式
////设置
//[NSURL URLWithString:UIApplicationOpenSettingsURLString]
//
////iCloud
//[NSURL URLWithString:@"App-Prefs:root=CASTLE"]
//
////WIFI
//[NSURL URLWithString:@"App-Prefs:root=WIFI"]
//
////蓝牙
//[NSURL URLWithString:@"App-Prefs:root=Bluetooth"]
//
////蜂窝数据
//[NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"]
//
////通知
//[NSURL URLWithString:@"App-Prefs:root=NOTIFICATIONS_ID"]
//
////通用
//[NSURL URLWithString:@"App-Prefs:root=General"]
////关于手机
//[NSURL URLWithString:@"App-Prefs:root=General&path=About"]
////辅助功能
//[NSURL URLWithString:@"App-Prefs:root=General&path=ACCESSIBILITY"]
////日期与时间
//[NSURL URLWithString:@"App-Prefs:root=General&path=DATE_AND_TIME"]
////键盘设置
//[NSURL URLWithString:@"App-Prefs:root=General&path=Keyboard"]
//
////显示与亮度
//[NSURL URLWithString:@"App-Prefs:root=DISPLAY"]
//
////墙纸设置
//[NSURL URLWithString:@"App-Prefs:root=Wallpaper"]
//
////声音
//[NSURL URLWithString:@"App-Prefs:root=Sounds"]
//
////Siri
//[NSURL URLWithString:@"App-Prefs:root=Siri"]
//
////隐私
//[NSURL URLWithString:@"App-Prefs:root=Privacy"]
////定位
//[NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"]
//
////电池电量
//[NSURL URLWithString:@"App-Prefs:root=BATTERY_USAGE"]
//
////iTunes Store 与 App Store
//[NSURL URLWithString:@"App-Prefs:root=STORE"]
//传入指定字符串进行跳转
+(void)gotoSetingurl:(NSString *)url
{
    if (SYSTEM_VERSION_LESS_THAN(@"10")) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"App-%@",url]] options:@{} completionHandler:nil];
    }
}
@end
