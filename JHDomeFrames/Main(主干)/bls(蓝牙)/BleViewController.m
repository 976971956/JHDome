//
//  BleViewController.m
//  JHDomeFrames
//
//  Created by 李江湖 on 2017/11/28.
//  Copyright © 2017年 李江湖. All rights reserved.
//

#import "BleViewController.h"
#import "BLECell.h"
#import "BeCentralVewController.h"
#import "BePeripheralViewController.h"
@interface BleViewController ()<UITableViewDelegate>

@end

@implementation BleViewController
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        BeCentralVewController *vc = [[BeCentralVewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        BePeripheralViewController *vc = [[BePeripheralViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)requestData{
    [BLEModel requestDataWithParameter:nil inView:self.view scrollView:self.tableView success:^(NSArray *result) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self reloadDataWithArray:result];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
