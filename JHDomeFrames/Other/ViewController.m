//
//  ViewController.m
//  JHDomeFrames
//
//  Created by 李江湖 on 2017/11/22.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "ViewController.h"
#import "Util.h"
#import "OneAddressPickerView.h"
@interface ViewController ()<OneAddressPickerViewDataSource>
{
    OneAddressPickerView *pickerview;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"22222222j20000000011232322h323232232323222222333333222222222222";
//    [Util setTextColor:self.titleLab Index:3 AndColor:[UIColor redColor]];
    [Util setUILabel:self.titleLab Data:@"5" SetData:@"6" Color:[UIColor redColor] Font:10 Underline:NO];
    pickerview = [[OneAddressPickerView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 300) dic:^(NSDictionary *dic) {
        
    }];
    pickerview.dataSource = self;
    [self.view addSubview:pickerview];
}

-(void)quxiaoclear
{
    pickerview.hidden = YES;
    
}
#pragma mark IDAddressPickerViewDataSource
//-(NSArray *)addressArray
//{
////    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
////    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
////    return array;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
