//
//  HeMessageManagementVC.h
//  huayoutong
//
//  Created by Tony on 16/7/27.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseViewController.h"
#import "EGORefreshTableFootView.h"
#import "EGORefreshTableHeaderView.h"

@interface HeOrderManagementVC : HeBaseViewController<EGORefreshTableFootDelegate,EGORefreshTableHeaderDelegate>
{
    int updateOption;  //1:上拉刷新   2:下拉加载
    BOOL _reloading;
}

@end
