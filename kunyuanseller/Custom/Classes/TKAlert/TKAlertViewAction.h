//
//  TKAlertViewAction.h
//
//
//  Created by binluo on 15/6/12.
//  Copyright (c) 2015年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKAlertConst.h"

@interface TKAlertViewAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title type:(TKAlertViewButtonType)type handler:(void (^)(NSUInteger index))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) TKAlertViewButtonType type;
@property (nonatomic, readonly, copy) void (^handler)(NSUInteger index);
@property (nonatomic, getter=isEnabled, assign) BOOL enabled;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com