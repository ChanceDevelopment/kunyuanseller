//
//  TKOverlayWindow.h
//  
//
//  Created by luobin on 13-3-16.
//  Copyright (c) 2013年 luobin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKFullScreenWindowBackground.h"

@interface TKFullScreenWindow : UIWindow

+ (TKFullScreenWindow *)defaultWindow;

- (void)makeKeyAndVisible;
- (void)reduceAlphaIfEmpty;
- (void)revertKeyWindowAndHidden;

@property (nonatomic, strong, readonly) TKFullScreenWindowBackground *backgroundView;
@property (nonatomic, readonly) UIWindow *previousKeyWindow;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com