//
//  JHAnimation.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/22.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "JHAnimation.h"

@implementation JHAnimation


//官方提供的四种动画效果
//fade = 1,                   //淡入淡出
//push,                       //推挤
//reveal,                     //揭开
//moveIn,                     //覆盖
//
//私有动画是在UIView的基础上，设置animation.type
//cube,                       //立方体
//suckEffect,                 //吮吸
//oglFlip,                    //翻转
//rippleEffect,               //波纹
//pageCurl,                   //翻页
//pageUnCurl,                 //反翻页
//cameraIrisHollowOpen,       //开镜头
//cameraIrisHollowClose,      //关镜头
//
//下面这个几个用在UIView的setAnimationTransition方法中
//UIViewAnimationTransitionCurlDown, //下翻页
//UIViewAnimationTransitionCurlUp,   //上翻页
//UIViewAnimationTransitionFlipFromLeft,  //左翻转
//UIViewAnimationTransitionFlipFromRight, //右翻转

+(CATransition *)zhuangchanganimation
{
    NSString *subtype = kCATransitionFromRight;
    
    // 1. 创建CATransition
    CATransition *transition = [CATransition animation];
    
    // 2. 设置动画类型
    transition.type = @"cube";
    
    // 3. 辅助动画（上左下右）
    transition.subtype = subtype;
    
    // 4. 动画持续时间
    transition.duration = 1;
    return transition;
}
//点赞动画
+(CABasicAnimation *)dianzhangAnimation
{
    // 关键帧动画，仿射变换缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.duration = 0.3;
    
    // x, y, z
    animation.toValue = @[@(2.0), @(2.0), @(1.0)];
    return animation;
}
@end
