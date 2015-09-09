//
//  LBNavgationViewController.m
//  LearningBar
//
//  Created by bing.hao on 15/5/8.
//  Copyright (c) 2015年 www.xuexiba.com. All rights reserved.
//

#import "LBNavgationViewController.h"
#import "KSViewController.h"

@interface LBNavgationViewController ()

@end

@implementation LBNavgationViewController

+ (LBNavgationViewController *)createInstance:(UIViewController *)vc
{
    LBNavgationViewController * nv = [[LBNavgationViewController new] initWithRootViewController:vc];
    nv.navigationBar.barTintColor = KS_C_RGBA(52, 152, 217, 1);
    return nv;
}

@end
