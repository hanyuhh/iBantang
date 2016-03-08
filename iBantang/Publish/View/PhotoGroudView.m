//
//  PhotoGroudView.m
//  iBantang
//
//  Created by djangolee on 16/2/22.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "PhotoGroudView.h"

@interface PhotoGroudView() <UITableViewDataSource, UITableViewDelegate> {
    UIView *tabbarView;
    UIButton *titleView;
}

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UITableView *table;

@end

@implementation PhotoGroudView

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    __weak __typeof(self)weakSelf = self;
    
    self.layer.masksToBounds = YES;
    
    tabbarView = [UIView new];
    [tabbarView setBackgroundColor:OCTHEMECOLOR];
    [self addSubview:tabbarView];
    
    UIButton *backButton = [UIButton new];
    [backButton setTitle:@"取消" forState:(UIControlStateNormal)];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(cancelButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backButton];
    
    [tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(weakSelf);
        make.height.equalTo(@64);
    }];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tabbarView).offset(10);
        make.left.equalTo(tabbarView).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    // 标题
    titleView = [UIButton new];
    [titleView addTarget:self action:@selector(clickTitleView:) forControlEvents:(UIControlEventTouchUpInside)];
    [tabbarView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tabbarView).offset(10);
        make.centerX.equalTo(tabbarView);
    }];
    _title = [UILabel new];
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:19];
    [titleView addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleView);
    }];
    
    _table = [UITableView new];
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _table.delegate = self;
    _table.dataSource = self;
    [self setExtraCellLineHidden:_table];
    [self insertSubview:_table atIndex:0];
    
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf);
        make.height.equalTo(@88);
        make.bottom.equalTo(tabbarView);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.table);
    }];
    
}

- (void)setGroupArray:(NSMutableArray<NSDictionary<NSString *,NSMutableArray<ALAsset *> *> *> *)groupArray {
    
    _groupArray = groupArray;

    _title.text = [[[_groupArray lastObject] allKeys] objectAtIndex:0];
    [_title sizeToFit];
    [_table reloadData];
}

#pragma MARK UITABLEVIEW DELEGATE
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (![cell viewWithTag:1000]) {
        UIImageView *imageView = [UIImageView new];
        imageView.tag = 1000;
        imageView.layer.masksToBounds = YES;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [cell addSubview:imageView];
        UILabel *textLabel = [UILabel new];
        textLabel.tag = 1001;
        [cell addSubview:textLabel];
        UILabel *detailTextLabel = [UILabel new];
        detailTextLabel.tag = 1002;
        detailTextLabel.font = [UIFont systemFontOfSize:13.f];
        detailTextLabel.textColor = [UIColor lightGrayColor];
        [cell addSubview:detailTextLabel];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell);
            make.size.mas_equalTo(CGSizeMake(75, 75));
            make.left.equalTo(cell).offset(10);
        }];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell).offset(-15);
            make.left.equalTo(imageView.mas_right).offset(10);
        }];
        [detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textLabel.mas_bottom).offset(5);
            make.left.equalTo(imageView.mas_right).offset(10);
        }];
    }
    
    UIImageView *imageView = [cell viewWithTag:1000];
    UILabel *textLabel = [cell viewWithTag:1001];
    UILabel *detailTextLabel = [cell viewWithTag:1002];
    
    textLabel.text = [[[self.groupArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    [textLabel sizeToFit];
    
    detailTextLabel.text = [NSString stringWithFormat:@"%u张", [[self.groupArray objectAtIndex:indexPath.row] objectForKey:textLabel.text].count];
    [textLabel sizeToFit];
    
    if ([[self.groupArray objectAtIndex:indexPath.row] objectForKey:textLabel.text].count > 0) {
        
        ALAsset *asset = [[[self.groupArray objectAtIndex:indexPath.row] objectForKey:textLabel.text] objectAtIndex:0];
        
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];
        UIImage *image = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
        imageView.image = image;
        
    } else {
        imageView.image = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _title.text = [[[self.groupArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    [_title sizeToFit];
    
    [self clickTitleView:titleView];
    
    NSString *key = [[[self.groupArray objectAtIndex:indexPath.row] allKeys] objectAtIndex:0];
    
    if ([_delegate conformsToProtocol:@protocol(PhotoGroudViewDelegate)] &&
        [_delegate respondsToSelector:@selector(view:didSelectRow:groupAtArray:)]) {
        [_delegate view:self didSelectRow:indexPath.row groupAtArray:[[self.groupArray objectAtIndex:indexPath.row] objectForKey:key]];
    }
}

- (void)cancelButton:(UIButton *)button {
    if ([_delegate conformsToProtocol:@protocol(PhotoGroudViewDelegate)] &&
        [_delegate respondsToSelector:@selector(view:backButton:)]) {
        [_delegate view:self backButton:button];
    }
}

- (void)clickTitleView:(UIButton *)button {
    
    __weak __typeof(self)weakSelf = self;
    button.selected = !button.selected;

    if (button.selected) {
        [_table mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tabbarView.mas_bottom);
            make.width.equalTo(weakSelf);
            if (weakSelf.groupArray.count * 88 < KSCREEN_HEIGHT - 64) {
                make.height.mas_equalTo(weakSelf.groupArray.count * 88);
            } else {
                make.height.mas_equalTo(KSCREEN_HEIGHT - 64);
            }
        }];
    } else {
        [_table mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf);
            make.bottom.equalTo(tabbarView);
            if (weakSelf.groupArray.count * 88 < KSCREEN_HEIGHT - 64) {
                make.height.mas_equalTo(weakSelf.groupArray.count * 88);
            } else {
                make.height.mas_equalTo(KSCREEN_HEIGHT - 64);
            }
        }];
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.table layoutIfNeeded];
    }];
    
}

// 去掉TableView 多余的线
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
