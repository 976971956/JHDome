//
//  UIView+OftenuserCategory.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import "UIView+OftenuserCategory.h"

@implementation UIView (OftenuserCategory)

-(void)sharedViewWith:(CGFloat)radius AndIsMasksToBounds:(BOOL)isMasks borderWidth:(CGFloat)width andBackgroundColor:(UIColor *)borderColor{
    
    if (radius) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = isMasks;
    }
    if (width) {
        self.layer.borderWidth = width;
    }
    if (self) {
        self.layer.borderColor = borderColor.CGColor;
    }
}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
//弹框动画
-(void)shakeToshow:(UIView *)aview
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1,0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2,1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9,0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0, 1.0)]];
    animation.values = values;
    [aview.layer addAnimation:animation forKey:nil];
}
//弹框动画
-(void)shakeToshowMax:(UIView *)aview
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7,0.7, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0, 1.0)]];
//  [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9,0.9, 1.0)]];
//  [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,1.0, 1.0)]];
    animation.values = values;
    [aview.layer addAnimation:animation forKey:nil];
}
//lablebutton字体模糊
-(void)solveUIWidgetFuzzy:(UIView *)view
{
    CGRect frame = view.frame;
    int x = floor(frame.origin.x);
    int y = floor(frame.origin.y);
    int w = floor(frame.size.width)+1;
    int h = floor(frame.size.height)+1;
    
    view.frame = CGRectMake(x, y, w, h);
}
//毛玻璃
+(void)setviewfuzzymaoboli:(UIView *)view type:(NSInteger)type
{
    switch (type) {
        case 0:
        {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            effectview.frame = [UIScreen mainScreen].bounds;
            [view addSubview:effectview];
        }
            break;
        case 1:
        {
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:[UIScreen mainScreen].bounds];
            toolbar.barStyle = UIBarStyleBlackTranslucent;
            [view addSubview:toolbar];
        }
            break;
        case 2:
        {
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *ev = [[UIVisualEffectView alloc] initWithEffect:blur];
            ev.frame = view.frame;
            [view addSubview:ev];
        }
            break;
  
        default:
            break;
    }
}

/**
 添加阴影效果

 @param sizex 阴影偏移x
 @param sizey 阴影偏移y
 @param radius 阴影的圆角
 */
-(void)addyinyinxiaoguo:(CGFloat)sizex sizey:(CGFloat)sizey radius:(NSInteger)radius
{
    
    self.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    //阴影的透明度
    self.layer.shadowOpacity=0.2;
    self.layer.shadowRadius=radius;//设置阴影的圆角

    self.layer.shadowOffset=CGSizeMake(sizex, sizey);//设置阴影的偏移量

}
+ (void)showResultOnView:(UIView *)view ShowInfoStr:(NSString *)infoStr
{
    
    CGSize showLabelBaseSize = CGSizeMake(SCREEN_WIDTH, MAXFLOAT);
    NSDictionary * showLabelDict = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize showLabelSize = [infoStr boundingRectWithSize:showLabelBaseSize options:NSStringDrawingUsesLineFragmentOrigin attributes:showLabelDict context:nil].size;
    
    //ShowView
    UIView * showView = [[UIView alloc]init];
    [view addSubview:showView];
    showView.backgroundColor = [UIColor blackColor];
    showView.alpha = 0;
    showView.layer.cornerRadius = 4;
    showView.layer.masksToBounds = YES;
    [UIView animateWithDuration:1 animations:^{
        showView.alpha = 0.8;
    }];
    [showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(showLabelSize.width + 25);
        make.height.mas_equalTo(showLabelSize.height + 15);
        make.centerX.equalTo(view);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-60);
        
    }];
    
    //ShowLabel
    UILabel * showLabel = [[UILabel alloc]init];
    [showView addSubview:showLabel];
    showLabel.textColor = [UIColor whiteColor];
    showLabel.font = [UIFont systemFontOfSize:10];
    
    //        NSLog(@"%@",resultInfo);
    showLabel.text = infoStr;
    
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(showView);
        make.centerY.mas_equalTo(showView);
        make.width.mas_equalTo(showLabelSize.width);
        make.height.mas_equalTo(showLabelSize.height);
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            showView.alpha = 0;
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [showView removeFromSuperview];
            
        });
    });
}

/**
 *   按钮画四方圆角
 *
 *  @param button            需要圆角按钮
 *  @param topLeftCorner     上左圆角
 *  @param topRightCorner    上右圆角
 *  @param bottomLeftCorner  下左圆角
 *  @param bottomRightCorner 下右圆角
 */
- (void)drawingCornerInButton:(UIView *)button TopLeftCorner:(BOOL)topLeftCorner TopRightCorner:(BOOL)topRightCorner BottomLeftCorner:(BOOL)bottomLeftCorner BottomRightCorner:(BOOL)bottomRightCorner ANDsize:(CGSize)size
{
    UIRectCorner corners;
    
    // 一个圆角
    if (topLeftCorner && !topRightCorner && !bottomLeftCorner && !bottomRightCorner) {
        // topLeftCorner
        corners = UIRectCornerTopLeft;
    }
    if (!topLeftCorner && topRightCorner && !bottomLeftCorner && !bottomRightCorner) {
        // topRightCorner
        corners = UIRectCornerTopRight;
    }
    if (!topLeftCorner && !topRightCorner && bottomLeftCorner && !bottomRightCorner) {
        // bottomLeftCorner
        corners = UIRectCornerBottomLeft;
    }
    if (!topLeftCorner && !topRightCorner && !bottomLeftCorner && bottomRightCorner) {
        // bottomRightCorner
        corners = UIRectCornerBottomRight;
    }
    
    //  两个圆角
    //1
    if (topLeftCorner && topRightCorner && !bottomLeftCorner && !bottomRightCorner) {
        // topLeftCorner  topRightCorner
        corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    }
    if (topLeftCorner && !topRightCorner && bottomLeftCorner && !bottomRightCorner) {
        // topLeftCorner  bottomLeftCorner
        corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    }
    if (topLeftCorner && !topRightCorner && !bottomLeftCorner && bottomRightCorner) {
        // topLeftCorner  bottomRightCorner
        corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
    }
    
    //2
    if (!topLeftCorner && topRightCorner && bottomLeftCorner && !bottomRightCorner) {
        // topRightCorner  bottomLeftCorner
        corners = UIRectCornerTopRight | UIRectCornerBottomLeft;
    }
    
    if (!topLeftCorner && topRightCorner && !bottomLeftCorner && bottomRightCorner) {
        // topRightCorner  bottomRightCorner
        corners = UIRectCornerTopRight | UIRectCornerBottomRight;
    }
    
    //3
    if (!topLeftCorner && !topRightCorner && bottomLeftCorner && bottomRightCorner) {
        // bottomLeftCorner  bottomRightCorner
        corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    
    // 三个圆角
    //1
    if (!topLeftCorner && topRightCorner && bottomLeftCorner && bottomRightCorner) {
        //  topRightCorner bottomLeftCorner bottomRightCorner
        corners = UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    //2
    if (topLeftCorner && !topRightCorner && bottomLeftCorner && bottomRightCorner) {
        // topLeftCorner  bottomLeftCorner bottomRightCorner
        corners = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    //3
    if (topLeftCorner && topRightCorner && !bottomLeftCorner && bottomRightCorner) {
        // topLeftCorner topRightCorner bottomRightCorner
        corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
    }
    //4
    if (topLeftCorner && topRightCorner && bottomLeftCorner && !bottomRightCorner) {
        // topLeftCorner topRightCorner bottomLeftCorner
        corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft;
    }
    
    // 四个圆角
    if (topLeftCorner && topRightCorner && bottomLeftCorner && bottomRightCorner) {
        // topLeftCorner topRightCorner bottomLeftCorner bottomRightCorner
        corners = UIRectCornerAllCorners;
    }
    
    // 没有圆角
    if (!topLeftCorner && !topRightCorner && !bottomLeftCorner && !bottomRightCorner) {
        return;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = button.bounds;
    maskLayer.path          = maskPath.CGPath;
    button.layer.mask         = maskLayer;
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

@end
