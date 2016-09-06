//
//  TKAlertManager.h
//  
//
//  Created by luobin on 13-3-16.
//  Copyright (c) 2013年 luobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKActionSheetController.h"

@interface TKActionSheetManager : NSObject

+ (NSArray *)actionSheetStack;
+ (BOOL)stackContainsAlert:(TKActionSheetController *)actionSheet;
+ (void)addToStack:(TKActionSheetController *)actionSheet;
+ (void)removeFromStack:(TKActionSheetController *)actionSheet;
+ (TKActionSheetController *)topMostActionSheet;
+ (BOOL)canceltopMostActionSheetAnimated:(BOOL)animated;
+ (BOOL)cancelAllAlertsAnimated:(BOOL)animated;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com