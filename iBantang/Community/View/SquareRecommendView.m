//
//  SquareRecommendView.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/19.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SquareRecommendView.h"
#import "SquareRecommendViewCell.h"
#import "SquareModel.h"

@interface SquareRecommendView() <UICollectionViewDelegate, UICollectionViewDataSource>{
    
}

@property (nonatomic, strong)NSMutableArray <UIButton *> *buttons;
@property (nonatomic, strong)UIView *markeView;
@property (nonatomic, strong)UICollectionView *contentCollection;

@property (nonatomic, strong) NSArray<Module_Elements *> *module_elements;

@end

@implementation SquareRecommendView

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

/* 初始化 */
- (void)initialization {
    
    __weak __typeof(self)weakSelf = self;

    //选择栏部分
    UIView *header = [UIView new];
    [header setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf);
        make.height.equalTo(@44);
        make.right.top.equalTo(weakSelf);
    }];
    
    _buttons = [NSMutableArray new];
    UIButton *lastButton;
    for (int index = 0; index < 4; index ++) {
        UIButton *button = [UIButton new];
        [button addTarget:self action:@selector(clickTitlebutton:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitleColor:[UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:13.f];
        [header addSubview:button];
        [_buttons addObject:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(header);
            make.height.equalTo(header);
            if (lastButton) {
                make.width.equalTo(lastButton);
            }
        }];
        
        if (!lastButton) {
            [button setTitleColor:OCTHEMECOLOR forState:(UIControlStateNormal)];
            button.selected = YES;
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(header);
            }];
        } else if (index < 3){
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right);
            }];
        } else {
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right);
                make.right.equalTo(header);
            }];
        }
        lastButton = button;
    }
    
    UIView *headerLine = [UILabel new];
    [headerLine setBackgroundColor:OCLINE];
    [header addSubview:headerLine];
    [headerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(header);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(header);
    }];

    _markeView = [UIView new];
    [_markeView setBackgroundColor:OCTHEMECOLOR];
    [header addSubview:_markeView];
    [_markeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@3);
        make.width.equalTo(lastButton.mas_width).multipliedBy(0.55);
        make.bottom.equalTo(header);
        make.centerX.equalTo([_buttons objectAtIndex:0].mas_centerX);
    }];
    
    // 内容部分
    _contentCollection = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [collection registerClass:[SquareRecommendViewCell class] forCellWithReuseIdentifier:@"cell"];
        collection.showsHorizontalScrollIndicator = NO;
        [collection setBackgroundColor:[UIColor whiteColor]];
        collection.pagingEnabled = YES;
        collection.bounces = YES;
        collection.dataSource = self;
        collection.delegate = self;
        [self addSubview:collection];
        collection;
    });

    [_contentCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(header.mas_bottom);
        make.left.equalTo(weakSelf);
        make.width.equalTo(weakSelf);
        make.height.mas_equalTo(KSCREEN_WIDTH / 3 * 2);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentCollection.mas_bottom);
    }];
}

- (void)clickTitlebutton:(UIButton *)button {
    
    if (button.selected) {
        return;
    }
    for (UIButton *temp in _buttons) {
        if (temp != button && temp.selected) {
            temp.selected = NO;
            [temp setTitleColor:[UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0] forState:(UIControlStateNormal)];
        }
    }
    __weak __typeof(self)weakSelf = self;
    
    [button setTitleColor:OCTHEMECOLOR forState:(UIControlStateNormal)];
    button.selected = YES;
    
    [_markeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@3);
        make.width.equalTo(button.mas_width).multipliedBy(0.55);
        make.bottom.equalTo([button superview]);
        make.centerX.equalTo(button.mas_centerX);
    }];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        [weakSelf layoutIfNeeded];
    }];
    
    
    [_contentCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[_buttons indexOfObject:button] inSection:0]
                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

-  (void)setModel:(NSArray<Module_Elements *> *)arr {
    self.module_elements = arr;
    
    for (UIButton *button in _buttons) {
        [button setTitle:[arr objectAtIndex:[_buttons indexOfObject:button]].title forState:(UIControlStateNormal)];
    }
    [_contentCollection reloadData];
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareRecommendViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setModel:[self.module_elements objectAtIndex:indexPath.row].elements];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self clickTitlebutton:[_buttons objectAtIndex:((int)(scrollView.contentOffset.x / scrollView.frame.size.width))]];
}

@end
