//
//  CommunityViewController.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "CommunityViewController.h"
#import "SquareRecommendView.h"
#import "SquareModel.h"
#import "SquareGroudView.h"

@interface CommunityViewController ()

@property (nonatomic, strong)SquareModel *squareModel;

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)SquareRecommendView *squareRecoView;
@property (nonatomic, strong)SquareGroudView *squareGroudView;
@property (nonatomic, strong)UIView *aboutView;

@end

@implementation CommunityViewController

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
    [self o_setTitle:@"广场"];
    [self o_setLeftBarButtom:[UIImage imageNamed:@"ic_main_home_search"]];
    self.navBarTitle.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:19];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    __weak __typeof(self)weakSelf   = self;

    // 广场
    _scrollView = ({
        UIScrollView *view       = [UIScrollView new];
        view.layer.masksToBounds = YES;
        view.alpha               = 0;
        view.hidden              = YES;
        [weakSelf.view addSubview:view];
        
        UIView *container = [UIView new];
        [view addSubview:container];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
            make.width.equalTo(view);
        }];
        
        _squareRecoView = [SquareRecommendView new];
        [container addSubview:_squareRecoView];
        [_squareRecoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(container);
            make.width.equalTo(container);
        }];
        
        
        UIView *maginView = [UIView new];
        [maginView setBackgroundColor:OCTHEMEBACKGROUDCOLOR];
        [container addSubview:maginView];
        [maginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.squareRecoView.mas_bottom);
            make.left.equalTo(container);
            make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH, 10));
        }];
        
        _squareGroudView = [SquareGroudView new];
        [container addSubview:_squareGroudView];
        [_squareGroudView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(container);
            make.top.equalTo(maginView.mas_bottom);
            make.left.equalTo(container);
        }];
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_squareGroudView.mas_bottom);
        }];
        
        view;
    });
    
    //关注
    _aboutView                      = [UIView new];
    _aboutView.layer.masksToBounds  = YES;
    _aboutView.alpha                = 0;
    _aboutView.hidden               = YES;
    [self.view addSubview:_aboutView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    [_aboutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    
    [self initRequestNet];
}

- (void)o_leftAction:(UIButton *)button {
    
}

- (void)initRequestNet {
    
    __weak __typeof(self)weakSelf = self;
    [SquareModel onet_initSelfandnetComplete:^(SquareModel *model) {
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.scrollView.hidden = NO;
            weakSelf.scrollView.alpha = 1;
            [weakSelf.squareRecoView setModel:model.data.module_elements];
            [weakSelf.squareGroudView setModel:model.data.rec_groups];
        }];
    } andFail:^(BaseModel *model) {
        
    }];
}

@end
