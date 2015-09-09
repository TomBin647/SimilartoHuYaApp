//
//  GBScrollerPageViewController.m
//  SimilartoHuYaApp
//
//  Created by 高彬 on 15/9/9.
//  Copyright (c) 2015年 erweimashengchengqi. All rights reserved.
//

#import "GBScrollerPageViewController.h"
#import "GBTagTitleCell.h"
#import "GBPageCollectionCell.h"
#import "XBTagTitleModel.h"
#import "XBConst.h"

@interface GBScrollerPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView * tagCollectionView;//选择的标签
@property (nonatomic,strong) UICollectionViewFlowLayout * tagFlowLayout;

@property (nonatomic,strong) UICollectionView * pageCollectionView;//页面展示View
@property (nonatomic,strong) UICollectionViewFlowLayout * pageFlowlayout;

@property (nonatomic,strong) NSMutableArray *tagTitleModelArray; //标题模型数组

@property (nonatomic,strong) NSArray *displayClassNames; // 要展示的子控制器名称数组,如果只传一个则表示重复使用该控制器类
@property (nonatomic,assign) CGFloat tagViewHeight;   // 标签高度

@property (nonatomic,assign) NSIndexPath* selectedIndex;   // 记录tag当前选中的cell索引

@property (nonatomic,strong) NSMutableDictionary *viewControllersCaches;    // 控制器缓存

@property (nonatomic,strong) NSMutableDictionary *frameCaches;    /**< size缓存  */

@property (nonatomic,strong) NSTimer *graceTimer;

@property (nonatomic,strong) UIView *selectionIndicator;  /**< 选择指示器  */


@end

@implementation GBScrollerPageViewController

#pragma - mark LazyLoad
- (NSMutableArray *)tagTitleModelArray
{
    if (!_tagTitleModelArray) {
        _tagTitleModelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _tagTitleModelArray;
}

- (NSMutableDictionary *)viewControllersCaches
{
    if (!_viewControllersCaches) {
        _viewControllersCaches = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _viewControllersCaches;
}

- (NSMutableDictionary *)frameCaches
{
    if (!_frameCaches) {
        _frameCaches = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _frameCaches;
}

#pragma - mark getter&setter

- (void)setNormalTitleFont:(UIFont *)normalTitleFont
{
    _normalTitleFont = normalTitleFont;
    [self.tagTitleModelArray enumerateObjectsUsingBlock:^(XBTagTitleModel *obj, NSUInteger idx, BOOL *stop) {
        obj.normalTitleFont = normalTitleFont;
    }];
}
- (void)setSelectedTitleFont:(UIFont *)selectedTitleFont
{
    _selectedTitleFont = selectedTitleFont;
    [self.tagTitleModelArray enumerateObjectsUsingBlock:^(XBTagTitleModel *obj, NSUInteger idx, BOOL *stop) {
        obj.selectedTitleFont = selectedTitleFont;
    }];
}
- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    _normalTitleColor = normalTitleColor;
    [self.tagTitleModelArray enumerateObjectsUsingBlock:^(XBTagTitleModel *obj, NSUInteger idx, BOOL *stop) {
        obj.normalTitleColor = normalTitleColor;
    }];
}
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    [self.tagTitleModelArray enumerateObjectsUsingBlock:^(XBTagTitleModel *obj, NSUInteger idx, BOOL *stop) {
        obj.selectedTitleColor = selectedTitleColor;
    }];
}

- (void)setTagViewSectionInset:(UIEdgeInsets)tagViewSectionInset
{
    _tagViewSectionInset = tagViewSectionInset;
}

- (void)setTagItemSectionInset:(UIEdgeInsets)tagItemSectionInset
{
    _tagItemSectionInset = tagItemSectionInset;
}

- (void)setGraceTime:(NSTimeInterval)graceTime
{
    _graceTime = graceTime;
    [self.graceTimer setFireDate:[NSDate distantPast]];
}
- (NSTimer *)graceTimer
{
    
    if (self.graceTime) {
        if (!_graceTimer) {
            _graceTimer = [NSTimer timerWithTimeInterval:5.f target:self selector:@selector(updateViewControllersCaches) userInfo:nil repeats:YES];
            [_graceTimer setFireDate:[NSDate distantFuture]];
            [[NSRunLoop mainRunLoop] addTimer:_graceTimer forMode:NSDefaultRunLoopMode];
        }
        return _graceTimer;
    }
    return nil;
}

- (void)dealloc
{
    [self.graceTimer invalidate];
    self.graceTimer = nil;
}

- (void)updateViewControllersCaches
{
    NSDate *currentDate = [NSDate date];
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *tempDic = self.viewControllersCaches;
    
    
    [self.viewControllersCaches enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSDictionary *obj, BOOL *stop) {
        UIViewController *vc = [obj objectForKey:kCachedVCName];
        NSDate *cachedTime = [obj objectForKey:kCachedTime];
        NSInteger keyInteger = [key integerValue];
        NSInteger selectionInteger = weakSelf.selectedIndex.item;
        
        if (keyInteger != selectionInteger) {         //当前不是当前正在展示的cell
            NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:cachedTime];
            if (timeInterval >= weakSelf.graceTime) {
                //宽限期到了销毁控制器
                [tempDic removeObjectForKey:key];
                [vc.view removeFromSuperview];
                [vc removeFromParentViewController];
            }
        }
    }];
    self.viewControllersCaches = tempDic;
}


- (void)setSelectedIndex:(NSIndexPath *)selectedIndex
{
    
    _selectedIndex = selectedIndex;
}

- (UIView *)selectionIndicator
{
    if (!_selectionIndicator) {
        _selectionIndicator = [[UIView alloc]init];
        _selectionIndicator.backgroundColor = self.selectedTitleColor;
        [self.tagCollectionView addSubview:_selectionIndicator];
    }
    return _selectionIndicator;
}

-(void) setupDefaultProperties {
    self.normalTitleFont = [UIFont systemFontOfSize:13];
    self.selectedTitleFont = [UIFont systemFontOfSize:18];
    self.normalTitleColor = [UIColor darkGrayColor];
    self.selectedTitleColor = [UIColor redColor];
    self.tagViewSectionInset = UIEdgeInsetsZero;
    self.tagItemSectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tagItemSize = CGSizeZero;
}

- (void)convertKeyValue2Model:(NSArray *)titleArray
{
    
    [self.tagTitleModelArray removeAllObjects];
    for (int i = 0; i < titleArray.count; i++) {
        XBTagTitleModel *tag = [XBTagTitleModel modelWithtagTitle:titleArray[i] andNormalTitleFont:self.normalTitleFont andSelectedTitleFont:self.selectedTitleFont andNormalTitleColor:self.normalTitleColor andSelectedTitleColor:self.selectedTitleColor];
        [self.tagTitleModelArray addObject:tag];
    }
}
- (instancetype)initWithTitles:(NSArray *)titleArray andSubViewdisplayClassNames:(NSArray *)classNames andTagViewHeight:(CGFloat)tagViewHeight
{
    if (self = [super init]) {
        //初始化界面 需要最先初始化
        //设置默认值
        [self setupDefaultProperties];
        
        //将titleArray转换成模型Array
        [self convertKeyValue2Model:titleArray];
        
        //初始化两个CollectionView
        [self setUpCollection];
        //设置标签的高度
        self.tagViewHeight = tagViewHeight;
        //页面的数组
        self.displayClassNames = classNames;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tagCollectionView.frame = CGRectMake(0, 0, XBScreenWidth, self.tagViewHeight);
    self.pageCollectionView.frame = CGRectMake(0, self.tagViewHeight, XBScreenWidth, self.view.frame.size.height - self.tagViewHeight);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    self.selectedIndex = indexPath;
    [self.view layoutIfNeeded];
    
    NSLog(@"%@",self.view);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.leftBarButtonItem = nil;
    XBLog(@"%@",NSStringFromCGRect(self.pageCollectionView.frame));
    
    if (self.tagTitleModelArray.count != 0) {
        self.selectedIndex = [NSIndexPath indexPathForItem:0 inSection:0];
        [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:self.selectedIndex];
    }
    
}


-(void) setUpCollection {
    //初始化标签的布局
    UICollectionViewFlowLayout * tagFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    tagFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    tagFlowLayout.minimumInteritemSpacing = 0;
    tagFlowLayout.minimumLineSpacing = 0;
    tagFlowLayout.sectionInset = self.tagViewSectionInset;
    self.tagFlowLayout = tagFlowLayout;
    //初始化标签的View
    UICollectionView * tagCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:tagFlowLayout];
    [tagCollectionView registerClass:[GBTagTitleCell class] forCellWithReuseIdentifier:@"GBTagTitleCell"];
    tagCollectionView.backgroundColor = [UIColor whiteColor];
    tagCollectionView.showsHorizontalScrollIndicator = NO;
    tagCollectionView.dataSource = self;
    tagCollectionView.delegate = self;
    self.tagCollectionView = tagCollectionView;
    //设置初始化的 cell
    [self.view addSubview:self.tagCollectionView];
    
    //初始化页面布局
    UICollectionViewFlowLayout * pageFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    pageFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    pageFlowLayout.minimumLineSpacing = 0;
    pageFlowLayout.minimumInteritemSpacing = 0;
    self.pageFlowlayout = pageFlowLayout;
    
    
    //初始化页面的控件
    UICollectionView * pageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:pageFlowLayout];
    [pageCollectionView registerClass:[GBPageCollectionCell class] forCellWithReuseIdentifier:@"GBPageCollectionCell"];
    pageCollectionView.backgroundColor = [UIColor whiteColor];
    pageCollectionView.showsHorizontalScrollIndicator = NO;
    pageCollectionView.dataSource = self;
    pageCollectionView.delegate = self;
    pageCollectionView.pagingEnabled = YES;
    self.pageCollectionView = pageCollectionView;
    [self.view addSubview:self.pageCollectionView];

}


-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item;
    if ([self isTagView:collectionView]) {
        if (CGSizeEqualToSize(CGSizeZero,self.tagItemSize)) {
            CGRect cellFramCache;
            cellFramCache = [self getCachedFrameByIndexPath:indexPath];
            if (!CGRectEqualToRect(cellFramCache, CGRectZero)) {
                return cellFramCache.size;
            }
            
            XBTagTitleModel *tagTitleModel = self.tagTitleModelArray[index];
            NSString *title = tagTitleModel.tagTitle;
            //如果没有缓存 计算title的长度
            CGSize titleSize = [self sizeForTitle:title withFont:((tagTitleModel.normalTitleFont.pointSize >= tagTitleModel.selectedTitleFont.pointSize)?tagTitleModel.normalTitleFont:tagTitleModel.selectedTitleFont)];
            return CGSizeMake(titleSize.width + self.tagItemSectionInset.right + self.tagItemSectionInset.left, self.tagViewHeight);
        } else {
            return self.tagItemSize;
        }
    } else {
        return  collectionView.frame.size;
    }
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.tagTitleModelArray ? self.tagTitleModelArray.count:0;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item;
    if ([self isTagView:collectionView]) {
        GBTagTitleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GBTagTitleCell" forIndexPath:indexPath];
        XBTagTitleModel * tagTitleModel = [self.tagTitleModelArray objectAtIndex:index];
        
        if (iOS7x) {
            [self collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
        }
        [self saveCachedFrame:cell.frame ByIndexPath:indexPath];
        cell.tagTitleModel = tagTitleModel;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    } else {
        GBPageCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GBPageCollectionCell" forIndexPath:indexPath];
        if (iOS7x) {
            [self collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
        }
        return  cell;
    }
    return  nil;
}

//即将展示的cell ios8
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isTagView:collectionView]) {
        [cell setSelected:(self.selectedIndex.item == indexPath.item)?YES:NO];
    } else {
        NSString * displayClassName = (self.displayClassNames.count == 1)? [self.displayClassNames firstObject] : self.displayClassNames[indexPath.item];
        //判断该类 是否存在
        Class className = NSClassFromString(displayClassName);
        
        //取缓存
        UIViewController *cachedViewController = [self getCachedVCByIndexPath:indexPath];
        if (!cachedViewController) {   //如果缓存里不存在,生成新的VC,并加入缓存(如果缓存里存在,表明之前alloc过,直接使用 )
            cachedViewController = [[className alloc]init];
        }
        //更新缓存
        [self saveCachedVC:cachedViewController ByIndexPath:indexPath];
        [self addChildViewController:cachedViewController];
        [(GBPageCollectionCell*)cell configCellWithController:cachedViewController];
    }
}

//消失的cell
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isTagView:collectionView]) {          //tag
        cell.selected = NO;
    }
    else{                                               //page
        //从缓存中取出instaceController
        UIViewController *cachedViewController = [self getCachedVCByIndexPath:indexPath];
        
        if (!cachedViewController) {
            return;
        }
        
        //更新缓存时间
        [self saveCachedVC:cachedViewController ByIndexPath:indexPath];
        
        //从父控制器中移除
        [cachedViewController removeFromParentViewController];
        [cachedViewController.view removeFromSuperview];
    }
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isTagView:collectionView]) {

        
        [self updateSelectionIndicatorWithOldSelectedIndex:self.selectedIndex
                                            newNSIndexPath:indexPath];
        self.selectedIndex = indexPath;
        
        [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        [self.pageCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.pageCollectionView) {
        int index = scrollView.contentOffset.x /self.pageCollectionView.frame.size.width;
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self collectionView:self.tagCollectionView didSelectItemAtIndexPath:indexPath];
    }
}

- (void)updateSelectionIndicatorWithOldSelectedIndex:(NSIndexPath *)oldSelectedIndex
                                      newNSIndexPath:(NSIndexPath *)newSelectedIndex
{
    CGRect oldFrame = [self getCachedFrameByIndexPath:oldSelectedIndex];
    CGRect oldf = oldFrame;
    oldf.size.height = 2;
    oldf.origin.y = self.tagViewHeight - 2;
    oldFrame = oldf;
    
    CGRect newFrame = [self getCachedFrameByIndexPath:newSelectedIndex];
    CGRect newf = newFrame;
    newf.size.height = 2;
    newf.origin.y = self.tagViewHeight - 2;
    newFrame = newf;
    
    
    self.selectionIndicator.frame = oldFrame;
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.selectionIndicator.frame = newFrame;
    }];
    
}

- (void)saveCachedFrame:(CGRect)frame ByIndexPath:(NSIndexPath *)indexPath
{
    [self.frameCaches setObject:[NSValue valueWithCGRect:frame] forKey:@(indexPath.item)];
}


- (void)saveCachedVC:(UIViewController *)viewController ByIndexPath:(NSIndexPath *)indexPath
{
    NSDate *newTime =[NSDate date];
    NSDictionary *newCacheDic = @{kCachedTime:newTime,
                                  kCachedVCName:viewController};
    [self.viewControllersCaches setObject:newCacheDic forKey:@(indexPath.item)];
    
}
- (CGRect)getCachedFrameByIndexPath:(NSIndexPath *)indexPath
{
    NSValue *frameValue = [self.frameCaches objectForKey:@(indexPath.item)];
    return [frameValue CGRectValue];
}


- (UIViewController *)getCachedVCByIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cachedDic = [self.viewControllersCaches objectForKey:@(indexPath.item)];
    UIViewController *cachedViewController = [cachedDic objectForKey:@"kCachedVCName"];
    return cachedViewController;
}

//判断是哪个collection
- (BOOL)isTagView:(UICollectionView *)collectionView
{
    if (self.tagCollectionView == collectionView) {
        return YES;
    }
    return NO;
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
