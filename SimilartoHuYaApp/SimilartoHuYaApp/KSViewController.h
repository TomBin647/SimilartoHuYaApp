//
//  KSViewController.h
//  KSToolkit
//
//  Created by bing.hao on 14/11/30.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
#import "KSCom.h"

@interface KSViewController : UIViewController
<
    UIAlertViewDelegate
>

@property (nonatomic, strong) MBProgressHUD * hud;

/**
 * @brief 是否开启键盘监听
 */
@property (nonatomic, assign, readonly) BOOL       isKeyboardListener;
@property (nonatomic, assign, readonly) NSString * leftButtonImageName;

/**
 * @brief 是否显示返回按钮
 */
- (BOOL)showBackButton;
/**
 * @brief 导航栏目左边按钮
 */
- (UIView *)customBackButtonView;
/**
 * @brief 导航栏目右边按钮
 */
- (UIView *)customRightButtonView;
/**
 * @brief 组件初始化
 */
- (void)initializationComponent;
/**
 * 返回按钮事件
 */
- (void)backButtonOnClickEventHandler:(id)sender;
/**
 * 右侧按钮事件
 */
- (void)rightButtonOnClickEventHandler:(id)sender;
/**
 * @brief 注册通知
 */
- (NSArray *)registerNotifications;
/**
 * @brief 接收通知
 */
- (void)receiveNotificationHandler:(NSNotification *)notice;
/**
 * @brief 键盘弹出监听
 */
- (void)keyboardWillShowHandler:(NSDictionary *)userInfo;
/**
 * @brief 键盘隐藏监听
 */
- (void)keyboardWillHideHandler:(NSDictionary *)userInfo;
/**
 * @brief 横向滑动转换在当前导航内
 */
- (void)pushWithController:(UIViewController *)vc;
- (void)pushWithController:(UIViewController *)vc animated:(BOOL)animated;
- (void)pushWithController:(Class)c params:(NSDictionary *)params;
- (void)pushWithController:(Class)c params:(NSDictionary *)params animated:(BOOL)animated;
- (void)pushWithName:(NSString *)name;
- (void)pushWithName:(NSString *)name params:(NSDictionary *)params;
/**
 * @brief 弹出模式窗口
 */
- (void)presentViewController:(UIViewController *(^)(void))viewControllerToPresent;

//- (void)presentWithController:(UIViewController *)vc;
//- (void)presentWithController:(UIViewController *)vc animated:(BOOL)animated;
//- (void)presentWithName:(NSString *)name;
//- (void)presentWithName:(NSString *)name params:(NSDictionary *)params;
/**
 * @brief 打开显示等待指示器
 */
- (void)createProgressHUD;
- (void)setHUDConfigWithTitle:(NSString *)title;
- (void)setHUDConfigWithCustomeView:(UIView *)view title:(NSString *)title;
- (void)setHUDVisible:(BOOL)visible;
- (void)hud_DisplayAfterDelayHide:(NSTimeInterval)interval;
- (void)hud_DisplayAfterDelayHide:(NSTimeInterval)interval complete:(void (^)(void))complete;

/**
 * @brief 等同于UIView中的addSubView方法
 */
- (void)addChild:(UIView *)childView;
- (void)addChild:(UIView *)childView atIndex:(NSInteger)index;
/**
 * 添加一个VIEW到当前CONTROLLER的VIEW上
 **/
- (UIView *)addViewWithClass:(Class)cls;
@end
