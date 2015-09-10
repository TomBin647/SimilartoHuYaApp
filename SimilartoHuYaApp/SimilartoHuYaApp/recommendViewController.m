//
//  recommendViewController.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "recommendViewController.h"

@interface recommendViewController ()

@end

@implementation recommendViewController


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"加入刷新");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 50)];
    [button setTitle:@"我是第一页" forState:UIControlStateNormal];
    [button setTintColor:[UIColor yellowColor]];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    //在里面可以添加想要的内容  例如视频播放器  tableView scrollerView  类似市面上的一些直播平台app
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
