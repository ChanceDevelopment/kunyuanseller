//
//  UIDeviceAdditions.m
//  ActionSheetAndAlert
//
//  Created by luobin on 14-8-9.
//  Copyright (c) 2014年 luobin. All rights reserved.
//

#import "UIDeviceAdditions.h"

@implementation UIDevice(Additions)

- (NSInteger)majorVersion {
    static NSInteger result = -1;
    if (result == -1) {
        NSNumber *majorVersion = (NSNumber *)[[self.systemVersion componentsSeparatedByString:@"."] objectAtIndex:0];
        result = majorVersion.integerValue;
    }
    return result;
}

- (BOOL)isIOS7 {
    static NSInteger result = -1;
    if (result == -1) {
        result = [self majorVersion] >= 7;
    }
    return (BOOL)result;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com