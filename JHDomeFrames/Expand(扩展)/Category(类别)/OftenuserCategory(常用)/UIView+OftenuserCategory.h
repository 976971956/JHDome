//
//  UIView+OftenuserCategory.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (OftenuserCategory)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
/**
 *  快速创建View的圆角和边框
 *
 *  @param radius      圆角大小
 *  @param isMasks     是否剪除圆角部分
 *  @param width       边框宽度
 *  @param borderColor 边框颜色
 *
 */
-(void)sharedViewWith:(CGFloat)radius AndIsMasksToBounds:(BOOL)isMasks borderWidth:(CGFloat)width andBackgroundColor:(UIColor *)borderColor;

/**
 小提示框

 @param view 传入view
 @param infoStr 要显示的文字
 */
+ (void)showResultOnView:(UIView *)view ShowInfoStr:(NSString *)infoStr;

/**
 弹出框动画

 @param aview 传入需要弹出框的view
 */
-(void)shakeToshow:(UIView *)aview;
-(void)shakeToshowMax:(UIView *)aview;
//lablebutton字体模糊
-(void)solveUIWidgetFuzzy:(UIView *)view;
//毛玻璃
+(void)setviewfuzzymaoboli:(UIView *)view type:(NSInteger)type;

/**
 添加阴影效果
 
 @param sizex 阴影偏移x
 @param sizey 阴影偏移y
 @param radius 阴影的圆角
 */
-(void)addyinyinxiaoguo:(CGFloat)sizex sizey:(CGFloat)sizey radius:(NSInteger)radius;
/**
 *   按钮画四方圆角
 *
 *  @param button            需要圆角按钮
 *  @param topLeftCorner     上左圆角
 *  @param topRightCorner    上右圆角
 *  @param bottomLeftCorner  下左圆角
 *  @param bottomRightCorner 下右圆角
 */
- (void)drawingCornerInButton:(UIView *)button TopLeftCorner:(BOOL)topLeftCorner TopRightCorner:(BOOL)topRightCorner BottomLeftCorner:(BOOL)bottomLeftCorner BottomRightCorner:(BOOL)bottomRightCorner ANDsize:(CGSize)size;

/**
 view跳转控制器

 @return 父控制器
 */
-(UIViewController *)viewController;
@end
