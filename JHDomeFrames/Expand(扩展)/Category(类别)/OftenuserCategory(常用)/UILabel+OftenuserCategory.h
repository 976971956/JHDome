//
//  UILabel+OftenuserCategory.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (OftenuserCategory)

/**
 *  快速创建Label的圆角和边框
 *
 *  @param radius      圆角大小
 *  @param isMasks     是否剪除圆角部分
 *  @param width       边框宽度
 *  @param borderColor 边框颜色
 *
 */
-(void)sharedLabelWith:(CGFloat)radius AndIsMasksToBounds:(BOOL)isMasks borderWidth:(CGFloat)width andBackgroundColor:(UIColor *)borderColor;

@end
