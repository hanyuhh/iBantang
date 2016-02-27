//
//  HomeViewController.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HomeViewController.h"
#import "DarouselView.h"        // 轮播图
#import "HeadingView.h"         // 标题选择View
#import "HomeContentTable.h"    // 首页table
#import "InventoryViewController.h" //购物清单界面
#import "HomeCoutoAnimated.h" //购物清单过场动画
#import "HomeContentTableCellTableViewCell.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TableViewOtherProtocol, CoutoAnimatedProtocol>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIView            *headerBox;
@property (nonatomic, assign) CGFloat           boxY;
@property (nonatomic, assign) CGPoint           tempPoint;
@property (nonatomic, strong) DarouselView      *darouseview;
@property (nonatomic, strong) HeadingView       *headingView;
@property (nonatomic, strong) HomeCoutoAnimated *homecouto;//转场动画
@property (nonatomic, strong) UIView            *keywindowView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self o_settabBarHidden:NO];
    [self tableView:nil scrollViewDidScroll:_tempPoint];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.headerBox o_y: _boxY];
}

- (void)loadView {
    [super loadView];

    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];

    [self o_setLeftBarButtom:[UIImage imageNamed:@"ic_main_home_search"]];
    [self o_setRightBarButtom:[UIImage imageNamed:@"ic_main_home_sign_in"]];
    [self o_setTitle:@"半塘"];
    self.navBarLeft.hidden = YES;
    self.navBarRight.hidden = YES;
    self.navBarTitle.alpha = 0;
    
    //
    __weak __typeof(self)weakSelf = self;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    
    self.headerBox = [UIView new];
    [_headerBox o_origin:CGPointMake(0, 0)];
    [_headerBox setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_headerBox];
    
    self.darouseview = [DarouselView new];
    [_headerBox addSubview:_darouseview];
    
    [self.darouseview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.headerBox).insets(UIEdgeInsetsMake(0, 0, 44, 0));
        make.width.equalTo(weakSelf.view);
        make.height.mas_equalTo([DarouselView selfHeight]);
    }];
    
    self.headingView = [HeadingView new];
    self.headingView.collectionViewView = self.collectionView;
    [_headerBox addSubview:self.headingView];
    [self.headingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.darouseview.mas_bottom);
        make.right.and.left.equalTo(weakSelf.headerBox);
        make.height.equalTo(@44);
    }];
    
    [self.headerBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.darouseview);
        make.bottom.equalTo(weakSelf.headingView);
    }];
    
    [self update];
}

- (void)o_rightAction:(UIButton *)button {
    
}

- (void)o_leftAction:(UIButton *)button {
    
}

#pragma mark -
/**
 *  拉取数据
 */
- (void)update {
    
    __weak __typeof(self)weakSelf = self;
    
    [RecommendModel onet_initSelfandnetComplete:^(RecommendModel *model) {
        weakSelf.dataModel = model;
        
        weakSelf.dataSouce = [NSMutableDictionary new];
        [weakSelf.dataSouce setObject:model.data.topic forKey:@"newHot"];
        [weakSelf downdataTopicWithExtendIndex:0];
        [self.darouseview setArray:model.data.banner andBottomarr:model.data.banner_bottom_element];
        [self.headingView setDataSourceArr:model.data.category_element];
        [weakSelf.collectionView reloadData];
    } andFail:^(BaseModel *model) {
        
    }];
}
/**
 *  预载数据
 *
 *  @param index
 */
- (void)downdataTopicWithExtendIndex:(int)index {
    __weak __typeof(self) weakSelf = self;
    if (index < self.dataModel.data.category_element.count) {
        NSString *scene = [self.dataModel.data.category_element objectAtIndex:index].extend;
        [RecommendModel onet_initSelfandnetWithExtend:scene Complete:^(NSArray<Topic *> *topic) {
            [weakSelf.dataSouce setObject:topic forKey:scene];
            [weakSelf downdataTopicWithExtendIndex:(index + 1)];
        } andFail:^(BaseModel *model) {
            [weakSelf downdataTopicWithExtendIndex:(index + 1)];
        }];
    } else {
    }
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataModel.data.category_element.count > 0 ? self.dataModel.data.category_element.count + 1 : 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (![cell viewWithTag:1000]) {
        HomeContentTable *table = [HomeContentTable new];
        table.separatorStyle    = UITableViewCellSeparatorStyleNone;
        table.tag               = 1000;
        table.numOneCellheight  = CGRectGetHeight(self.headerBox.frame);
        table.scrollProtocl     = self;
        [cell addSubview:table];
        
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }
    [(HomeContentTable *)[cell viewWithTag:1000] setHeaderBoxMaxY:CGRectGetMaxY(self.headerBox.frame)];

    NSString *scene = indexPath.row == 0 ? @"newHot" : [self.dataModel.data.category_element objectAtIndex:indexPath.row - 1].extend;
    if ([self.dataSouce objectForKey:scene]) {
        [((HomeContentTable *)[cell viewWithTag:1000]) setTopic:[self.dataSouce objectForKey:scene]];
    } else {
        [((HomeContentTable *)[cell viewWithTag:1000]) setTopicWithScene:scene SaveDict:_dataSouce];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}
//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.headingView gotoViewWithindex: (int)(scrollView.contentOffset.x / self.view.frame.size.width)];
}

/**
 *  UITableView 滚动代理
 *
 *  @param tableView
 *  @param point
 */
- (void)tableView:(UITableView *)tableView scrollViewDidScroll:(CGPoint)point {
    
    CGFloat alpha = point.y / (CGRectGetHeight(self.headerBox.frame) - 44 - 64);
    if (alpha >= 1) { alpha = 1; } else if (alpha <= 0) { alpha = 0; }
    if (alpha == 0) {
        self.navBarRight.hidden = YES;
        self.navBarLeft.hidden = YES;
    } else {
        self.navBarRight.hidden = NO;
        self.navBarLeft.hidden = NO;
    }
    [self.headerBox o_y:alpha == 1 ? -(CGRectGetHeight(self.headerBox.frame) - 44 - 64) : -point.y];
    _boxY = self.headerBox.o_y;
    [self.navigationController.navigationBar lt_setBackgroundColor:[OCTHEMECOLOR colorWithAlphaComponent:alpha]];
    self.navigationItem.leftBarButtonItem.customView.alpha = alpha;
    self.navigationItem.rightBarButtonItem.customView.alpha = alpha;
    self.navigationItem.titleView.alpha = alpha;
    _tempPoint = point;
}
/**
 *  点击某个cell时调用
 *
 *  @param tableView
 *  @param cell      点击的cell
 */
- (void)tableView:(UITableView *)tableView didSelectCell:(UITableViewCell *)cell {
    if (!_homecouto) {
        _homecouto                          = [[HomeCoutoAnimated alloc] initWithDuration:0.5f coutoType:(COUTOTYPEPUSH) delegate:self];
        self.navigationController.delegate  = _homecouto;
    }
    UIImageView *imageView                  = ((HomeContentTableCellTableViewCell *)cell).titlePic;
    CGRect rect                             = [imageView convertRect:imageView.bounds toView:self.view];
    [_homecouto setHeaderImageView:imageView toWindowsFrame:rect];

    InventoryViewController *viewController = [[InventoryViewController alloc] initWithImage:imageView
                                                                                          ID:((HomeContentTableCellTableViewCell *)cell).topic.ID];
    [self o_settabBarHidden:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  goto转场动画 (下面两句话由自己决定加在哪里)
 *
 *  [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
 *  [transitionContext completeTransition:YES];
 *
 *  @param transitionContext  过场上下文信息
 *  @param fromViewController
 *  @param toViewController
 *  @param containerView
 *  @param duration
 */
- (void)coutoAnimatedGotoOtherTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                      fromViewController:(UIViewController *)fromViewController
                        toViewController:(UIViewController *)toViewController
                           containerView:(UIView *)containerView
                                duration:(NSTimeInterval)duration {
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    _keywindowView = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:NO];
    UIView *backgroudView = [[UIView alloc] initWithFrame:containerView.bounds];
    [backgroudView setBackgroundColor:[UIColor whiteColor]];
    [containerView addSubview:backgroudView];
    [backgroudView addSubview:_keywindowView];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame        = _homecouto.toframe;
    imageView.image        = _homecouto.imageView.image;
    [containerView addSubview:imageView];
    
    [UIView animateWithDuration:duration animations:^{
        [imageView o_y:0];
        [self.navigationController.navigationBar lt_setBackgroundColor:[OCTHEMECOLOR colorWithAlphaComponent:0]];
        _keywindowView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroudView removeFromSuperview];
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}
/**
 *  diss转场动画 (下面两句话由自己决定加在哪里)
 *
 *  [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
 *  [transitionContext completeTransition:YES];
 *
 *  @param transitionContext  过场上下文信息
 *  @param fromViewController
 *  @param toViewController
 *  @param containerView
 *  @param duration
 */
- (void)coutoAnimatedComebackTransition:(id<UIViewControllerContextTransitioning>)transitionContext
                     fromViewController:(UIViewController *)fromViewController
                       toViewController:(UIViewController *)toViewController
                          containerView:(UIView *)containerView
                               duration:(NSTimeInterval)duration {

    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    UIView *backgroudView = [[UIView alloc] initWithFrame:containerView.bounds];
    [backgroudView setBackgroundColor:[UIColor whiteColor]];
    [containerView addSubview:backgroudView];
    [backgroudView addSubview:_keywindowView];
    
    UIImageView *imageView = [UIImageView new];
    [imageView o_size:_homecouto.toframe.size];
    imageView.image = _homecouto.imageView.image;
    [containerView addSubview:imageView];
    
    [UIView animateWithDuration:duration animations:^{
        [imageView o_y:KSCREEN_HEIGHT / 2];
        _keywindowView.alpha = 1;
        imageView.alpha = 0;
        [self tableView:nil scrollViewDidScroll:_tempPoint];
        
    } completion:^(BOOL finished) {
        [backgroudView removeFromSuperview];
        [imageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}
/**
 *  转到第几个标签
 *
 *  @param index
 */
- (void)gotoViewWithindex:(NSInteger)index {
    //移动
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
