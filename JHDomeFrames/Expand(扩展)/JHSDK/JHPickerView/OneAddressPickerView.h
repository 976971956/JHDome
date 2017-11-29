//
//  OneAddressPickerView.h
//  JHDomeFrames
//
//  Created by 李江湖 on 2017/11/23.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityBlock)(NSDictionary *);
@class OneAddressPickerView;

@protocol OneAddressPickerViewDataSource <NSObject>
/**
 *  地址信息，指定格式的数组
 */
- (NSArray *)addressArray;

-(void)quxiaoclear;

@end
@interface OneAddressPickerView : UIView
- (instancetype)initWithFrame:(CGRect)frame dic:(void(^)(NSDictionary *dic))onedic;
/** 代理 */
@property (nonatomic, weak) id<OneAddressPickerViewDataSource> dataSource;
/**
 *  所选中的 省市区 信息，分别对应于 key: province, city, area
 */
@property (nonatomic, strong) NSMutableDictionary *selectedAddress;
@property(nonatomic,copy)CityBlock cityblock;

@end
