//
//  UIButton+OftenuserCategory.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIButton (OftenuserCategory)

/**
 *  快速创建Button的圆角和边框
 *
 *  @param radius      圆角大小
 *  @param isMasks     是否剪除圆角部分
 *  @param width       边框宽度
 *  @param borderColor 边框颜色
 *
 */
-(void)sharedButtonWith:(CGFloat)radius AndIsMasksToBounds:(BOOL)isMasks borderWidth:(CGFloat)width andBackgroundColor:(UIColor *)borderColor;
/**
 button中的小图标
 
 @param bigweight 外部宽
 @param bigheight 外部高
 @param simweight 内部宽
 @param simheight 内部高
 @param imgstr    图标
 */
-(void)addBTNFramebigweight:(CGFloat)bigweight bigheight:(CGFloat)bigheight simweight:(CGFloat)simweight simheight:(CGFloat)simheight imager:(NSString *)imgstr;

/**
 button加载网络图片

 @param urlStr url地址
 */
- (void)jh_setButtonImageWithUrl:(NSString *)urlStr;
@end
