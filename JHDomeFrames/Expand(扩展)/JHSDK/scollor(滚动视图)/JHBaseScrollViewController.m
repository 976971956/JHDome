//
//  JHBaseScrollViewController.m
//  项目基本框架
//
//  Created by 李江湖 on 2017/3/18.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "JHBaseScrollViewController.h"
//设置标题文字默认颜色
#define TitleNorcolor RGBA(225, 225, 225, 1)
//设置标题文字点击颜色
#define TitleSelcolor RGBA(225, 225, 225, 1)
//设置下方横线颜色
#define TitletoplineColor RGBA(225, 225, 225, 1)
//设置背景颜色
#define TitleBgImageColor [UIColor grayColor]
//设置背景图
#define TopBGCorolimagstr @""
//加入子控制器
#define cotrollARR @[@"JHViewController2", @"JHViewController3", @"JHViewController4",@"JHViewController3",@"JHViewController4",@"JHViewController5"]
//设置标题文字
#define TitleWENGZI @[@"包容", @"忍让", @"智慧", @"推演", @"行者", @"悟者"];

@interface JHBaseScrollViewController ()<UIScrollViewDelegate>

// 用来放viewController的view
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JHBaseScrollViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    // 设置自动调整ScrollView的ContentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 标题
    self.titles = TitleWENGZI;
    self.cotrollorArr = cotrollARR;

    [self addYGScrollTitleView];
    
    [self refreshControlller];
}





#pragma mark - 创建JHScrollTitleView

- (void)addYGScrollTitleView
{
    // 创建YGSrollViewTitleView
    _titleView = [[JHScrollTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40) titles:_titles titleNorColor:TitleNorcolor titleseColor:TitleSelcolor topLine:TitletoplineColor bgImagesColor:TitleBgImageColor orImages:[UIImage imageNamed:TopBGCorolimagstr] callBack:^(NSInteger pageIndex) {
        
        // 点击头部按钮时的回调
        // 设置scrollView的偏移量
        [_scrollView setContentOffset:CGPointMake(pageIndex * _scrollView.bounds.size.width, 0) animated:NO];
    }];

    [self.view addSubview:_titleView];
    
    
    // 创建滚动视图控制器的scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_titleView.frame))];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * _titles.count, _scrollView.bounds.size.height);
    [self.view addSubview:_scrollView];
}

#pragma mark - 加载视图控制器

- (void)refreshControlller
{
    // 需要添加到scrollView中的视图控制器
    
    for (int i = 0; i < _titles.count; i++)
    {
        UIViewController *vc = [[NSClassFromString(self.cotrollorArr[i]) alloc] init];
        
        // 1. 往父视图控制器中添加vc
        [self addChildViewController:vc];
        
        // 2. 将vc的view的x坐标偏移
        vc.view.frame = CGRectMake(_scrollView.bounds.size.width * i, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        
        // 3. vc.view添加到scrollView上
        [_scrollView addSubview:vc.view];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [_titleView selectButtonIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_titleView moveTopViewLine:scrollView.contentOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
