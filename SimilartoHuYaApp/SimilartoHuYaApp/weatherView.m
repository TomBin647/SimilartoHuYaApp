//
//  weatherView.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/10.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "weatherView.h"

@implementation weatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


@end
