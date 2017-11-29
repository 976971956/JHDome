//
//  OneAddressPickerView.m
//  JHDomeFrames
//
//  Created by 李江湖 on 2017/11/23.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "OneAddressPickerView.h"

@interface OneAddressPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
/** 地址选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 地址列表（三个层级：省市区） */
@property (nonatomic, strong) NSArray *addressArray;
/** 选中的省份 */
@property (nonatomic, assign) NSInteger provinceIndex;
/** 选中的城市 */
@property (nonatomic, assign) NSInteger cityIndex;
/** 选中的区 */
@property (nonatomic, assign) NSInteger areaIndex;

@property(nonatomic,strong)UIButton *quedinBtn;

@property(nonatomic,strong)UIButton *quxiaoBtn;

@property(nonatomic,strong)NSMutableArray *mutArr;

@end
@implementation OneAddressPickerView

#pragma mark - initializer
- (instancetype)initWithFrame:(CGRect)frame dic:(CityBlock)onedic{
    // 判断用户初始化时是否设置了 frame
    //    if (CGRectEqualToRect(frame, CGRectNull) || CGRectEqualToRect(frame, CGRectZero)) {
    //        // 只需要设置 height，x,y,width 不会产生影响
    //        frame = CGRectMake(0, 400, 375, 300);
    //    }
    if (self = [super initWithFrame:frame]) {
        self.cityblock = onedic;
        self.backgroundColor = kWhite;
        self.userInteractionEnabled = YES;
        //        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.pickerView];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        [self pickerView:self.pickerView didSelectRow:3 inComponent:0];
        //        self.pickerView.backgroundColor = BLUE_COLOR;
//        [self setlinesandtitle];
        [self addSubview:self.quedinBtn];
        [self addSubview:self.quxiaoBtn];
    }
    return self;
}
-(void)setlinesandtitle
{
    //    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 1)];
    //    lineview.backgroundColor = LINECOLOR;
    //    [self addSubview:lineview];
    UILabel *titleLable =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 20 , 200, 20)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = KFont20;
    titleLable.text = @"选择地址";
    [self addSubview:titleLable];
    //    UIView *lineview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 1)];
    //    lineview1.backgroundColor = LINECOLOR;
    //    [self addSubview:lineview1];
}
-(UIButton *)quedinBtn{
    if (!_quedinBtn) {
        _quedinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _quedinBtn.titleLabel.font = KFont18;
        [_quedinBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_quedinBtn setTitleColor:[UIColor blackColor] forState:0];
        [_quedinBtn addTarget:self action:@selector(quedinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _quedinBtn.frame = CGRectMake(self.frame.size.width-60, 5, 50, 20);
    }
    return _quedinBtn;
}
-(UIButton *)quxiaoBtn{
    if (!_quxiaoBtn) {
        _quxiaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_quxiaoBtn setTitleColor:[UIColor blackColor] forState:0];
        
        [_quxiaoBtn addTarget:self action:@selector(quxiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _quxiaoBtn.frame = CGRectMake(10, 5, 50, 20);
    }
    return _quxiaoBtn;
}
-(void)quedinBtnClick
{
    self.cityblock(self.selectedAddress);
}
-(void)quxiaoBtnClick
{
    [self.dataSource quxiaoclear];
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.mutArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleForRow = @"";
    NSDictionary *province = self.mutArr[row];
    return province[@"Name"];
}
//重写方法
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel){
//        pickerLabel = [[UILabel alloc] init];
//        // Setup label properties - frame, font, colors etc
//        //adjustsFontSizeToFitWidth property to YES
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
//        [pickerLabel setBackgroundColor:[UIColor clearColor]];
//        [pickerLabel setFont:MORENFONTSIZE(30)];
//    }
//    // Fill the label text here
//    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
//    return pickerLabel;
//}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView selectRow:row inComponent:component animated:YES];

    NSDictionary *dic =self.mutArr[row];
    [self.selectedAddress setDictionary:dic];
    self.areaIndex = row;
//    switch (component) {
//        case 0:
//        {
//            self.provinceIndex = row;
//            self.cityIndex = 0;
//            self.areaIndex = 0;
//
//            [pickerView reloadComponent:1];
//            [pickerView reloadComponent:2];
//            [pickerView selectRow:0 inComponent:1 animated:NO];
//            [pickerView selectRow:0 inComponent:2 animated:NO];
//            /**
//             *  更新选中的 addresss，包括：市，区
//             */
//            //            NSDictionary *province = self.addressArray[self.provinceIndex];
//            //            NSDictionary *city = province[@"State"][self.cityIndex];
//            //            self.selectedAddress[ProvinceKey] = self.addressArray[row][@"Name"];
//            //            if ([province[@"State"] count] > 0) {
//            //                self.selectedAddress[CityKey] = province[@"State"][0][@"Name"];
//            //            } else {
//            //                self.selectedAddress[CityKey] = @"";
//            //            }
//            //            if ([city[@"City"] count] > 0) {
//            //                self.selectedAddress[AreaKey] = city[@"City"][0];
//            //            } else {
//            //                self.selectedAddress[AreaKey] = @"";
//            //            }
//        }
//            break;
//        case 1:
//        {
//            self.cityIndex = row;
//            self.areaIndex = 0;
//            [pickerView reloadComponent:2];
//            [pickerView selectRow:0 inComponent:2 animated:NO];
//            /**
//             *  更新选中的 addresss，包括：区
//             */
//            //            NSDictionary *province = self.addressArray[self.provinceIndex];
//            //            NSDictionary *city = province[@"State"][self.cityIndex];
//            //            self.selectedAddress[CityKey] = province[@"State"][row][@"Name"];
//            //            if ([city[@"City"] count] > 0) {
//            //                self.selectedAddress[AreaKey] = city[@"City"][0];
//            //            } else {
//            //                self.selectedAddress[AreaKey] = @"";
//            //            }
//        }
//            break;
//        case 2:
//        {
//            self.areaIndex = row;
//            /**
//             *  更新选中的 addresss
//             */
//            //            NSDictionary *province = self.addressArray[self.provinceIndex];
//            //            NSDictionary *city = province[@"State"][self.cityIndex];
//            //            self.selectedAddress[AreaKey] = city[@"City"][row];
//        }
//            break;
//    }
}

#pragma mark - getter
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-100)];
        _pickerView.backgroundColor = [UIColor yellowColor];
        

    }
    return _pickerView;
}
- (NSArray *)addressArray {
    if (_addressArray == nil) {
        if ([self.dataSource respondsToSelector:@selector(addressArray)]) {
            _addressArray = [self.dataSource addressArray];
        } else {
            _addressArray = [NSArray array];
        }
    }
    return _addressArray;
}
- (NSMutableDictionary *)selectedAddress {
    if (_selectedAddress == nil) {
        _selectedAddress = [NSMutableDictionary dictionary];
    }
    return _selectedAddress;
}
-(NSMutableArray *)mutArr
{
    if (!_mutArr) {
        _mutArr = [NSMutableArray array];
        [_mutArr addObject:@{@"CityID":@"1",@"ID":@"1",@"Name":@"江华"}];
        [_mutArr addObject:@{@"CityID":@"2",@"ID":@"2",@"Name":@"道县"}];

        [_mutArr addObject:@{@"CityID":@"3",@"ID":@"3",@"Name":@"江永"}];

        [_mutArr addObject:@{@"CityID":@"4",@"ID":@"4",@"Name":@"水口"}];
        [_mutArr addObject:@{@"CityID":@"5",@"ID":@"5",@"Name":@"岭东"}];

        [_mutArr addObject:@{@"CityID":@"6",@"ID":@"6",@"Name":@"和路况"}];

    }
    return _mutArr;
}
@end
