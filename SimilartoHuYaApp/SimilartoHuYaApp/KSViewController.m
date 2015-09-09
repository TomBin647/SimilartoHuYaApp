//
//  KSViewController.m
//  KSToolkit
//
//  Created by bing.hao on 14/11/30.
//  Copyright (c) 2014年 bing.hao. All rights reserved.
//

#import "KSViewController.h"

#define KS_REGISTER_NOTIFICATIONS(obj) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationHandler:) name:obj object:nil];

@implementation KSViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (BOOL)isKeyboardListener
{
    return NO;
}

- (BOOL)showBackButton
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[self registerNotifications] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KS_REGISTER_NOTIFICATIONS(obj);
    }];
    
    UIView * backView  = [self customBackButtonView];
    UIView * rightView = [self customRightButtonView];
    
    if (backView) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    } else if([self showBackButton]) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setFrame:CGRectMake(0, 0, 20, 44)];
        [button setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonOnClickEventHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    if (rightView) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    }
    
    [self initializationComponent];
    
//    self.tabBarController.tabBar.translucent = NO;
}
- (void)initializationComponent
{
    
}

- (UIView *)customBackButtonView
{
    return nil;
}

- (UIView *)customRightButtonView
{
    return nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isKeyboardListener) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(kws:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(kwh:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.isKeyboardListener) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    }
//    if (self.hud) {
//        [self.hud removeFromSuperview];
//    }
    
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    for (NSString * name in [self registerNotifications]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    }
    if (self.hud) {
        [self.hud removeFromSuperview];
    }
    KSRelease(self.hud);
}

#pragma --mark
#pragma --mark Navigation

- (void)backButtonOnClickEventHandler:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonOnClickEventHandler:(id)sender
{
    
}

#pragma --mark
#pragma --mark Notification

- (NSArray *)registerNotifications
{
    return nil;
}

- (void)receiveNotificationHandler:(NSNotification *)notice
{
    
}

#pragma --mark
#pragma --mark Keyboard

- (void)keyboardWillHideHandler:(NSDictionary *)userInfo
{
    
}

- (void)keyboardWillShowHandler:(NSDictionary *)userInfo
{
    
}

- (void)kws:(NSNotification *)sender
{
    [self keyboardWillShowHandler:[sender userInfo]];
}

- (void)kwh:(NSNotification *)sender
{
    [self keyboardWillHideHandler:[sender userInfo]];
}

#pragma --mark
#pragma --mark Pusn and Present

- (void)pushWithController:(UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushWithController:(UIViewController *)vc animated:(BOOL)animated
{
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)pushWithController:(Class)c params:(NSDictionary *)params
{
    [self pushWithController:c params:params animated:YES];
}

- (void)pushWithController:(Class)c params:(NSDictionary *)params animated:(BOOL)animated
{
    UIViewController * vc = [c new];
    if (params) {
        for (NSString * key in params.allKeys) {
            [vc setValue:[params objectForKey:key] forKeyPath:key];
        }
    }
    [self pushWithController:vc animated:animated];
}

- (void)pushWithName:(NSString *)name
{
    [self pushWithName:name params:nil];
}

- (void)pushWithName:(NSString *)name params:(NSDictionary *)params
{
    UIViewController * vc = KS_NEW_OBJECT(name);
    if (params) {
        for (NSString * key in params.allKeys) {
            [vc setValue:[params objectForKey:key] forKeyPath:key];
        }
    }
    [self pushWithController:vc];
}

- (void)presentViewController:(UIViewController *(^)(void))viewControllerToPresent
{
    UIViewController * vc = viewControllerToPresent();
    
    [self presentViewController:vc animated:YES completion:nil];
}

//- (void)presentWithController:(UIViewController *)vc
//{
//    [self presentViewController:vc animated:NO completion:nil];
//}
//
//- (void)presentWithController:(UIViewController *)vc animated:(BOOL)animated
//{
//    [self presentViewController:vc animated:NO completion:nil];
//}

//- (void)presentWithName:(NSString *)name
//{
//    [self presentWithName:name params:nil];
//}
//
//- (void)presentWithName:(NSString *)name params:(NSDictionary *)params
//{
//    UIViewController * vc = KS_NEW_OBJECT(name);
//
//    if (params) {
//        for (NSString * key in params.allKeys) {
//            [vc setValue:key forKeyPath:[params objectForKey:key]];
//        }
//    }
//    
//    [self presentWithController:vc];
//}

#pragma --mark
#pragma --mark HUD

- (void)createProgressHUD
{
    if (self.hud == nil) {
        @synchronized(self) {
            if (self.hud == nil) {
                if (self.navigationController) {
                    self.hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                    [self.navigationController.view addSubview:self.hud];
                } else {
                    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:self.hud];
                }
            }
        }
    }
}

- (void)setHUDConfigWithTitle:(NSString *)title
{
    [self createProgressHUD];
    [self.hud setMode:MBProgressHUDModeText];
    [self.hud setLabelText:title];
    [self.hud setLabelFont:[UIFont systemFontOfSize:14]];
}

- (void)setHUDConfigWithCustomeView:(UIView *)view title:(NSString *)title
{
    [self createProgressHUD];
    [self.hud setMode:MBProgressHUDModeCustomView];
    [self.hud setCustomView:view];
    [self.hud setLabelText:title];
    [self.hud setLabelFont:[UIFont systemFontOfSize:14]];
}

- (void)setHUDVisible:(BOOL)visible
{
    [self createProgressHUD];
    [self setHUDVisibleTemp:visible complete:nil];
}

- (void)hud_DisplayAfterDelayHide:(NSTimeInterval)interval
{
    [self hud_DisplayAfterDelayHide:interval complete:nil];
}

- (void)hud_DisplayAfterDelayHide:(NSTimeInterval)interval complete:(void (^)(void))complete
{
    [self createProgressHUD];
    
    [self setHUDVisibleTemp:YES complete:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setHUDVisibleTemp:NO complete:complete];
    });
}

//- (void)setHUDVisible:(BOOL)visible afterDelay:(NSTimeInterval)interval
//{
//    [self setHUDVisible:visible afterDelay:interval complete:nil];
//}
//
//- (void)setHUDVisible:(BOOL)visible afterDelay:(NSTimeInterval)interval complete:(void (^)(void))complete
//{
//    [self createProgressHUD];
//    if (interval > 0) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self setHUDVisibleTemp:visible complete:complete];
//        });
//    } else {
//        [self setHUDVisibleTemp:visible complete:complete];
//    }
//}

- (void)setHUDVisibleTemp:(BOOL)visible complete:(void (^)(void))complete
{
    KS_DISPATCH_MAIN_QUEUE(^{
        if (visible) {
            [self.hud show:YES];
        } else {
            [self.hud hide:YES];
        }
        if (complete) {
            complete();
        }
    });
}


#pragma --mark
#pragma --mark addChild

- (void)addChild:(UIView *)childView
{
    [self.view addSubview:childView];
}

- (void)addChild:(UIView *)childView atIndex:(NSInteger)index
{
    [self.view insertSubview:childView atIndex:index];
}

- (UIView *)addViewWithClass:(id)cls
{
    id obj = [cls new];
    
    [self.view addSubview:obj];
    
    return obj;
}

////其他不需要旋转的 ViewController设置，建议添加BaseViewController统一控制
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);}
- (BOOL)shouldAutorotate{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}






@end
