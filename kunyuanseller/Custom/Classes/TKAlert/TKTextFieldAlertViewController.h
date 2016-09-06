//
//  TKTextFieldAlertViewController.h
//  
//
//  Created by luobin on 14-8-9.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "TKFirstResponseAlertViewController.h"

@class TKTextFieldAlertViewController;
@protocol TKTextFieldAlertViewDelegate <TKAlertViewControllerDelegate>

@optional
// Called after edits in any of the field
- (BOOL)alertView:(TKTextFieldAlertViewController *)alertView shouldEnableButtonForIndex:(NSUInteger)buttonIndex;

@end

@interface TKTextFieldAlertViewController : TKFirstResponseAlertViewController

@property (nonatomic, readonly, strong) UITextField *textField;
@property (nonatomic, assign) id<TKTextFieldAlertViewDelegate>delegate;

- (id)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com