//
//  JHUniversalcell.m
//  项目基本框架
//
//  Created by 王志威 on 2017/3/27.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "JHUniversalcell.h"

@implementation JHUniversalcell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
