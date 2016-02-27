//
//  HeadingView.m
//  iBantang
//
//  Created by cloudtopxm on 16/1/27.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HeadingView.h"

@interface HeadingView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UILabel *sizeLabel; //用来赋值计算cell大小
    NSInteger selectedRow;
    UICollectionViewCell *selecedCell;
}

@property (nonatomic, strong) NSArray <Category_Element *> *dataArr;
@property (nonatomic, strong) UIView                       *markeView;

@end

@implementation HeadingView

- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing     = 38;
    layout.minimumLineSpacing          = 0;
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces                        = YES;
        self.dataSource                     = self;
        self.delegate                       = self;
        
        self.markeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.markeView setBackgroundColor:OCTHEMECOLOR];
        [self addSubview:self.markeView];
    }
    
    return self;
}


- (void)setDataSourceArr:(NSArray <Category_Element *> *) dataSource {
    // 如果selecedCell 为空就认为是初始化
    if (selecedCell) {
        selecedCell.selected = NO;
        selecedCell = nil;
    }
    
    Category_Element *topE = [Category_Element new];
    topE.title = @"最新";
    
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:topE];
    [arr addObjectsFromArray:dataSource];
    
    self.dataArr = arr;
    
    [self reloadData];
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label             = [cell viewWithTag:1001];
    
    if (!label) {
    label                      = [UILabel new];
    label.tag                  = 1001;
    label.font                 = [UIFont fontWithName:@"PingFang TC" size:13];
    [cell addSubview:label];
    }

    label.text                 = [self.dataArr objectAtIndex:indexPath.row].title;
    CGSize size                = [label sizeThatFits:self.frame.size];
    label.frame                = CGRectMake(0, 0, size.width, self.frame.size.height);

    label.textColor            = cell.selected ? OCTHEMECOLOR : [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    //没有被选中的cell 默认第一个为选中
    if (!selecedCell) {
        if (indexPath.row == 0) {
            cell.selected = YES;
            selecedCell = cell;
            label.textColor = OCTHEMECOLOR;
            self.markeView.frame = CGRectMake((cell.frame.size.width - 33) / 2, 44 - 3, 33, 3);
        }
    }
    
    if(selectedRow == indexPath.row) {
        cell.selected = YES;
        selecedCell = cell;
        label.textColor = OCTHEMECOLOR;
        //红色标记
        [UIView animateWithDuration:0.25 animations:^{
            self.markeView.frame = CGRectMake((label.superview.frame.size.width - 33) / 2 + label.superview.frame.origin.x, 44 - 3, 33, 3);
        }];
    } else {
        label.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!sizeLabel) {
        sizeLabel      = [UILabel new];
        sizeLabel.font = [UIFont fontWithName:@"PingFang TC" size:13];
    }
    sizeLabel.text = [self.dataArr objectAtIndex:indexPath.row].title;
    
    return CGSizeMake([sizeLabel sizeThatFits:collectionView.frame.size].width, self.frame.size.height);
}

// 选择
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ((UILabel *)[selecedCell viewWithTag:1001]).textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    selecedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    UILabel *label  = [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:1001];
    label.textColor = OCTHEMECOLOR;
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.markeView.frame = CGRectMake((label.superview.frame.size.width - 33) / 2 + label.superview.frame.origin.x, 44 - 3, 33, 3);
    }];
    
    if (self.collectionViewView) {
        [self.collectionViewView scrollToItemAtIndexPath:indexPath
                                        atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
/**
 *  转到第几个标签
 *
 *  @param index
 */
- (void)gotoViewWithindex:(NSInteger)index {
    
    selectedRow = index;
    //获得选择
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    //文字颜色
    UILabel *label  = [cell viewWithTag:1001];
    label.textColor = OCTHEMECOLOR;
    //红色标记
    [UIView animateWithDuration:0.25 animations:^{
        self.markeView.frame = CGRectMake((label.superview.frame.size.width - 33) / 2 + label.superview.frame.origin.x, 44 - 3, 33, 3);
    }];
    cell.selected = YES;
    
    //移动
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    ((UILabel *)[selecedCell viewWithTag:1001]).textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    selecedCell.selected = NO;
    selecedCell = cell;
}

@end
