//
//  PublishViewController.m
//  iBantang
//
//  Created by djangolee on 16/2/22.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "PhotoGroudView.h"
#import "PublishViewController.h"

@interface PublishViewController () <PhotoGroudViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (atomic , strong) NSMutableArray <NSDictionary <NSString *, NSMutableArray <ALAsset *> *> *> *groupArray;
@property (nonatomic , strong) ALAssetsLibrary*library ;

@property (nonatomic, strong) PhotoGroudView *tabbarView;

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray <UIImage *> *dataSource;

@end

@implementation PublishViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    __weak __typeof(self)weakSelf = self;
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((KSCREEN_WIDTH - 20) / 3, (KSCREEN_WIDTH - 20) / 3);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collection setBackgroundColor:[UIColor whiteColor]];
    _collection.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _collection.showsHorizontalScrollIndicator = NO;
    _collection.bounces = YES;
    _collection.dataSource = self;
    _collection.delegate = self;
    [self.view addSubview:_collection];
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    _tabbarView = [PhotoGroudView new];
    _tabbarView.delegate = self;
    [self.view addSubview:_tabbarView];
    [_tabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view);
    }];
    [self getImgs];
    
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (![cell viewWithTag:1000]) {
        UIImageView *imageView = [UIImageView new];
        imageView.tag = 1000;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }
    UIImageView *imageView = [cell viewWithTag:1000];
    imageView.image = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma MARK PhotoGroudViewDelegate
- (void)view:(UIView *)view backButton:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)view:(UIView *)view didSelectRow:(NSInteger)index groupAtArray:(NSMutableArray<ALAsset *> *)arr {
    
    __weak __typeof(self)weakSelf = self;
    
    dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(t, ^{
        
        if (self.dataSource) {
            [self.dataSource removeAllObjects];
        } else {
            self.dataSource = [NSMutableArray array];
        }
        
        for (ALAsset *asset in arr) {
            CGImageRef imgRef = [asset thumbnail];
            UIImage *image = [UIImage imageWithCGImage:imgRef];
            [self.dataSource addObject:image];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIView *temp = [weakSelf.collection snapshotViewAfterScreenUpdates:YES];
            [weakSelf.collection addSubview:temp];
            
            [temp mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf.collection);
            }];
            [weakSelf.collection reloadData];
            
            [UIView animateWithDuration:0.25 animations:^{
                temp.alpha = 0;
            } completion:^(BOOL finished) {
                [temp removeFromSuperview];
            }];
            
        });

    });
}
/**
 *  获取手机相册内容
 */
-(void)getImgs{
    
    __weak __typeof(self)weakSelf = self;
    
    dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(t, ^{
        
        weakSelf.groupArray = [NSMutableArray array];
        weakSelf.library = [ALAssetsLibrary new];
        
        [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop1) {
            if (group) {
                __block NSMutableArray <ALAsset *> *arr = [NSMutableArray new];
                NSMutableDictionary <NSString *, NSMutableArray <ALAsset *> *> *assetDict = [NSMutableDictionary dictionary];
                [assetDict setValue:arr forKey:[group valueForProperty:ALAssetsGroupPropertyName]];
                [weakSelf.groupArray addObject:assetDict];
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop2) {
                    if (result) {
                        [arr addObject:result];
                    }
                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (group) {
                    weakSelf.tabbarView.groupArray = weakSelf.groupArray;
                }
            });
        } failureBlock:^(NSError *error) {
            
        }];
    });
}

@end
