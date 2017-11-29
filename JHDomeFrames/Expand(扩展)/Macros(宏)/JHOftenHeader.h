//
//  JHOftenHeader.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#ifndef JHOftenHeader_h
#define JHOftenHeader_h


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//-------------------获取设备大小-------------------------


//-------------------打印日志-------------------------
//DEBUG 模式下打印日志,当前行
/**
 *  log用法2
 */
/**
 *  工程全局环境控制
 *
 *  0:开发环境  1:发布环境  2:测试环境
 */
#define MY_PROJECT_GLOBAL_CONTROL 0
#if (MY_PROJECT_GLOBAL_CONTROL == 0)
#define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DeBugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NSLog(...) NSLog(__VA_ARGS__);
#define MyNSLog(FORMAT, ...) fprintf(stderr,"[%s]:[line %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#elif (MY_PROJECT_GLOBAL_CONTROL == 1)
#define DLog(...)
#define DeBugLog(...)
#define NSLog(...)
#define MyNSLog(FORMAT, ...)
#endif




//----------------------系统----------------------------

// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 是否iPad
#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone

//获取系统版本
#define IOS_VERSION ［[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ［UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), ［UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), ［UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断设备的操做系统是不是ios7
#define IOS7 (［[UIDevice currentDevice].systemVersion doubleValue] >= 7.0]

//判断当前设备是不是iphone5
#define kScreenIphone5 ((［UIScreen mainScreen] bounds].size.height)>=568)

//获取当前屏幕的高度
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)

//获取当前屏幕的宽度
#define kMainScreenWidth ([UIScreen mainScreen].applicationFrame.size.width)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//检查系统版本
// =
#define SYSTEM_VERSION_EQUAL_TO(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
// >
#define SYSTEM_VERSION_GREATER_THAN(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
// >||=
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
// <
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
// <||=
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//----------------------内存----------------------------

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil



//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer］

//建议使用前两种宏定义,性能高于后者



//----------------------颜色转换类---------------------------------------------------------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//----------------------------------------------------------------------------------------------------------
#define CLEAR_COLOR [UIColor clearColor]//无色
#define RED_COLOR [UIColor redColor]//红
#define BLUE_COLOR [UIColor blueColor]//蓝
#define BLACK_COLOR [UIColor blackColor]//黑
#define WHITE_COLOR [UIColor whiteColor]//白
#define GRAY_COLOR [UIColor grayColor]//灰
//----------------------推己默认颜色类-----------------------------------------------------------------------------

#define TABBAR_W_NOM_COLOR UIColorFromRGB(0xfafafa)//白色主题底部tabbar默认的颜色
#define TABBAR_W_SEL_COLOR UIColorFromRGB(0xe6e6e6)//白色主题底部tabbar选中颜色
#define TABBAR_W_LINE UIColorFromRGB(0xB3B3B3)//导航栏白色主题线条灰

#define TABBAR_B_NOM_COLOR UIColorFromRGB(0x252e4b)//蓝色主题底部babar默认的颜色
#define TABBAR_B_SEL_COLOR UIColorFromRGB(0x1a2135)//蓝色主题底部babar选中的颜色

#define LINECOLOR  UIColorFromRGB(0xcccccc)//默认线条灰

#define kWhite UIColorFromRGB(0xffffff)//白
#define kBlack UIColorFromRGB(0x000000)//黑

#define BACKGROUND_COLOR UIColorFromRGB(0xfafafa)//背景色

#define TITLEGRARD_COLOR UIColorFromRGB(0xcccccc)//文字灰色

#define BLUE_BTN_NOM_COLOR UIColorFromRGB(0x5079BF)//蓝色按钮默认颜色
#define BLUE_BTN_SEL_COLOR UIColorFromRGB(0x4669a6)//蓝色按钮点击颜色

#define RED_BTN_NOM_COLOR UIColorFromRGB(0xE64240)//红色按钮默认颜色
#define RED_BTN_SEL_COLOR UIColorFromRGB(0xEE7B7A)//红色按钮点击颜色

#define BOD_LINE_COLOR UIColorFromRGB(0x22639E)//边框线条默认点击颜色
#define BOD_SEL_COLOR UIColorFromRGB(0xe5e5e5)//边框点击状态颜色.默认ffffff

#define RED_DIAN_COLOR UIColorFromRGB(0xf43530)//红色小点颜色

#define BLUE_TITLE_SEL_COLOR UIColorFromRGB(0xb1ddff)//蓝色字体灰色
#define BLUE_TITLE_NOM_COLOR UIColorFromRGB(0x0088E3)//蓝色字体默认

#define BLACK_TITLE_SEL_COLOR LINECOLOR//黑色字体灰色
#define BLACK_TITLE_NOM_COLOR kBlack//黑色字体默认
#define TITLE_PINGLUN_NAME_COLOR UIColorFromRGB(0x005cb3)
//-----------------------------------字体大小------------------------------------------------
//字体
#define MORENFONT [UIFont fontWithName:@"STXihei" size:20]
#define MORENFONTSIZE(FONTSIZE) [UIFont fontWithName:@"STXihei" size:FONTSIZE]

#define KFont10 MORENFONTSIZE(10)
#define KFont11 MORENFONTSIZE(11)
#define KFont12 MORENFONTSIZE(12)
#define KFont13 MORENFONTSIZE(13)
#define KFont14 MORENFONTSIZE(14)
#define KFont15 MORENFONTSIZE(15)
#define KFont16 MORENFONTSIZE(16)
#define KFont17 MORENFONTSIZE(17)
#define KFont18 MORENFONTSIZE(18)
#define KFont19 MORENFONTSIZE(19)
#define KFont20 MORENFONTSIZE(20)
#define KFont10_5 MORENFONTSIZE(10.5)
#define KFont11_5 MORENFONTSIZE(11.5)
#define KFont12_5 MORENFONTSIZE(12.5)
#define KFont13_5 MORENFONTSIZE(13.5)
#define KFont14_5 MORENFONTSIZE(14.5)
#define KFont15_5 MORENFONTSIZE(15.5)
#define KFont16_5 MORENFONTSIZE(16.5)
#define KFont17_5 MORENFONTSIZE(17.5)
#define KFont18_5 MORENFONTSIZE(18.5)
#define KFont19_5 MORENFONTSIZE(19.5)
#define KFont20_5 MORENFONTSIZE(20.5)

#define EMOJIFONT 30//表情大小
//-------------------------------账号相关---------------------------------------------------------
//注册云信appid
#define NIMAPPID @"ac6eccef8da70e8df0e590297791a920"
//百度翻译
#define BAIDUAPPID @"20170118000036169"//百度appid
#define BAIDUKEY @"rGiYG7axSIpbDb97Kh1S"//百度key

//高德地图APIKEY
#define AMAPAPIKEY @"7d96de222e7cd784afb697d55fd0ada3"
//-------------------------------推己默认相关---------------------------------------------------------
//推己默认图片占位符
#define ZHANWEIIMAGER @"TUIJIEHAO"
#define LINEWEIGHT 0.5//全局线宽
#define YINGYING 10//全局阴影
//------------------------------应用功能相关-------------------------------------------------------
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]//NSUserDefaults 沙盒实例化
#define NOTI_DEFAULT [NSNotificationCenter defaultCenter]//通知实例化

//是否是好友
#define ISMYFREND(USERID) [ToolManage ismyfrend:USERID]
//是自己
#define ISME(FRENDID) [USER_USERID isEqualToString:FRENDID]
//云信用户登录账号

//登录账号的用户信息
#define NIMUSERINFO [[NIMSDK sharedSDK].userManager userInfo:USER_USERID]

//压缩图片地址
#define YASUOIMGPATH(STR) [NSString stringWithFormat:@"%@?imageslim",STR]

//主题颜色声音震动
#define ISWHITE [[NSUserDefaults standardUserDefaults] boolForKey:ZHUTICOLOR]
#define ZHUTICOLOR @"iswight"//主题颜色

#define SHENGYIKAIGUANG @"isvoice"//声音开关
#define ZHENDONGKAIGUANG @"isvabratioon"//震动开关

#define FATUIWENPARM @"FATUIWENPARM"//发推文参数


//-------------------------------记录的登录信息------------------------------------------------------
//云信ID（用于云信登录的 token
#define NIM_IDTOKEN @"NIM_IDTOKEN"
//用户id
#define NIM_USERID @"NIM_USERID"
//	接口调用凭证
#define NIM_access_token @"NIM_access_token"
//	用户刷新 access_token
#define NIM_refresh_token @"refresh_token"
//access_token 接口调用凭证超时时间，单位（秒）
#define NIM_expires_in @"expires_in"
//是否为公众人物
#define UPUBLIC @"uPublic"

//用户刷新 access_token的值
#define USER_ACCESS_TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:NIM_access_token]
//用户id的值
#define USER_USERID [[NSUserDefaults standardUserDefaults] objectForKey:NIM_USERID]
//云信ID（用于云信登录的 token的值
#define USER_IDTOKEN [[NSUserDefaults standardUserDefaults] objectForKey:NIM_IDTOKEN]
//用户刷新 access_token的值
#define USER_REFRESH_TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:NIM_refresh_token]

//登录保存的账号密码
#define LOGINPHONE @"numphone"
#define LOGINPWD @"numpwd"
//用户头像
#define USERICON @"USERICON"
//用户扩展信息推文id
#define EXUSERTWEETID @"exusertweetid"
#define USER_EX_TWEETID [[NSUserDefaults standardUserDefaults] objectForKey:EXUSERTWEETID]
//用户扩展信息世界推文id
#define EXUSERWORDID @"exuserwordid"
#define USER_EX_WORDTWEETID [[NSUserDefaults standardUserDefaults] objectForKey:EXUSERWORDID]
//保存的关注着
#define USER_GUANGZHU @"userguangzhu"
//关注拿数据
#define USER_GUANGZHU_VALUE [[NSUserDefaults standardUserDefaults] objectForKey:USER_GUANGZHU]
#define USER_GUANGZHUWRITH_VALUE(ARR) [[NSUserDefaults standardUserDefaults] setObject:ARR forKey:USER_GUANGZHU];

//返回刷新宏
#define BACKREFRES @"deleteteam"

#define NSStringName(name1,name2) [NSString stringWithFormat:@"%@%@",name1,name2]
//方法类字符串拼接
#define NSStringCenS(CANS) [NSString stringWithFormat:@"%@%@",TJ_HOST,CANS]

//------------------------------------------------提示框----------------------------------------------------------------
#define ShowMessage(MESSAGE,QUVC) \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:MESSAGE preferredStyle:UIAlertControllerStyleAlert]; \
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]; \
[alertController addAction:okAction]; \
[QUVC presentViewController:alertController animated:YES completion:nil];
//错误提示框
#define ERRORShowMessage(MESSAGE,QUVC) \
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:MESSAGE preferredStyle:UIAlertControllerStyleAlert]; \
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]; \
[alertController addAction:okAction]; \
[QUVC presentViewController:alertController animated:YES completion:nil];
//----------------------------------------------------------------------------------------------------------------

//-------------------------------------通知--------------------------------------------------------------------
#define NSNOTIFICATION_TONGZI [NSNotificationCenter defaultCenter]

//-----
#define SEARCHATINFO @"SEARCHATINFO"
//收到推信消息
#define TUIXININFO @"TUIXININFO"
//自定义通知
#define CUSTOMSYSTEMNOTIFICATION @"GCCustomSystemNotification"
//广场被点赞
#define GCCUSTOM_GUANGCHANG_DIANZAN @"GCCUSTOM_GUANGCHANG_DIANZAN"
//广场被评论
#define GCCUSTOM_GUANGCHANG_PINLUN @"GCCUSTOM_GUANGCHANG_PINLUN"
//被关注
#define GCCUSTOM_BEI_GUANGZHU @"GCCUSTOM_BEI_GUANGZHU"
//被取消关注
#define GCCUSTOM_BEI_QUXIAOGUANGZHU @"GCCUSTOM_BEI_QUXIAOGUANGZHU"
//广场视频被播放
#define GCCUSTOM_GUANGCHANG_SHIPING_BOFANG @"GCCUSTOM_GUANGCHANG_SHIPING_BOFANG"

//++
//点赞
#define TUIJI_CUSTOM_DIANZAN @"TUIJI_CUSTOM_DIANZAN"
//收藏、
#define TUIJI_CUSTOM_SHOUCANG @"TUIJI_CUSTOM_SHOUCANG"
//评论
#define TUIJI_CUSTOM_PINGLUN @"TUIJI_CUSTOM_PINGLUN"
//转发
#define TUIJI_CUSTOM_ZHUANGFA @"TUIJI_CUSTOM_ZHUANGFA"
//有新推文
#define TUIJI_CUSTOM_NEWTUIWEN @"TUIJI_CUSTOM_NEWTUIWEN"
//视频被看
#define TUIJI_CUSTOM_VIDEOWATCH @"TUIJI_CUSTOM_VIDEOWATCH"
//被@好友
#define TUIJI_CUSTOM_BEIAIT @"TUIJI_CUSTOM_BEIAIT"
//-------------------------------------沙盒-------------------------------------------
//广场点赞数据
#define ISDIANZAN @"isdianzhang"
//新好友存储
#define CUSTOMUSER @"CustomUser"
//推己圈自定义消息
#define TUIJIQUANINFO @"TUIJIQUANINFO"
//广场自定义消息
#define GUANGCHANGINFO @"GUANGCHANGINFO"
//被关注
#define GERENBEIGUANGZHU @"GERENBEIGUANGZHU"
//保存的视屏播放数（推己圈）
#define TUIJIQUAN_VIDEO_NUM @"TUIJIQUAN_VIDEO_NUM"
//保存的视频播放数（广场）
#define GUANGCHANG_VIDEO_NUM @"GUANGCHANG_VIDEO_NUM"
//----------------------------------通知-------------------------------------------
#define CHANGEBEIZHU @"CHANGEBEIZHU"//通知修改备注
#endif /* JHOftenHeader_h */
