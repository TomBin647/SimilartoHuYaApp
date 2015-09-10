//
//  LBDiscoveryViewController.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "LBDiscoveryViewController.h"

#import "GBTitleLabel.h"

#import "weatherView.h"

@interface LBDiscoveryViewController ()<UIScrollViewDelegate> {
    BOOL showWeathRoom;
}

@property (nonatomic,strong) UIScrollView * titleScrollerView;

@property (nonatomic,strong) UIScrollView * pageScrollerView;

@property (nonatomic,strong) NSArray * titleArray;

@property (nonatomic,strong) weatherView * weatherView;

@property (nonatomic,strong) NSArray * viewControllerNames;

@property(nonatomic,strong)UIButton *rightItem;


@end

@implementation LBDiscoveryViewController

-(instancetype) init {
    if (self) {
        self = [super init];
        
        self.titleArray = @[@"推荐",@"DOTA2",@"地下城与勇士",@"方舟:生存进化",@"穿越火线",@"魔兽争霸",@"英雄联盟",@"秀场"];
        self.viewControllerNames = @[@"recommendViewController",@"dota2ViewController",@"underGroundCityViewController",@"arkViewController",@"CSViewController",@"moshouViewController",@"LOLViewController",@"showViewController"];
        
        
        
        
    }
    return self;
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = nil;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发现";
    
    
    self.titleScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KS_SCREEN_WIDTH, 49)];
    [self.view addSubview:self.titleScrollerView];
    
    self.pageScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 49, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT - 49)];
    [self.view addSubview:self.pageScrollerView];
    
    
    
    self.titleScrollerView.showsHorizontalScrollIndicator = NO;
    self.pageScrollerView.showsHorizontalScrollIndicator = NO;
    self.pageScrollerView.delegate = self;
    
    
    
    
    [self addController];
    [self addtitleLabel];
    
    
    
    GBTitleLabel * title = [self.titleScrollerView.subviews firstObject];
    title.scale = 1.0;
    
    
    showWeathRoom = NO;
    
    
    [self addWeather];
    
}

-(void)addWeather{
    self.weatherView= [[weatherView alloc]initWithFrame:CGRectMake(0, 64, KS_SCREEN_WIDTH, 300)];
    //self.weatherView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.weatherView];
    self.weatherView.hidden = YES;
    self.weatherView.alpha = 0.9;
    //weatherView.alpha = 0.9;
}

-(UIView *)customRightButtonView {
    self.rightItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    [self.rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    [self.rightItem addTarget:self action:@selector(rightButtonOnClickEventHandler:) forControlEvents:UIControlEventTouchUpInside];
    return self.rightItem;
}
-(void)rightButtonOnClickEventHandler:(id)sender {
    if (showWeathRoom == YES) {
        showWeathRoom = NO;
        self.weatherView.hidden = YES;
        [UIView animateWithDuration:0.1 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI * 5);
            
        } completion:^(BOOL finished) {
            [self.rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        }];
    } else {
        [self.rightItem setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];
        showWeathRoom = YES;
        self.weatherView.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, -M_1_PI * 6);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.rightItem.transform = CGAffineTransformRotate(self.rightItem.transform, M_1_PI );
            }];
        }];
    }
}

-(void) addController {
    for (int i = 0; i < 8; i++) {
        
        
//        UIView * viewController = [[UIView alloc]init];
//        viewController.backgroundColor = [UIColor redColor];
//        viewController.frame = CGRectMake(KS_SCREEN_WIDTH * i, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT);
//        [self.pageScrollerView addSubview:viewController];
        
        //判断该类 是否存在
        Class className = NSClassFromString(self.viewControllerNames[i]);
        
        UIViewController * vc1 = [[className alloc]init];
        vc1.view.frame = CGRectMake(KS_SCREEN_WIDTH * i, 0, KS_SCREEN_WIDTH, KS_SCREEN_HEIGHT - 49);
        [self.pageScrollerView addSubview:vc1.view];
        vc1.title = self.viewControllerNames[i];
        [self addChildViewController:vc1];
    }
    self.pageScrollerView.contentSize = CGSizeMake(KS_SCREEN_WIDTH * 8, KS_SCREEN_HEIGHT-64);
    self.pageScrollerView.pagingEnabled = YES;
}

-(void) addtitleLabel {
    CGFloat width = 0;
    for (int i=0; i < 8; i++) {
        
        
        CGSize titleSize = [self sizeForTitle:self.titleArray[i] withFont:[UIFont systemFontOfSize:19]];
        GBTitleLabel * titleLable = [[GBTitleLabel alloc]init];
        titleLable.text = self.titleArray[i];
        titleLable.frame = CGRectMake(width, 5, titleSize.width, titleSize.height);
        titleLable.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.titleScrollerView addSubview:titleLable];
        titleLable.tag = i;
        titleLable.userInteractionEnabled = YES;
        [titleLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)]];
        width +=titleSize.width;
        
    }
    self.titleScrollerView.contentSize = CGSizeMake(width, 0);
}

- (CGSize)sizeForTitle:(NSString *)title withFont:(UIFont *)font
{
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil];
    
    return CGSizeMake(titleRect.size.width,
                      titleRect.size.height);
}

-(void)titleLabelClick:(UIGestureRecognizer *)recognizer {
    GBTitleLabel * title = (GBTitleLabel *) recognizer.view;
    CGFloat offsetX = title.tag * self.pageScrollerView.frame.size.width;
    CGFloat offsety = self.pageScrollerView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsety);
    [self.pageScrollerView setContentOffset:offset animated:YES];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/KS_SCREEN_WIDTH;
    GBTitleLabel * titlelabel = (GBTitleLabel *)self.titleScrollerView.subviews[index];
    CGFloat offsetX = titlelabel.center.x - self.titleScrollerView.frame.size.width * 0.5;
    CGFloat offsetMax = self.titleScrollerView.contentSize.width - KS_SCREEN_WIDTH;
    if (offsetX < 0 ) {
        offsetX = 0;
    } else if(offsetX > offsetMax) {
        offsetX = offsetMax;
    }
    
    CGPoint offpoi = CGPointMake(offsetX, self.titleScrollerView.contentOffset.y);
    [self.titleScrollerView setContentOffset:offpoi animated:YES];
    
//    [self.titleScrollerView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if (idx != index) {
//            GBTitleLabel *temlabel = self.titleScrollerView.subviews[idx];
//            temlabel.scale = 0.0;
//        }
//    }];
    
}
/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    GBTitleLabel *labelLeft = self.titleScrollerView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.titleScrollerView.subviews.count-1) {
        GBTitleLabel *labelRight = self.titleScrollerView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
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
