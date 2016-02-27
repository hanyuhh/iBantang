//
//  DarouselView.m
//  DarouselDemo
//
//  Created by cloudtopxm on 16/1/19.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "DarouselView.h"

@interface DarouselView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    CGFloat bottomheight;//bottom高度
}

@property (nonatomic, strong) UICollectionView    *collectionView;
@property (nonatomic, strong) UIView              *backgroudView;
@property (nonatomic, strong) PagePageSizeControl *pageControl;
@property (nonatomic, strong) NSArray <Banner *>  *dataSources; //top轮播图数据
@property (atomic, strong   ) NSMutableDictionary *images;//轮播图片缓存
@property (nonatomic, strong) NSTimer             *timer; //定时器
@property (assign, atomic   ) NSInteger           second; //计时
@property (nonatomic, strong) CAShapeLayer        *shapeLayer;//弧形
@property (nonatomic, strong) NSArray <Banner_Bottom_Element *>  *bottomdataSources; //bottomView数据
@property (nonatomic, strong) NSMutableArray <UIView *>  *bottomViews; //bottomView数据


@end

@implementation DarouselView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self o_setFrame:self.frame];
}
/**
 *  统一布局
 *
 *  @param frame
 */
- (void)o_setFrame:(CGRect)frame {
    
    if (self.backgroudView && self.collectionView && self.pageControl && self.dataSources && self.bottomViews) {
        
        self.backgroudView.frame = CGRectMake(0, 0, frame.size.width, frame.size.width * 0.5);
        self.collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.width * 0.5);
        [self.collectionView reloadData];
        
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint:CGPointMake(0, self.backgroudView.frame.size.height)];
        [path addLineToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.backgroudView.frame.size.width, 0)];
        [path addLineToPoint:CGPointMake(self.backgroudView.frame.size.width, self.backgroudView.frame.size.height)];
        [path addQuadCurveToPoint:CGPointMake(0, self.backgroudView.frame.size.height) controlPoint:CGPointMake(self.backgroudView.frame.size.width / 2, CGRectGetMinY(self.pageControl.frame) - 15)];
        self.shapeLayer.path = path.CGPath;
        
        CGSize size = [self.pageControl sizeForNumberOfPages:self.dataSources.count];
        self.pageControl.frame = CGRectMake((frame.size.width - size.width) / 2,
                                            frame.size.width * 0.5 - size.height / 2,
                                            size.width,
                                            size.height / 2);

        //buttomViews
        UIView *temp;
        for (UIView *view in self.bottomViews ) {
            temp = view;
            UIImageView *imageView = [view viewWithTag:100];
            UILabel *label = [view viewWithTag:101];
            
            view.frame = CGRectMake(self.frame.size.width / 4 * [self.bottomViews indexOfObject:view],
                                    CGRectGetMaxY(self.backgroudView.frame) + 10,
                                    self.frame.size.width / 4,
                                    10);
            
            imageView.frame = CGRectMake((CGRectGetWidth(view.frame) - view.frame.size.width / 2) / 2,
                                         5,
                                         view.frame.size.width / 2,
                                         view.frame.size.width / 2);
            imageView.layer.cornerRadius = view.frame.size.width / 4;
            imageView.layer.masksToBounds = YES;
            
            label.frame = CGRectMake(0,
                                     CGRectGetMaxY(imageView.frame) + 5,
                                     view.frame.size.width,
                                     23);
            //设置最终高度
            view.frame = CGRectMake(view.frame.origin.x,
                                    view.frame.origin.y,
                                    view.frame.size.width,
                                    CGRectGetMaxY(label.frame));
        }
        
        //根据宽度只适应高度
        if (temp && self.frame.size.height != CGRectGetMaxY(temp.frame) + 10) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(temp.frame) + 10);
            if (self.heightBlock) {
                self.heightBlock(CGRectGetMaxY(temp.frame) + 10);
            }
        }
    }
}


#pragma mark - 
/* 初始化 */
- (void)initialization {
    
    self.layer.masksToBounds = YES;
    
    if (self.backgroudView) {
        return;
    }
    bottomheight = 84;
    
    self.backgroudView = ({
        UIView *view = [UIView new];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:view];
        
        view;
    });
    // 轮播主视图
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [collection setBackgroundColor:[UIColor whiteColor]];
        collection.showsHorizontalScrollIndicator = NO;
        collection.pagingEnabled = YES;
        collection.bounces = YES;
        collection.dataSource = self;
        collection.delegate = self;
        [self.backgroudView addSubview:collection];
        
        collection;
    });
    // 页码显示
    self.pageControl = ({
        PagePageSizeControl *page = [PagePageSizeControl new];
        page.hidden = YES;
        page.currentPage = 0;
        page.currentPageIndicatorTintColor = [UIColor redColor];
        page.pageIndicatorTintColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
        [self addSubview:page];
        page;
    });
    // 弧形遮罩
    self.shapeLayer = ({
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        self.backgroudView.layer.mask = shapeLayer;
        shapeLayer;
    });
    
    //bottomView
    self.bottomViews = ({
        NSMutableArray *array = [NSMutableArray new];
        
        for (int x = 0; x < 4; x ++) {
            UIView *view = [UIView new];
            [self addSubview:view];
            [array addObject:view];
            
            UIImageView *imageView = [UIImageView new];
            imageView.tag = 100;
            [imageView setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]];
            [view addSubview:imageView];
            
            UILabel *label = [UILabel new];
            label.tag = 101;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
            label.font = [UIFont fontWithName:@"PingFang TC" size:12.5f];
            [view addSubview:label];
        }
        array;
    });
    
    [self initPara];
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  初始化部分参数
 */
- (void)initPara {
    self.second = 0;
    self.maxSecond = 4;
    
    self.pageControl.numberOfPages = self.dataSources ? self.dataSources.count : 0;
    self.images = self.images ? self.images : [NSMutableDictionary new];
}

/**
 *  设置数据源
 *
 *  @param dataArr    轮播图数据
 *  @param bottomArr  Bottom数据
 *  @param headingarr 选择视图数据
 */
- (void)setArray:(NSArray <Banner *> *) dataArr andBottomarr:(NSArray <Banner_Bottom_Element *> *) bottomArr;{
    
    self.dataSources        = dataArr;
    self.bottomdataSources  = bottomArr;
    [self initPara];
    [self imagesWithUrl];
    [self bottom_imageAndLabel];
    [self layoutSubviews];
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSources.count > 0 ? self.dataSources.count + 2 : 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (![cell viewWithTag:1000]) {
        UIImageView *imageview = [UIImageView new];
        [imageview setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]];
        imageview.tag = 1000;
        [cell addSubview:imageview];
    }
    
    NSString *urlString;
    if (indexPath.row == 0) {
        urlString = [self.dataSources lastObject].photo;
    } else if (indexPath.row == self.dataSources.count + 1) {
        urlString = [self.dataSources objectAtIndex:0].photo;
    } else {
        urlString = [self.dataSources objectAtIndex:indexPath.row - 1].photo;
    }
    [self imageWithUrl:urlString andView:(UIImageView *)[cell viewWithTag:1000]];
    ((UIImageView *)[cell viewWithTag:1000]).frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * 0.5);
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark - 定时器 与 轮播逻辑
/**
 *  定时器下一页
 */
- (void)nextPage {
    
    if (!self.dataSources || self.dataSources.count == 0) {
        return;
    }
    
    self.second ++;
    
    if (self.second == self.maxSecond) {
        self.second = 0;
        CGPoint point = self.collectionView.contentOffset;
        point.x -= (int)point.x % (int)self.collectionView.frame.size.width;
        point.x += self.collectionView.frame.size.width;
        [self.collectionView setContentOffset:point animated:YES];
    } else {
        self.second %= (self.maxSecond + 1);
    }
}

//停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.second = 0;
    
    int pag = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (pag == 0) {
        self.pageControl.currentPage = self.dataSources.count - 1;
    } else if (pag == self.dataSources.count + 1) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = pag - 1;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    
    if (point.x <= 0) {
        point.x = scrollView.contentSize.width - scrollView.frame.size.width * 2;
        [scrollView setContentOffset:point];
    } else if (point.x >= scrollView.contentSize.width - scrollView.frame.size.width) {
        point.x = scrollView.frame.size.width;
        [scrollView setContentOffset:point];
    }
}

//滚动动画停止时执行,使用代码改变contentOffset时执行
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];

}
//开始手动触摸滚蛋
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.second = 0;
}
//手离开屏幕
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.second = 0;
}

#pragma mark - 轮播图图片缓存
/**
 *  通过URLStr从网络中下载图片, 然后将下载的Image存入字典中
 *
 *  @param urlStr    图片Url
 *  @param imageView 需要赋值的控件
 */
- (void)imageWithUrl:(NSString *)urlStr andView:(UIImageView *)imageView {
    
    UIImage *temp = [self.images objectForKey:urlStr];
    if (temp) {
        imageView.image = temp;
        return;
    } else if(imageView.image) {
        imageView.image = nil;

    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL:url options:(NSDataReadingUncached) error:&error];
        UIImage *image = [UIImage imageWithData: data];
        
        if (error) {
            
        } else {
            //将此image存起来
            [self.images setObject:image forKey:urlStr];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        }
    });
}

#pragma mark - banner_bottom_image
- (void)bottom_imageAndLabel{
    
    if (!self.bottomdataSources) {
        return;
    }
    
    //buttomViews
    for (UIView *view in self.bottomViews ) {
        UIImageView *imageView = [view viewWithTag:100];
        UILabel *label = [view viewWithTag:101];

        label.text = [self.bottomdataSources objectAtIndex:[self.bottomViews indexOfObject:view]].title;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *url = [NSURL URLWithString:[self.bottomdataSources objectAtIndex:[self.bottomViews indexOfObject:view]].photo];
            NSError *error;
            NSData *data = [NSData dataWithContentsOfURL:url options:(NSDataReadingUncached) error:&error];
            UIImage *image = [UIImage imageWithData: data];
            
            if (error) {
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            }
        });
    }
}

/**
 *  提前缓存好所有图片
 */
- (void)imagesWithUrl {
    
    for (Banner *ban in self.dataSources) {

        NSURL *url = [NSURL URLWithString:ban.photo];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error;
            NSData *data = [NSData dataWithContentsOfURL:url options:(NSDataReadingUncached) error:&error];
            UIImage *image = [UIImage imageWithData: data];
            
            if (!error) {
                //将此image存起来
                [self.images setObject:image forKey:ban.photo];
            }
        });
    }
}

/**
 *  计算高度
 *
 *  @return height
 */
+ (CGFloat)selfHeight {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return width / 2 + 10 + 5 + width / 4 / 2 + 5 + 23 + 10;
}

@end

@implementation PagePageSizeControl

- (void)setCurrentPage:(NSInteger)currentPage {
    
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 4;
        size.width = 4;
        subview.layer.cornerRadius = 2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        
        if (subviewIndex == self.currentPage) [subview setBackgroundColor:self.currentPageIndicatorTintColor];
        else [subview setBackgroundColor:self.pageIndicatorTintColor];
        
        if (self.hidden) {
            [UIView animateWithDuration:0.25 animations:^{
                self.hidden = NO;
            }];
        }
    }
}

@end


