//
//  UIImageView+OftenuserCategory.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (OftenuserCategory)

/**
 *  快速创建ImageView的圆角和边框
 *
 *  @param radius      圆角大小
 *  @param isMasks     是否剪除圆角部分
 *  @param width       边框宽度
 *  @param borderColor 边框颜色
 *
 */
-(void)sharedImageViewWith:(CGFloat)radius AndIsMasksToBounds:(BOOL)isMasks borderWidth:(CGFloat)width andBackgroundColor:(UIColor *)borderColor;

/**
 获取网络图片大小

 @param urls 传入图片地址
 @return 图片大小
 */
+(CGSize)imagurlsize:(NSString *)urls;
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;

//判断是否有缓存
+(BOOL)SDWebimghuancunUrl:(NSString *)urlstr;
//有缓存调用获取缓存图片的高度比例
+(CGFloat)SDWebimghuancunbili:(NSString *)usrstr;
//获取图片比例
+(CGFloat)getimgAuto:(id)imageurl;

+ (CGSize)getImageSizeWithURL1:(id)URL;

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
@end
