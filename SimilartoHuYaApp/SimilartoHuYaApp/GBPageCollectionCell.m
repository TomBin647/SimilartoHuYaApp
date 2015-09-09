//
//  GBPageCollectionCell.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "GBPageCollectionCell.h"

@implementation GBPageCollectionCell


- (void)configCellWithController:(UIViewController *)controller
{
    NSLog(@"%@====%@",NSStringFromCGRect(controller.view.frame),NSStringFromCGRect(self.bounds));
    controller.view.frame = self.bounds;
    [self.contentView addSubview:controller.view];
    
}

@end
