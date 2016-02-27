//
//  HomeContentTable.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/1.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HomeContentTable.h"
#import "HomeContentTableCellTableViewCell.h"

@interface HomeContentTable() <UITableViewDataSource, UITableViewDelegate>
@property (atomic, strong) NSArray <Topic *> *tops;

@end

@implementation HomeContentTable

- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[HomeContentTableCellTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"headCell"];
    }
    return self;
}

- (void)setHeaderBoxMaxY:(CGFloat)headerBoxMaxY {
    [self setContentOffset:CGPointMake(0, self.numOneCellheight - headerBoxMaxY)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.tops.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? _numOneCellheight : [HomeContentTableCellTableViewCell selfHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        [cell setBackgroundColor:[UIColor whiteColor]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (self.tops) {
            [((HomeContentTableCellTableViewCell *)cell) setTopic:[self.tops objectAtIndex:indexPath.row]];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeContentTableCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([_scrollProtocl conformsToProtocol:@protocol(TableViewOtherProtocol)] &&
        [_scrollProtocl respondsToSelector:@selector(tableView:didSelectCell:)]) {
        [_scrollProtocl tableView:self didSelectCell:cell];
    }
}

/**
 *  设置最新资讯的数据模型
 *
 *  @param topic
 */
- (void)setTopic:(NSArray<Topic *> *)topic {
    _tops = topic;
    [self reloadData];
}
/**
 *  设置其他的编号(仅在预加载没成功时调用)
 *
 *  @param scene 编号 作为key
 *  @param dict  存放的容器
 */
- (void)setTopicWithScene:(NSString *)scene SaveDict:(NSDictionary *)dict {
    
    [RecommendModel onet_initSelfandnetWithExtend:scene Complete:^(NSArray<Topic *> *topic) {
        [dict setValue:topic forKey:scene];
        _tops = topic;
        [self reloadData];
    } andFail:^(BaseModel *model) {
        _tops = nil;
        [self reloadData];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_scrollProtocl conformsToProtocol:@protocol(TableViewOtherProtocol)] &&
        [_scrollProtocl respondsToSelector:@selector(tableView:scrollViewDidScroll:)]) {
        [_scrollProtocl tableView:self scrollViewDidScroll:scrollView.contentOffset];
    }
}

@end
