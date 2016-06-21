//
//  HeTabBarVC.h
//  huayoutong
//
//  Created by HeDongMing on 16/3/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseViewController.h"
#import "RDVTabBarController.h"
#import "HeOrderManagementVC.h"
#import "HeOrderQueryVC.h"
#import "HeSettingVC.h"
#import "HeShopManagementVC.h"

@interface HeTabBarVC : RDVTabBarController<UIAlertViewDelegate>
@property(strong,nonatomic)HeOrderManagementVC *orderManagementVC;
@property(strong,nonatomic)HeOrderQueryVC *orderQueryVC;
@property(strong,nonatomic)HeSettingVC *settingVC;
@property(strong,nonatomic)HeShopManagementVC *shopManagementVC;

@end
