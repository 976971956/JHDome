//
//  JHImageAutomaticro.h
//  项目基本框架
//
//  Created by 王志威 on 2017/3/20.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHImageAutomaticro : UIView
//传入头部的frome
-(instancetype)initWithFrame:(CGRect)frame;
//传入数据，bol判断有网无网时用模型
-(void)initdatas:(NSMutableArray *)array boll:(BOOL)bol;

@end
