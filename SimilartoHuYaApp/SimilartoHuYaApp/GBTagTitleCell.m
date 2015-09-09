//
//  GBTagTitleCell.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "GBTagTitleCell.h"

#import "XBTagTitleModel.h"
@interface GBTagTitleCell()
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic,strong) UILabel * moveLabel;
@end
@implementation GBTagTitleCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        
//        _moveLabel = [[UILabel alloc]init];
//        _moveLabel.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:_titleLabel];
        //[self.contentView addSubview:_moveLabel];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    //空方法,取消长按时自动变色
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.titleLabel.font = self.tagTitleModel.selectedTitleFont;
        self.titleLabel.textColor = self.tagTitleModel.selectedTitleColor;
        //self.moveLabel.backgroundColor = [UIColor redColor];
    }else
    {
        self.titleLabel.font = self.tagTitleModel.normalTitleFont;
        self.titleLabel.textColor = self.tagTitleModel.normalTitleColor;
        //self.moveLabel.backgroundColor = [UIColor whiteColor];
    }
    //    [self layoutIfNeeded];
}

- (void)setTagTitleModel:(XBTagTitleModel *)tagTitleModel
{
    _tagTitleModel = tagTitleModel;
    [self updateUI];
}

- (void)updateUI
{
    self.titleLabel.text = self.tagTitleModel.tagTitle;
    self.titleLabel.font = self.tagTitleModel.normalTitleFont;
    self.titleLabel.textColor = self.tagTitleModel.normalTitleColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
//    self.moveLabel.frame = CGRectMake(0,self.frame.size.height -1, self.frame.size.width, self.frame.size.height);
}

@end

