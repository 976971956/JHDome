//
//  JHScrollTitleView.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/18.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "JHScrollTitleView.h"
// 按钮的起始tag
#define kBtnTag 777

// 每屏所显示按钮的最大个数
#define kSingleViewBtnCount 3

// 按钮的超出部分
#define kBtnBeyondWidth 0

@interface JHScrollTitleView ()

@property (nonatomic, copy) CallBack block;

@end

@implementation JHScrollTitleView

{
    UIScrollView *_scrollView;
    UIView *_topLine;
    
    // 记录当前选择的按钮
    NSInteger _index;
    
    // 记录titles count
    NSInteger _titlesCount;
    
    CGFloat _btnWidth;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleNorColor:(UIColor *)norcolor titleseColor:(UIColor *)selcolor topLine:(UIColor *)topline bgImagesColor:(UIColor *)bgimagcolor orImages:(UIImage *)images callBack:(CallBack)block
{
    if (self = [super initWithFrame:frame])
    {        
        _titlesCount = titles.count;
        
        self.block = block;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
        [self addSubview:_scrollView];
        // 计算按钮的宽度
        if (titles.count <= kSingleViewBtnCount) {
            _btnWidth = SCREEN_WIDTH / titles.count;
        } else {
            _btnWidth = SCREEN_WIDTH / kSingleViewBtnCount + kBtnBeyondWidth;
        }
        
        _scrollView.contentSize = CGSizeMake(titles.count * _btnWidth, _scrollView.bounds.size.height);
        
        self.bgimage.backgroundColor = bgimagcolor;
        //        self.bgimage.image = images;
        [_scrollView addSubview:self.bgimage];
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bgimage.frame)-0.5, SCREEN_WIDTH, 0.5)];
        lineview.backgroundColor = UIColorFromRGB(0xb3b3b3);
        [self.bgimage addSubview:lineview];
        for (int i = 0; i < titles.count; i++)
        {
            self.btn = [self createBtn:CGRectMake(_btnWidth * i, 0, _btnWidth, self.bounds.size.height) title:titles[i] titleNorColor:norcolor titleseColor:selcolor];
            [_scrollView addSubview:self.btn];
            
            self.btn.tag = kBtnTag + i;
            
            if (i == 0) {
                self.btn.selected = YES;
                
                _index = 0;
                
                // 线条
                _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1.5, _btnWidth, 1)];
                _topLine.backgroundColor = topline;
                [self.bgimage addSubview:_topLine];
            }
        }
        
    }
    return self;
}

- (UIButton *)createBtn:(CGRect)frame title:(NSString *)title titleNorColor:(UIColor *)norcolor titleseColor:(UIColor *)selcolor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = KFont16_5;
    [btn setTitleColor:norcolor forState:UIControlStateNormal];
    [btn setTitleColor:selcolor forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)btnClick:(UIButton *)sender
{
    if (sender.selected) return;
    
    sender.selected = YES;
    
    UIButton *oldBtn = (UIButton *)[_scrollView viewWithTag:kBtnTag + _index];
    
    oldBtn.selected = NO;
    
    // 记录新的下标
    _index = sender.tag - kBtnTag;
    
    // 回调
    if (self.block) {
        self.block(_index);
    }
}

-(UIImageView *)bgimage
{
    if (!_bgimage) {
        _bgimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    }
    return _bgimage;
}
/**
 选择对应的按钮
 */
- (void)selectButtonIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[_scrollView viewWithTag:kBtnTag + index];
    
    if (btn.selected) return;
    
    btn.selected = YES;
    
    // 将之前的变为不选中
    UIButton *oldBtn = (UIButton *)[_scrollView viewWithTag:kBtnTag + _index];
    
    oldBtn.selected = NO;
    
    // 记录
    _index = index;
}

/**
 设置底部线条的实时偏移量
 */
- (void)moveTopViewLine:(CGPoint)point
{
    CGRect rect = _topLine.frame;
    
    if (_titlesCount <= kSingleViewBtnCount)
    {
        rect.origin.x = point.x / _titlesCount;
    }
    else
    {
        // 计算超过kSingleViewBtnCount个数按钮的线条偏移量
        rect.origin.x = (point.x / kSingleViewBtnCount) + (point.x / SCREEN_WIDTH * kBtnBeyondWidth);
    }
    
    _topLine.frame = rect;
    
    // 修改scrollView的偏移量
    [_scrollView scrollRectToVisible:rect animated:YES];
}



@end
