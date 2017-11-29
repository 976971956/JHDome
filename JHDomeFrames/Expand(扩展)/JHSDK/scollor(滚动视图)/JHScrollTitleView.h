//
//  JHScrollTitleView.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/18.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)(NSInteger pageIndex);

@interface JHScrollTitleView : UIView

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)UIImageView *bgimage;

/**
 创建头部按钮

 @param frame 设置frame
 @param titles 按钮标题
 @param norcolor 按钮默认文字颜色
 @param selcolor 按钮点击文字颜色
 @param topline 头部下方线条颜色
 @param bgimagcolor 设置背景颜色
 @param images 设置背景图片
 @param block 回调
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleNorColor:(UIColor *)norcolor titleseColor:(UIColor *)selcolor topLine:(UIColor *)topline bgImagesColor:(UIColor *)bgimagcolor orImages:(UIImage *)images callBack:(CallBack)block;
/**
 选择对应的按钮
 */
- (void)selectButtonIndex:(NSInteger)index;

/**
 设置底部线条的实时偏移量
 */
- (void)moveTopViewLine:(CGPoint)point;

@end
