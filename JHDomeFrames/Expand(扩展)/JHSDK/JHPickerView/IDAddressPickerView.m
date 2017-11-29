//
//  IDAddressPickerView.m
//  IDAddressPickView
//
//  Created by Island on 16/7/15.
//  Copyright © 2016年 Island. All rights reserved.
//

#import "IDAddressPickerView.h"

#define ProvinceKey @"Province"
#define CityKey @"CityKey"
#define AreaKey @"AreaKey"
#define CountriesKey @"countries"
@interface IDAddressPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
/** 地址选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 地址列表（三个层级：省市区） */
@property (nonatomic, strong) NSArray *addressArray;
/** 选中的省份 */
@property (nonatomic, assign) NSInteger provinceIndex;
/** 选中的城市 */
@property (nonatomic, assign) NSInteger cityIndex;
/** 选中的省份 */
@property (nonatomic, assign) NSInteger areaIndex;

@property(nonatomic,strong)UIButton *quedinBtn;

@property(nonatomic,strong)UIButton *quxiaoBtn;

@end

@implementation IDAddressPickerView

#pragma mark - initializer
- (instancetype)initWithFrame:(CGRect)frame {
    // 判断用户初始化时是否设置了 frame
//    if (CGRectEqualToRect(frame, CGRectNull) || CGRectEqualToRect(frame, CGRectZero)) {
//        // 只需要设置 height，x,y,width 不会产生影响
//        frame = CGRectMake(0, 400, 375, 300);
//    }
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhite;
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.pickerView];
//        self.pickerView.backgroundColor = BLUE_COLOR;
        [self setlinesandtitle];
        [self addSubview:self.quedinBtn];
//        [self addSubview:self.quxiaoBtn];
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
        _quedinBtn.frame = CGRectMake(self.frame.size.width/2-50, self.frame.size.height-30-20, 100, 20);
    }
    return _quedinBtn;
}
-(UIButton *)quxiaoBtn{
    if (!_quxiaoBtn) {
        _quxiaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_quxiaoBtn setTitleColor:[UIColor blackColor] forState:0];

        [_quxiaoBtn addTarget:self action:@selector(quxiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _quxiaoBtn.frame = CGRectMake(15, self.frame.size.height-35, 40, 20);
    }
    return _quxiaoBtn;
}
-(void)quedinBtnClick
{
    [self.selectedAddress removeAllObjects];
    
    if ([_addressArray[self.provinceIndex][@"State"] isKindOfClass:[NSArray class]]) {
        if ([_addressArray[self.provinceIndex][@"State"][self.cityIndex][@"City"] isKindOfClass:[NSArray class]]) {
//             NSLog(@"%@-%@-%@",_addressArray[self.provinceIndex][@"Name"],_addressArray[self.provinceIndex][@"State"][self.cityIndex][@"Name"],_addressArray[self.provinceIndex][@"State"][self.cityIndex][@"City"][self.areaIndex][@"Name"]);
            self.selectedAddress[ProvinceKey] =_addressArray[self.provinceIndex][@"_Code"];
            self.selectedAddress[CountriesKey] = _addressArray[self.provinceIndex][@"_Name"];
            self.selectedAddress[CityKey] = _addressArray[self.provinceIndex][@"State"][self.cityIndex][@"_Name"];
            self.selectedAddress[AreaKey] = _addressArray[self.provinceIndex][@"State"][self.cityIndex][@"City"][self.areaIndex][@"_Name"];
        }else{
//            NSLog(@"%@-%@-%@",_addressArray[self.provinceIndex][@"Name"],_addressArray[self.provinceIndex][@"State"][self.cityIndex][@"Name"],_addressArray[self.provinceIndex][@"State"][self.cityIndex][@"City"][@"Name"]);
            self.selectedAddress[ProvinceKey] =_addressArray[self.provinceIndex][@"_Code"];
            self.selectedAddress[CountriesKey] = _addressArray[self.provinceIndex][@"_Name"];

            self.selectedAddress[CityKey] = _addressArray[self.provinceIndex][@"State"][self.cityIndex][@"_Name"];
            self.selectedAddress[AreaKey] = _addressArray[self.provinceIndex][@"State"][self.cityIndex][@"City"][@"_Name"];
        }
        
    }else{
//        NSLog(@"%@-%@",_addressArray[self.provinceIndex][@"Name"],_addressArray[self.provinceIndex][@"State"][@"City"][self.cityIndex][@"Name"]);
        self.selectedAddress[ProvinceKey] =_addressArray[self.provinceIndex][@"_Code"];
        self.selectedAddress[CountriesKey] = _addressArray[self.provinceIndex][@"_Name"];

        self.selectedAddress[CityKey] = _addressArray[self.provinceIndex][@"State"][@"City"][self.cityIndex][@"_Name"];
    }
    self.cityblock(self.selectedAddress);
    
}
-(void)quxiaoBtnClick
{
    [self.dataSource quxiaoclear];
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRowsInComponent = 0;
    NSDictionary *province = self.addressArray[self.provinceIndex];

    if ([province[@"State"] isKindOfClass:[NSArray class]]) {
        switch (component) {
            case 0:
                numberOfRowsInComponent = self.addressArray.count;
                break;
            case 1:
            {
                NSDictionary *province = self.addressArray[self.provinceIndex];
                numberOfRowsInComponent = [province[@"State"] count];
            }
                break;
            case 2:
            {
                
                NSDictionary *province = self.addressArray[self.provinceIndex];
                NSDictionary *cities = province[@"State"][self.cityIndex];
                if (![cities[@"City"] isKindOfClass:[NSArray class]]) {
                    numberOfRowsInComponent = 1;

                }else{
                    numberOfRowsInComponent = [cities[@"City"] count];
                }
            }
                break;
        }
    }else{
        switch (component) {
            case 0:
                numberOfRowsInComponent = self.addressArray.count;
                break;
            case 1:
            {
                NSDictionary *province = self.addressArray[self.provinceIndex];
                numberOfRowsInComponent = [province[@"State"][@"City"] count];
            }
                break;
            case 2:
            {
//                NSDictionary *province = self.addressArray[self.provinceIndex];
//                NSDictionary *cities = province[@"State"][self.cityIndex];
                numberOfRowsInComponent = 0;
            }
                break;
        }

    }
    return numberOfRowsInComponent;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleForRow = @"";
     NSDictionary *province = self.addressArray[self.provinceIndex];
  
    if ([province[@"State"] isKindOfClass:[NSArray class]]) {

        switch (component) {
            case 0:
                titleForRow = self.addressArray[row][@"_Name"];
                break;
            case 1:
            {
                NSDictionary *province = self.addressArray[self.provinceIndex];
                titleForRow = province[@"State"][row][@"_Name"];
            }
                break;
            case 2:
            {
                NSDictionary *province = self.addressArray[self.provinceIndex];
                NSDictionary *city = province[@"State"][self.cityIndex];
                if (![city[@"City"]isKindOfClass:[NSArray class]]) {
                    titleForRow = city[@"City"][@"_Name"];

                }else{
                    titleForRow = city[@"City"][row][@"_Name"];
                }
            }
                break;
        }
    }else{
        switch (component) {
            case 0:
                titleForRow = self.addressArray[row][@"_Name"];
                break;
            case 1:
            {
                NSDictionary *province = self.addressArray[self.provinceIndex];
                titleForRow = province[@"State"][@"City"][row][@"_Name"];
            }
                break;
            case 2:
            {
//                NSDictionary *province = self.addressArray[self.provinceIndex];
//                NSDictionary *city = province[@"State"][self.cityIndex];
                titleForRow = @"";
            }
                break;
        }

    
    }
    return titleForRow;
}
//重写方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:KFont15];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            self.provinceIndex = row;
            self.cityIndex = 0;
            self.areaIndex = 0;

            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            /**
             *  更新选中的 addresss，包括：市，区
             */
//            NSDictionary *province = self.addressArray[self.provinceIndex];
//            NSDictionary *city = province[@"State"][self.cityIndex];
//            self.selectedAddress[ProvinceKey] = self.addressArray[row][@"Name"];
//            if ([province[@"State"] count] > 0) {
//                self.selectedAddress[CityKey] = province[@"State"][0][@"Name"];
//            } else {
//                self.selectedAddress[CityKey] = @"";
//            }
//            if ([city[@"City"] count] > 0) {
//                self.selectedAddress[AreaKey] = city[@"City"][0];
//            } else {
//                self.selectedAddress[AreaKey] = @"";
//            }
        }
            break;
        case 1:
        {
            self.cityIndex = row;
            self.areaIndex = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
            /**
             *  更新选中的 addresss，包括：区
             */
//            NSDictionary *province = self.addressArray[self.provinceIndex];
//            NSDictionary *city = province[@"State"][self.cityIndex];
//            self.selectedAddress[CityKey] = province[@"State"][row][@"Name"];
//            if ([city[@"City"] count] > 0) {
//                self.selectedAddress[AreaKey] = city[@"City"][0];
//            } else {
//                self.selectedAddress[AreaKey] = @"";
//            }
        }
            break;
        case 2:
        {
            self.areaIndex = row;
            /**
             *  更新选中的 addresss
             */
//            NSDictionary *province = self.addressArray[self.provinceIndex];
//            NSDictionary *city = province[@"State"][self.cityIndex];
//            self.selectedAddress[AreaKey] = city[@"City"][row];
        }
            break;
    }
}

#pragma mark - getter
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-80)];
        _pickerView.backgroundColor = [UIColor whiteColor];
    
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
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
@end
