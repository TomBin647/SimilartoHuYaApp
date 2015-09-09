//
//  GBBodyViewController.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "GBBodyViewController.h"
#import "LBNavgationViewController.h"


#import "LBSessionViewController.h"
#import "LBContactsViewController.h"
#import "LBDiscoveryViewController.h"
#import "LBMeViewController.h"

#define KS_IMAGE(n) [UIImage imageNamed:n]
#define LB_TB_ITEM_1 [LBSessionViewController new]
#define LB_TB_ITEM_2 [LBContactsViewController new]
#define LB_TB_ITEM_3 [LBDiscoveryViewController new]
#define LB_TB_ITEM_4 [LBMeViewController new]

@interface GBBodyViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GBBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray * items = [[NSMutableArray alloc] initWithCapacity:4];
    
    [items addObject:[self createItemWithName:LB_TB_ITEM_1 iname:@"首页" img:@"banjiquan"]];
    [items addObject:[self createItemWithName:LB_TB_ITEM_2 iname:@"上镜" img:@"tongxunlu"]];
    [items addObject:[self createItemWithName:LB_TB_ITEM_3 iname:@"发现" img:@"faxian"]];
    [items addObject:[self createItemWithName:LB_TB_ITEM_4 iname:@"我的" img:@"wo"]];
    
    self.viewControllers = items;
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)createItemWithName:(UIViewController *)vc iname:(NSString *)iname img:(NSString *)imgName
{
    LBNavgationViewController * nc = LB_NEW_NVC(vc);
    
    vc.hidesBottomBarWhenPushed = NO;
    vc.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    NSString * n_name = [NSString stringWithFormat:@"%@.png", imgName];
    NSString * s_name = [NSString stringWithFormat:@"%@-2.png", imgName];
    
    UIImage * n_image = [KS_IMAGE(n_name) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * s_image = [KS_IMAGE(s_name) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.title = iname;
    vc.tabBarItem.image = n_image;
    vc.tabBarItem.selectedImage = s_image;
    
    
    NSDictionary * ta1 = @{ NSForegroundColorAttributeName : KS_C_RGBA(33, 188, 252, 1)};
    NSDictionary * ta2 = @{ NSForegroundColorAttributeName : KS_C_RGBA(156, 156, 156, 1)};
    
    [vc.tabBarItem setTitleTextAttributes:ta1 forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:ta2 forState:UIControlStateNormal];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    return nc;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
