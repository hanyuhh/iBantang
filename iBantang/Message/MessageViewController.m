//
//  MessageViewController.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/18.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *dataSource;
    NSArray *imageSource;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MessageViewController

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
    [self o_setTitle:@"消息"];
    self.navBarTitle.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:19];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    __weak __typeof(self)weakSelf = self;
    
    _table = [UITableView new];
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    dataSource = @[@"新的粉丝", @"新的评论", @"新的喜欢", @"新的奖励", @"新的通知"];
    imageSource = @[@"ic_personal_new_fans", @"ic_personal_new_comment", @"ic_personal_new_like", @"ic_personal_new_reward", @"ic_personal_new_notify"];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (![cell viewWithTag:100]) {
        UIImageView *itemImage;
        UILabel *titleLabel;
        
        itemImage = [UIImageView new];
        itemImage.tag = 100;
        [cell addSubview:itemImage];
        titleLabel = [UILabel new];
        titleLabel.font = [UIFont fontWithName:@"PingFang TC" size:14.f];
        titleLabel.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
        titleLabel.tag = 101;
        [cell addSubview:titleLabel];
        
        [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(10);
            make.centerY.equalTo(cell);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell);
            make.left.equalTo(itemImage.mas_right).offset(10);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 50 - 0.5, KSCREEN_WIDTH - 5, 0.5)];
        [line setBackgroundColor:OCLINE];
        [cell addSubview:line];
        
        UIImageView *arrow = [UIImageView new];
        arrow.image = [UIImage imageNamed:@"ic_arrow_right_gray"];
        [cell addSubview:arrow];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell);
            make.right.equalTo(cell).offset(-10);
            make.size.mas_equalTo(CGSizeMake(arrow.image.size.width / 3 * 2, arrow.image.size.height / 3 * 2));
        }];
    }
    UIImageView *itemImage = [cell viewWithTag:100];
    UILabel *titleLabel = [cell viewWithTag:101];
    itemImage.image = [UIImage imageNamed:[imageSource objectAtIndex:indexPath.row]];
    [itemImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(itemImage.image.size.width / 4 * 3,
                                         itemImage.image.size.height / 4 * 3));
    }];
    titleLabel.text = [dataSource objectAtIndex:indexPath.row];
    [titleLabel sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
