//
//  JHImageAutomaticro.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/20.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "JHImageAutomaticro.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define HeaderHeight 200    //头部高度
#define Title @"title" //模型解析的数据
#define Image @"image_url" //模型解析的图片数据

#define pageweight 80
@interface JHImageAutomaticro()<UIScrollViewDelegate>
{
    UIScrollView *scroll;
    NSInteger count;
    NSMutableArray *datas;
}

@property(nonatomic,strong)UIPageControl *page;

@end
@implementation JHImageAutomaticro

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
    
}


-(void)initdatas:(NSMutableArray *)array boll:(BOOL)bol
{
    [array insertObject:array[array.count-1] atIndex:0];
    [array insertObject:array[0] atIndex:array.count-1];
    
    datas = [NSMutableArray array];
    
    [datas addObjectsFromArray:array];
    [self initscrollboll:bol];
    [self initPage:array];
}
-(void)initscrollboll:(BOOL)bol
{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HeaderHeight)];
    scroll.pagingEnabled = YES;
    scroll.bounces = YES;
    scroll.contentOffset = CGPointMake(WIDTH, 0);
    scroll.contentSize = CGSizeMake((self.frame.size.width*datas.count-2)*WIDTH, 0);
    scroll.delegate = self;
    [self addSubview:scroll];

    for (int i = 0; i < datas.count; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HeaderHeight)];
        UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(10*i, CGRectGetHeight(img.frame)-50, CGRectGetWidth(img.frame)-pageweight-10-20, 30)];
        //        如果bol为yes传入的是数据库中的数据
        if (bol) {
            NSDictionary *dict = datas[i];
            lable.text = dict[Title];//*****
            img.image = [UIImage imageNamed:dict[Image]];
        }else{//网络数据
            
        }
        lable.font = [UIFont systemFontOfSize:20];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        [scroll addSubview:img];
        [img addSubview:lable];
    }
    
    
    
}

-(void)jianghu
{
    //加入动画
    [scroll.layer addAnimation:[self zhuangchanganimation] forKey:nil];

    count++;
    if(count==datas.count-1)
    {
        count = 1;  //如果指定的图片为最后一张，则图片索引变为第1张
        //处理平滑过渡的设置方法
        scroll.contentOffset = CGPointMake(0, 0);
    }
    //设置动画的下一张的偏移
    [scroll setContentOffset:CGPointMake(count*WIDTH, 0) animated:YES];
    _page.currentPage = count-1;  //页码在图片下标的基础上－1
    
}
//page
-(void)initPage:(NSArray *)arrays
{
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(WIDTH/2-pageweight/2, CGRectGetHeight(scroll.frame)-30, pageweight, 20)];
    _page.numberOfPages = datas.count-2;
    _page.currentPage = 0;
    _page.tag = 101;
    _page.pageIndicatorTintColor = [UIColor redColor];
    _page.currentPageIndicatorTintColor = [UIColor purpleColor];
    [_page addTarget:self action:@selector(btn:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_page];
    //模拟LED轮播
//    [self animatonLED];
    //图片轮播
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jianghu) userInfo:nil repeats:YES];
    
}
-(void)animatonLED
{
    [UIView animateWithDuration:5 animations:^{
        scroll.contentOffset = CGPointMake(WIDTH*(datas.count-2), 0);
        
    } completion:^(BOOL finished) {
        scroll.contentOffset = CGPointMake(0, 0);
        [UIView animateWithDuration:1 animations:^{
            scroll.contentOffset = CGPointMake(WIDTH, 0);
        }];
        [self animatonLED];

    }];
    
}

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

-(CATransition *)zhuangchanganimation
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
-(void)btn:(UIPageControl *)page2
{
    NSInteger num = page2.currentPage;
    [scroll setContentOffset:CGPointMake(num*WIDTH, 0)];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int num = scrollView.contentOffset.x/(WIDTH);
    UIPageControl *page3 = (UIPageControl *)[self viewWithTag:101];
    page3.currentPage = num;
    
}



@end
