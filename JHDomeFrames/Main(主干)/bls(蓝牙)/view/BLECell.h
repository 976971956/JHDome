//
//  BLECell.h
//  JHDomeFrames
//
//  Created by 李江湖 on 2017/11/28.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "ZMTableViewCell.h"

@class BLEModel;
@interface BLECell : ZMTableViewCell
@property (nonatomic, strong) BLEModel *model;

@end

@interface BLEModel : ZMDataModel

@end
