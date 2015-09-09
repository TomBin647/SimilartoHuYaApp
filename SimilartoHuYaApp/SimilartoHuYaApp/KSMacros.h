//
//  KSMacros.h
//  KSToolkit
//
//  Created by bing.hao on 14/11/20.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma --mark
#pragma --mark Print Log
//=====================================================================>
//Log

/** DEBUG LOG **/
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

#pragma --mark
#pragma --mark Object
//=====================================================================>
//Object

/**
 * @brief 释放一个对象
 */
#define KSRelease(_v) if(_v) _v = nil;
/**
 * @brief 获取一个NSNull对象
 */
#define KS_NULL [NSNull null]
/**
 * @brief 根据类名创建一个对象
 */
#define KS_NEW_OBJECT(CN) [NSClassFromString(CN) new]
/**
 * @brief 解决BLOCK在Controller中引起循环引用而定义宏,将当前SELF转换为一个弱引用在BLOCK中调用
 */
#define KS_BLOCK_WEAK(t, alias) __weak __typeof(t)alias = t
#define KS_WS(alias)  __weak __typeof(&*self)alias = self;
/**
 * @brief 在BLOCK中装弱引用转化为强引用。出BLOCK后会自动释放
 */
#define KS_BLOCK_STRONG(t, alias) __strong __typeof(t)alias = t
/**
 * @brief 共享实例宏
 */
#define KS_SHARED_1(t) + (t *)shared;
#define KS_SHARED_2(t) + (t *)shared\
{\
static id __object;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
__object = [t new];\
});\
return __object;\
}

#pragma --mark
#pragma --mark System Version
//=====================================================================>
//Version
/**
 *  判断设备型号
 */
#define IHPONEWHAT [UIDevice currentDevice].model
/**
 * @brief 判断IOS7以上版本
 */
#define __IOS7_OR_LATER [[UIDevice currentDevice].systemVersion floatValue] >= 7.0f
/**
 * @brief 判断IOS8以上版本
 */
#define __IOS8_OR_LATER [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f

#define iOS7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)

#define KS_IOS7_OR_LATER __IOS7_OR_LATER
#define KS_IOS8_OR_LATER __IOS8_OR_LATER

#define KS_APP_VERSION      [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]
#define KS_APP_BUILDER      [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleVersion"]
#define KS_APP_IDENTIFIER   [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"]

#pragma --mark
#pragma --mark Frame
//=====================================================================>
//Frame

/**
 * @brief 获取屏幕尺寸
 */
#define KS_SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
/**
 * @brief 获取屏幕宽
 */
#define KS_SCREEN_WIDTH  KS_SCREEN_BOUNDS.size.width
/**
 * @brief 获取屏幕高
 */
#define KS_SCREEN_HEIGHT KS_SCREEN_BOUNDS.size.height

#define KS_IPHONE_4_SCREEN_WIDTH       320
#define KS_IPHONE_4_SCREEN_HEIGHT      480
#define KS_IPHONE_5_SCREEN_WIDTH       320
#define KS_IPHONE_5_SCREEN_HEIGHT      568
#define KS_IPHONE_6_SCREEN_WIDTH       375
#define KS_IPHONE_6_SCREEN_HEIGHT      667
#define KS_IPHONE_6_PLUS_SCREEN_WIDTH  414
#define KS_IPHONE_6_PLUS_SCREEN_HEIGHT 736

#define KS_DEFAULT_SCREEN_WIDTH  KS_IPHONE_5_SCREEN_WIDTH
#define KS_DEFAULT_SCREEN_HEIGHT KS_IPHONE_5_SCREEN_HEIGHT

/**
 * @brief 获取一个可缩放的尺寸值
 */
CG_INLINE CGFloat KSFrameValue(CGFloat v) {
    return (KS_SCREEN_WIDTH == KS_DEFAULT_SCREEN_WIDTH) ? v : (v * (KS_SCREEN_WIDTH / KS_DEFAULT_SCREEN_WIDTH));
}

/**
 * @brief 获取一个Rect会自动做屏幕尺寸缩放
 */
CG_INLINE CGRect KSFrameRectMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
    return CGRectMake(KSFrameValue(x), KSFrameValue(y), KSFrameValue(w), KSFrameValue(h));
}

/**
 * @brief 像素转PT
 */
#define KS_PX_TO_PT(v)               ((v * 1.0f) / 2)
#define KS_PX_TO_PT_SIZE(w, h)       CGSizeMake(KS_PX_TO_PT(w), KS_PX_TO_PT(h)
#define KS_PX_TO_PT_RECT(x, y, w, h) CGRectMake(KS_PX_TO_PT(x), KS_PX_TO_PT(y), KS_PX_TO_PT(w), KS_PX_TO_PT(h))

#define XT(v)               ((v * 1.0f) / 2)
#define XT_SIZE(w, h)       CGSizeMake(XT(w), XT(h))
#define XT_RECT(x, y, w, h) CGRectMake(XT(x), XT(y), XT(w), XT(h))

/**
 * @brief 线
 */
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)
//
//CG_INLINE CGRect KSRectMakePixel(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
//    
//    return CGRectMake(KSGetFrameXPixel(x), KSGetFrameYPixel(y), KSGetFrameWidthPixel(w), KSGetFrameHeightPixel(h));
//}

#pragma --mark
#pragma --mark Math
//=====================================================================>
//Math

/**
 * @brief 获取一个范围随机数
 */
#define KS_M_RANDOM(from, to) from + (arc4random() % (to - from + 1))

#pragma --mark
#pragma --mark Color
//=====================================================================>
//Color
/**
 * @brief 获取一个RBGA颜色值
 */
#define KS_C_RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green: g / 255.0f blue:b / 255.0f alpha:a]
#define RGBA(r,g,b,a) KS_C_RGBA(r,g,b,a)
#define RGB(r,g,b)    KS_C_RGBA(r,g,b,1)
/**
 * @brief 获取一个16进制颜色值
 */
#define KS_C_HEX(v, a) [UIColor colorWithRed:((Byte)(v >> 16))/255.0 green:((Byte)(v >> 8))/255.0 blue:((Byte)v)/255.0 alpha:a]
#define CHEXA(v,a) KS_C_HEX(v,a)
#define CHEX(v)    KS_C_HEX(v,1)

#pragma --mark
#pragma --mark Path
//=====================================================================>
//Path
#define KS_PATH_HOME     NSHomeDirectory()
#define KS_PATH_TEMP     NSTemporaryDirectory()

#define KS_PATH_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define KS_PATH_CACHE    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define KS_PATH_HOME_FORMAT(s, ...)    [KS_PATH_HOME stringByAppendingFormat:(s), ##__VA_ARGS__]
#define KS_PATH_TEMP_FORMAT(s, ...)    [KS_PATH_TEMP stringByAppendingFormat:(s), ##__VA_ARGS__]
#define KS_PATH_DOCUMENT_FORMAT(s,...) [KS_PATH_DOCUMENT stringByAppendingFormat:(s), ##__VA_ARGS__]
#define KS_PATH_CACHE_FORMAT(s,...)    [KS_PATH_CACHE stringByAppendingFormat:(s), ##__VA_ARGS__]

#define KS_RESOURCE_PATH(N, E)  [[NSBundle mainBundle] pathForResource:(N) ofType:(E)]
#define KS_RESOURCE_PATH_PNG(N) KS_RESOURCE_PATH(N, @"png")
#define KS_RESOURCE_PATH_JPG(N) KS_RESOURCE_PATH(N, @"jpg")
#define KS_RESOURCE_PATH_MP4(N) KS_RESOURCE_PATH(N, @"mp4")
#define KS_RESOURCE_PATH_MOV(N) KS_RESOURCE_PATH(N, @"mov")

#define KS_NEW_FILE_PATH(n,e) [KS_PATH_CACHE_FORMAT(@"%@", n) stringByAppendingFormat:@"/%f.%@", [[NSDate date] timeIntervalSince1970], e]
#define KS_NEW_FILE_PATH_PNG(n) KS_NEW_FILE_PATH(n, @"png")
#define KS_NEW_FILE_PATH_JPG(n) KS_NEW_FILE_PATH(n, @"jpg")
#define KS_NEW_FILE_PATH_MP4(n) KS_NEW_FILE_PATH(n, @"mp4")
#define KS_NEW_FILE_PATH_MOV(n) KS_NEW_FILE_PATH(n, @"mov")

/**
 * @brief 获取一个图片地址(压缩图片尺寸)
 */
#define KS_IMAGE_URL(u, w, h) [NSString stringWithFormat:@"%@?w=%d&h=%d", u, w, h]

#pragma --mark
#pragma --mark KeyBoard
//=====================================================================>
//KeyBoard

//获取键盘的区域
#define KS_KEYBOARD_GET_FRAME(userInfo)              [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]
//获取弹出键盘的动画时间
#define KS_KEYBOARD_GET_ANIMATION_DURATION(userInfo) [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]

#pragma --mark
#pragma --mark Font
//=====================================================================>
//Font
#define KS_FONT_BY_NAME(n, s) [UIFont fontWithName:[NSString stringWithFormat:@"%@",n] size:(s)]
#define KS_FONT_B(s)          [UIFont boldSystemFontOfSize:s]
#define KS_FONT(s)            [UIFont systemFontOfSize:s]


#pragma --mark
#pragma --mark Thread
//=====================================================================>
//Thread
/**
 * @brief 主线程运行block语句块
 */
CG_INLINE void runDispatchGetMainQueue(void (^block)(void)) {
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}
CG_INLINE void KS_DISPATCH_MAIN_QUEUE(void (^block)(void)) {
    runDispatchGetMainQueue(block);
}



/**
 * @brief 主线程运行block语句块
 */
CG_INLINE void runDispatchGetGlobalQueue(void (^block)(void)) {
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, block);
}
CG_INLINE void KS_DISPATCH_GLOBAL_QUEUE(void (^block)(void)) {
    runDispatchGetGlobalQueue(block);
}

#pragma --mark
#pragma --mark UIAlert
//=====================================================================>
//UIAlert

#define KS_ALERT(Title, Message, Tag, LeftButton, ...)                                             \
{                                                                                                  \
    UIAlertView * view = [[UIAlertView alloc] initWithTitle:Title                                  \
                                                    message:Message                                \
                                                   delegate:self                                   \
                                          cancelButtonTitle:LeftButton                             \
                                          otherButtonTitles:__VA_ARGS__, nil];                     \
    [view setTag:Tag];                                                                             \
    [view show];                                                                                   \
}

#define KS_ALERT_1(Message) KS_ALERT(nil, Message, 0, @"确定", nil)
#define KS_ALERT_2(Title, Message) KS_ALERT(Title, Message, 0, @"确定", nil)
#define KS_ALERT_AFTER(Message, after)                                                             \
{                                                                                                  \
    UIAlertView * view = [[UIAlertView alloc] initWithTitle:nil                                    \
                                                    message:Message                                \
                                                   delegate:self                                   \
                                          cancelButtonTitle:nil                                    \
                                          otherButtonTitles:nil, nil];                             \
    [view show];                                                                                   \
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
        [view dismissWithClickedButtonIndex:0 animated:YES];                                       \
    });                                                                                            \
}

#pragma --mark
#pragma --mark NSNotificationCenter
//=====================================================================>
//NSNotificationCenter

#define KS_NOTIC_CENTER               [NSNotificationCenter defaultCenter]
#define KS_NOTIC_CENTER_POST1(p)      [[NSNotificationCenter defaultCenter] postNotificationName:p object:nil];
#define KS_NOTIC_CENTER_POST2(p, obj) [[NSNotificationCenter defaultCenter] postNotificationName:p object:obj];



#pragma --mark
#pragma --mark APNS
//=====================================================================>
CG_INLINE void KS_APNS_REGISTER() {
    if (KS_IOS8_OR_LATER) {
        //Right, that is the point
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

#pragma --mark
#pragma --mark 数据类型转换
//=====================================================================>

#define KS_INT_TO_STRING(i)  [NSString stringWithFormat:@"%d", (int)i]
#define KS_INT32_TO_STR(i)   [NSString stringWithFormat:@"%d", (int)i]
#define KS_INT64_TO_STR(i)   [NSString stringWithFormat:@"%lld", (long long)i]
#define KS_FLOAT_TO_STR(f)   [NSString stringWithFormat:@"%f", f]

#define KS_STRING(v)   [NSString stringWithFormat:@"%@", @(v)]
#define KS_INT64(str)  [str longLongValue]
#define KS_INT32(str)  [str intValue]
#define KS_DOUBLE(str) [str doubleValue]
#define KS_FLOAT(str)  [str floatValue]


/**
 *  短信的链接地址
 */
#define UserMessageAddress  @"http://dl.xuexiba.com/DownLoad/ThreeInOneIndex/"


