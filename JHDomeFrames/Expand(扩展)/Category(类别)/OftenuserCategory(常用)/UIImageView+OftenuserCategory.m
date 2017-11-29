//
//  UIImageView+OftenuserCategory.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/17.
//  Copyright © 2017年 王志威. All rights reserved.
//

#import "UIImageView+OftenuserCategory.h"
#import <ImageIO/ImageIO.h>
@implementation UIImageView (OftenuserCategory)

-(void)sharedImageViewWith:(CGFloat)radius AndIsMasksToBounds:(BOOL)isMasks borderWidth:(CGFloat)width andBackgroundColor:(UIColor *)borderColor{
    
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
+(CGSize)imagurlsize:(NSString *)urls{
    //获取到图片的大小按比例调整
    __block CGFloat itemW = 0;
    
    __block CGFloat itemH = 0;
    
    //        UIImageView * imageView = [[UIImageView alloc] init];
    
    NSURL * url = [NSURL URLWithString:urls];
    
    //    [self.imageImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"info_def_1114"]];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    BOOL existBool = [manager diskImageExistsForURL:url];//判断是否有缓存
    
    UIImage * image;
    
    if (existBool) {
        
        image = [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
        
    }else{
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        image = [UIImage imageWithData:data];
        
    }
    
    itemW = image.size.width;
    itemH = image.size.height;
    //根据image的比例来设置高度
    
//    if (image.size.width) {
//        
//        if (image.size.height>=image.size.width) {
//            
//            itemW = 148;
//            
//            itemH = image.size.height / image.size.width * itemW;
//            
//        }else{
//            itemW =200;
//            itemH = image.size.height / image.size.width * itemW;
//            
//        }
//    }
    return CGSizeMake(itemW, itemH);
}
// 添加所有的手势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        if (self.selimagview.frame.size.width < oldFrame.size.width) {
//            self.selimagview.frame = oldFrame;
//            //让图片无法缩得比原图小
//        }
//        if (self.selimagview.frame.size.width > 3 * oldFrame.size.width) {
//            self.selimagview.frame = largeFrame;
//        }
        pinchGestureRecognizer.scale = 1;
    }
}
// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}
//---------------------------------------------------------------------------------------
//判断是否有缓存
+(BOOL)SDWebimghuancunUrl:(NSString *)urlstr
{
    BOOL existBool = [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:urlstr]];//判断是否有缓存
    return existBool;
}
//有缓存调用获取缓存图片的高度比例
+(CGFloat)SDWebimghuancunbili:(NSString *)usrstr
{
    UIImage *images =[[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:[NSURL URLWithString:usrstr].absoluteString];
    CGFloat bili =images.size.height/images.size.width;
    return bili;
}
+(CGFloat)getimgAuto:(id)imageurl
{
    //有阻塞线程现象
    CGSize size = [UIImageView getImageSizeWithURLllll:imageurl];
//    NSLog(@"%@",NSStringFromCGSize(size));
    if (size.height == 0||size.width==0) {
        return 1;
    }
    CGFloat flot = size.height/size.width;

    return flot;
}
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL{
    
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;// url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
        
    }else if([pathExtendsion isEqual:@"gif"]){
        
        size =  [self getGIFImageSizeWithRequest:request];
        
    }else if([pathExtendsion isEqual:@"jpg"] || [pathExtendsion isEqual:@"jpeg"]){
        
        size = [self getJPGImageSizeWithRequest:request];

        
    }else {
        
        size =  [self getJPGImageSizeWithRequest:request];//.
    }
    
    
    
    if(CGSizeEqualToSize(CGSizeZero, size)) // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    
    
    return size;
}

//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest *)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest *)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}


/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURLllll:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        //以下是对手机32位、64位的处理（由网友评论区拿到的：小怪兽饲养猿）
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            CFRelease(imageProperties);
        }
        
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}
//------------------------------------------------
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

@end
