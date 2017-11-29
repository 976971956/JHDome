//
//  ShowManage.h
//  TuiJI
//
//  Created by ddapp on 17/5/2.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^showmaga1)(void);
typedef void(^showmaga2)(void);


@interface ShowManage : NSObject

/**
 actionsheet类型的提示框

 @param cotroll 控制器
 @param showtitle 设置标题
 @param show 返回事件
 */
+(void)showActionSheetcotroll:(UIViewController *)cotroll showtitle:(NSString *)showtitle andsheetAction:(showmaga1)show;
//带举报的sheet
+(void)showActionSheetcotroll_JUBAO:(UIViewController *)cotroll showtitle:(NSString *)showtitle and_JB_title:(NSString *)jb_title andsheetAction:(showmaga1)show andsheetAction1:(showmaga2)show1;
/**
 自定义sheet
 
 @param cotroll 控制器
 @param showtitle 标题
 @param nameimg 图片名
 @param title 图片标题
 @param show 事件1
 @param show2 事件2
 */
+(void)cusrmshowActionSheetcotroll:(UIViewController *)cotroll showtitle:(NSString *)showtitle andimg:(UIImage *)nameimg andtitlename:(NSString *)title andsheetAction:(showmaga1)show censer:(showmaga2)show2;

/**
 个人编辑删除sheet

 @param cotroll 控制器
 @param deletetitle 标题1
 @param edittitle 标题2
 @param show 回调1
 @param show1 回调2
 */
+(void)showActionSheetcotrollMe:(UIViewController *)cotroll deletetitle:(NSString *)deletetitle edittitle:(NSString *)edittitle andsheetAction:(showmaga1)show  sheetActionedit:(showmaga2)show1;

/**
 提示框只有确定

 @param show 确定事件
 @param cotroll 控制器
 @param title 标题
 @param message 内容
 */
+(void)showManage:(showmaga1)show orcontroll:(UIViewController *)cotroll title:(NSString *)title message:(NSString *)message;

/**
 提示框

 @param show1 确定回调事件
 @param show2 取消回调事件
 @param cotroll 控制器
 @param title 标题
 @param message 内容
 */
+(void)showManageshow1:(showmaga1)show1 andshow2:(showmaga2)show2 orcontroll:(UIViewController *)cotroll title:(NSString *)title message:(NSString *)message;



@end
