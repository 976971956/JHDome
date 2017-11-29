//
//  BLECell.m
//  JHDomeFrames
//
//  Created by 李江湖 on 2017/11/28.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "BLECell.h"

@interface BLECell()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation BLECell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)paddingDataModel:(ZMDataModel *)model indexPath:(NSIndexPath *)indexPath delegate:(id)delegate
{
    _model = (BLEModel *)model;
    self.nameLab.text = _model.title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation BLEModel
+(void)requestDataWithParameter:(NSDictionary *)parameter inView:(UIView *)view scrollView:(UIScrollView *)scrollView success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSMutableArray *arr = [NSMutableArray array];
    BLEModel *model = [[BLEModel alloc]initWithDic:nil rowHeight:200 identifier:@"cell"];
    model.title  = @"中心设备";
    BLEModel *model1 = [[BLEModel alloc]initWithDic:nil rowHeight:200 identifier:@"cell"];
    model1.title  = @"外部设备";

    [arr addObject:model];
    [arr addObject:model1];
    success(arr);
}
@end
