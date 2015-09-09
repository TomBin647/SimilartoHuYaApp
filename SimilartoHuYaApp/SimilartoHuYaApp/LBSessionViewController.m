//
//  LBSessionViewController.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "LBSessionViewController.h"

@interface LBSessionViewController ()

@end

@implementation LBSessionViewController

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = nil;
    
}

-(instancetype)init {
    NSArray *titleArray = @[@"推荐",@"DOTA2",@"地下城与勇士",@"方舟:生存进化",@"穿越火线",@"魔兽争霸",@"英雄联盟",@"秀场"];
    NSArray * viewControllerNames = @[@"recommendViewController",@"dota2ViewController",@"underGroundCityViewController",@"arkViewController",@"CSViewController",@"moshouViewController",@"LOLViewController",@"showViewController"];
    if (self = [super initWithTitles:titleArray andSubViewdisplayClassNames:viewControllerNames andTagViewHeight:49]) {
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"类似雅虎app平台主界面";
    self.tabBarItem.title = @"班级圈";
    
    self.graceTime = 300;
    //self.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
