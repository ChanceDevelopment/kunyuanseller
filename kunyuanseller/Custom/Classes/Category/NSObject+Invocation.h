//
//
//
//
//  Created by binluo on 15/6/14.
//  Copyright (c) 2015年 Baijiahulian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSInvocation)

/* invocation with selector and arguments */
- (NSInvocation *)invocationWithSelector:(SEL)selector;
- (NSInvocation *)invocationWithSelector:(SEL)selector argument:(void *)argument;
- (NSInvocation *)invocationWithSelector:(SEL)selector arguments:(void *)argument, ...;

/* invoke with selector, arguments */
- (void)invokeWithSelector:(SEL)selector;
- (void)invokeWithSelector:(SEL)selector argument:(void *)argument;
- (void)invokeWithSelector:(SEL)selector arguments:(void *)argument, ...;

/* invoke with selector, arguments and return-value */
- (void)invokeWithSelector:(SEL)selector returnValue:(void *)returnValue;
- (void)invokeWithSelector:(SEL)selector returnValue:(void *)returnValue argument:(void *)argument;
- (void)invokeWithSelector:(SEL)selector returnValue:(void *)returnValue arguments:(void *)argument, ...;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com