//
//  ShowManage.m
//  TuiJI
//
//  Created by ddapp on 17/5/2.
//  Copyright © 2017年 LJH. All rights reserved.
//

#import "ShowManage.h"

@implementation ShowManage
+(void)showActionSheetcotroll:(UIViewController *)cotroll showtitle:(NSString *)showtitle andsheetAction:(showmaga1)show
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:showtitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show();
    }];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction1];
    [alertController addAction:okAction];
    [cotroll presentViewController:alertController animated:YES completion:nil];

}
+(void)showActionSheetcotroll_JUBAO:(UIViewController *)cotroll showtitle:(NSString *)showtitle and_JB_title:(NSString *)jb_title andsheetAction:(showmaga1)show andsheetAction1:(showmaga2)show1
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:showtitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show();
    }];
    UIAlertAction *jbAction = [UIAlertAction actionWithTitle:jb_title style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        show1();
    }];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];


    [alertController addAction:okAction1];
    
    [alertController addAction:okAction];
    [alertController addAction:jbAction];
    [cotroll presentViewController:alertController animated:YES completion:nil];
    
}

+(void)cusrmshowActionSheetcotroll:(UIViewController *)cotroll showtitle:(NSString *)showtitle andimg:(UIImage *)nameimg andtitlename:(NSString *)title andsheetAction:(showmaga1)show censer:(showmaga2)show2
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"\n" message:@"\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
//    头部view
    UIView *imagerview = [[UIView alloc]initWithFrame:CGRectMake(0, 10, alertController.view.width-20, 86)];
    imagerview.backgroundColor = CLEAR_COLOR;
    [alertController.view addSubview:imagerview];
    //图片
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((imagerview.width-38)/2, 8, 38, 38)];
    img.image = nameimg;
    [imagerview addSubview:img];
//    文字
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, imagerview.width, 16)];
    titlelab.font = KFont14_5;
    titlelab.text = title;
    titlelab.textAlignment = NSTextAlignmentCenter;
    [imagerview addSubview:titlelab];
    
//    UIAlertAction *nullAction = [UIAlertAction actionWithTitle:showtitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    }];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:showtitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show();
    }];
    [okAction setValue:RED_BTN_NOM_COLOR forKey:@"titleTextColor"];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        show2();
    }];
//    [alertController addAction:nullAction];
    [alertController addAction:okAction1];
    [alertController addAction:okAction];
    [cotroll presentViewController:alertController animated:YES completion:nil];
    
}
+(void)showActionSheetcotrollMe:(UIViewController *)cotroll deletetitle:(NSString *)deletetitle edittitle:(NSString *)edittitle andsheetAction:(showmaga1)show  sheetActionedit:(showmaga2)show1
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:deletetitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        show();
    }];
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:edittitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show1();
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:editAction];

    [cotroll presentViewController:alertController animated:YES completion:nil];
    
}
+(void)showManageshow1:(showmaga1)show1 andshow2:(showmaga2)show2 orcontroll:(UIViewController *)cotroll title:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show1();
    }];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show2();
    }];
    [alertController addAction:okAction1];
    [alertController addAction:okAction];
    [cotroll presentViewController:alertController animated:YES completion:nil];

}
+(void)showManage:(showmaga1)show orcontroll:(UIViewController *)cotroll title:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        show();
    }];
    [alertController addAction:okAction];
    [cotroll presentViewController:alertController animated:YES completion:nil];
    
}
@end
