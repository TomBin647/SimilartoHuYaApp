//
//  LOLViewController.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "LOLViewController.h"

@interface LOLViewController ()

@end

@implementation LOLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 50)];
    [button setTitle:@"我是第7页" forState:UIControlStateNormal];
    [button setTintColor:[UIColor yellowColor]];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
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
