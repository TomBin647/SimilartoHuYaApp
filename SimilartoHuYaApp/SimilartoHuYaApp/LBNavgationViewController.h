//
//  LBNavgationViewController.h
//  LearningBar
//
//  Created by bing.hao on 15/5/8.
//  Copyright (c) 2015年 www.xuexiba.com. All rights reserved.
//

#import "KSNavigationController.h"

#define LB_NEW_NVC(vc) [LBNavgationViewController createInstance:vc]

@interface LBNavgationViewController : KSNavigationController

+ (LBNavgationViewController *)createInstance:(UIViewController *)vc;

@end
