//
//  InventoryViewController.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "InventoryViewController.h"
#import "FeatureModel.h"    //详情模型
#import "ProductHeaderCellTableViewCell.h" //header
#import "ProductCellTableViewCell.h" //cell

@interface InventoryViewController () <UITableViewDataSource, UITableViewDelegate>{
    UIImageView *tempImageView;
    NSString *_ID;
    
    UILabel *label;
    NSMutableAttributedString * attributedString;
    NSMutableParagraphStyle * paragraphStyle;
}
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) FeatureModel *feModel;

@end

@implementation InventoryViewController

- (instancetype)initWithImage:(UIImageView *)imageView ID:(NSString *)ID {
    
    if (self = [super init]) {
        tempImageView = imageView;
        _ID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView {
    [super loadView];

    __weak __typeof(self)weakSelf = self;
    
    _table = [UITableView new];
    _table.dataSource = self;
    _table.delegate = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_table registerClass:[ProductCellTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_table registerClass:[ProductHeaderCellTableViewCell class] forCellReuseIdentifier:@"headerCell"];
    [self.view addSubview:_table];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self initModel];
    
    UIView *view = [UIView new];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    _headerView = [UIImageView new];
    [_headerView o_size:tempImageView.frame.size];
    _headerView.image = tempImageView.image;
    [view addSubview:_headerView];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT - _headerView.o_height)];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    _bottomView.layer.masksToBounds = YES;
    [view addSubview:_bottomView];
}

/* 初始化Model */
- (void)initModel {
    
    __weak __typeof(self)weakSelf = self;
    
    [FeatureModel onet_initWithID:_ID Complete:^(FeatureModel *model) {
        _feModel = model;
        [_table reloadData];
        
        UIView *view = [_table snapshotViewAfterScreenUpdates:YES];
        [_bottomView addSubview:view];
        [view o_origin:(CGPointMake(0, -_headerView.o_height))];
    
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.bottomView o_y:weakSelf.headerView.o_height - 30];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf.bottomView o_y:weakSelf.headerView.o_height];
            } completion:^(BOOL finished) {
                [weakSelf.headerView.superview removeFromSuperview];
            }];
        }];
        
    } andFail:^(BaseModel *model) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_feModel) {
        return section == 0 ? 1 : _feModel.data.product.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 64 + 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 44 + 64);
    
    UIView *headerView = [UIView new];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    headerView.frame = CGRectMake(0, 64, KSCREEN_WIDTH, 44);
    [view addSubview:headerView];
    
    UIButton *leftButton = [UIButton new];
    leftButton.frame = CGRectMake(0, 0, KSCREEN_WIDTH / 2, 44);
    leftButton.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:14];
    [leftButton setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:(UIControlStateNormal)];
    [leftButton setTitle:@"半塘精选" forState:(UIControlStateNormal)];
    [headerView addSubview:leftButton];
    
    UIButton *rightButton = [UIButton new];
    rightButton.frame = CGRectMake(CGRectGetMaxX(leftButton.frame), 0, KSCREEN_WIDTH / 2, 44);
    rightButton.titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:14];
    [rightButton setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:(UIControlStateNormal)];
    [rightButton setTitle:@"用户推荐" forState:(UIControlStateNormal)];
    [headerView addSubview:rightButton];
    
    UIView *midLine = [UIView new];
    midLine.frame = CGRectMake(CGRectGetMaxX(leftButton.frame), 44 / 3, 0.7f, 44 / 3);
    [midLine setBackgroundColor:[UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:0.5]];
    [headerView addSubview:midLine];
    
    UIView *topLine = [UIView new];
    topLine.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 0.1);
    [topLine setBackgroundColor:OCLINE];
    [headerView addSubview:topLine];
    
    UIView *bottomLine = [UIView new];
    bottomLine.frame = CGRectMake(0, CGRectGetHeight(headerView.frame) - 0.3, KSCREEN_WIDTH, 0.3);
    [bottomLine setBackgroundColor:OCLINE];
    [headerView addSubview:bottomLine];
    
    UIView *titleLine = [UIView new];
    [titleLine setBackgroundColor:OCTHEMECOLOR];
    titleLine.frame = CGRectMake(KSCREEN_WIDTH / 10, CGRectGetHeight(headerView.frame) - 2, KSCREEN_WIDTH / 10 * 3, 2);
    [headerView addSubview:titleLine];
    
    leftButton.tag = 1001;
    rightButton.tag = 1002;
    titleLine.tag = 1003;
    
    [leftButton addTarget:self action:@selector(changeValuebutton:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightButton addTarget:self action:@selector(changeValuebutton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return view;
}

- (void)changeValuebutton:(UIButton *)button {
    
    UIView *titleLine   = [[button superview] viewWithTag:1003];
    [UIView animateWithDuration:0.25  animations:^{
        [titleLine o_x:button.o_x + KSCREEN_WIDTH / 10];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!label) {
        label = [UILabel new];
        label.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:15];
        label.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
        label.numberOfLines = 0;
        [label o_width:KSCREEN_WIDTH - 20];
        paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineHeightMultiple:1.4];
    }
    
    if (indexPath.section == 0) {
        return tempImageView.o_height + [ProductHeaderCellTableViewCell heightSelf:_feModel] - 64;
    } else {
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:[_feModel.data.product objectAtIndex:indexPath.row].desc];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle
                                 range:NSMakeRange(0, [[_feModel.data.product objectAtIndex:indexPath.row].desc length])];
        [label setAttributedText:attributedString];
        
        return [ProductCellTableViewCell heightSelf:[_feModel.data.product objectAtIndex:indexPath.row] label:label];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section == 0 ? @"headerCell" : @"cell"];
    
    if (indexPath.section == 0) {
        [((ProductHeaderCellTableViewCell *)cell) setPlaceholderImage:tempImageView model:_feModel];
        _picView = ((ProductHeaderCellTableViewCell *)cell).picView;
    } else {
        [((ProductCellTableViewCell *)cell) setModel:[_feModel.data.product objectAtIndex:indexPath.row] index:indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    //图片的拉伸效果
    if (offSetY <= 0) {
        CGFloat height = tempImageView.frame.size.height - offSetY;
        _picView.frame = CGRectMake((self.view.o_width - tempImageView.o_width * height / tempImageView.o_height) / 2,
                                    offSetY,
                                    tempImageView.o_width * height / tempImageView.o_height,
                                    height);
    }
    CGFloat headerHeight = tempImageView.o_height + [ProductHeaderCellTableViewCell heightSelf:_feModel];
    
    // 导航栏的淡入淡出
    if (!self.navBarTitle) {
        [self o_setTitle:@"购物清单"];
        self.navBarTitle.alpha = 0;
    }
    
    CGFloat alpha = offSetY / headerHeight;
    if (alpha < 0) {
        alpha = 0;
    } else if (alpha >1) {
        alpha = 1;
    }
    self.navBarTitle.alpha = alpha;
    [self.navigationController.navigationBar lt_setBackgroundColor:[OCTHEMECOLOR colorWithAlphaComponent:alpha]];
}

@end
