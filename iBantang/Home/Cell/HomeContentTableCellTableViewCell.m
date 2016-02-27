//
//  HomeContentTableCellTableViewCell.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/2.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "HomeContentTableCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeContentTableCellTableViewCell() {
    
}
@property (nonatomic, strong) UIImageView *tagImage;
@property (nonatomic, strong) UILabel     *likeNumber;
@property (nonatomic, strong) UILabel     *titleLabel;

@end

@implementation HomeContentTableCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

/* 初始化 */
- (void)initialization {
    
    __weak __typeof(self)weakSelf = self;

    _titlePic = [UIImageView new];
    [_titlePic setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0]];
    [self addSubview:_titlePic];
    
    [_titlePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf);
        make.width.equalTo(weakSelf);
        make.height.equalTo(weakSelf.mas_width).multipliedBy(426.f / 800.f);
    }];
    
    _tagImage                 = [UIImageView new];
    [self addSubview:_tagImage];

    _titleLabel               = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor     = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    _titleLabel.font          = [UIFont fontWithName:@"PingFang TC" size:15];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titlePic.mas_bottom);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(weakSelf);
        make.height.equalTo(@30);
    }];
    UIView *bottomBox = [UIView new];
    [self addSubview:bottomBox];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_main_home_topic_like"]];
    [bottomBox addSubview:image];
    
    _likeNumber = [UILabel new];
    _likeNumber.textAlignment = NSTextAlignmentCenter;
    _likeNumber.textColor     = [UIColor lightGrayColor];
    _likeNumber.font          = [UIFont fontWithName:@"PingFang TC" size:13];
    [bottomBox addSubview:_likeNumber];
    
    [bottomBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.centerX.equalTo(weakSelf);
        make.height.equalTo(@25);
    }];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomBox);
        make.left.equalTo(bottomBox);
    }];
    
    [_likeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomBox);
        make.right.equalTo(bottomBox);
        make.left.equalTo(image.mas_right).offset(5);
    }];
}
/**
 *  最新专题
 *
 *  @param topic 数据模型
 */
- (void)setTopic:(Topic *)topic {
    
    _topic = topic;
    
//    _tagImage.image = [UIImage imageNamed:topic.islike ? @"ic_main_home_topic_collect" : @"ic_main_home_topic_new"];
    _tagImage.image = [UIImage imageNamed:arc4random() % 2 == 1 ? @"ic_main_home_topic_collect" : @"ic_main_home_topic_new"];
    [_tagImage o_size:CGSizeMake(_tagImage.image.size.width / 1.2f,
                                 _tagImage.image.size.height / 1.2f)];
    
    [_titlePic sd_setImageWithURL:([NSURL URLWithString:topic.pic])];
    
    _titleLabel.text = topic.title;
    _likeNumber.text = topic.likes;
}

/**
 *  返回自己的高度
 *
 *  @return
 */
+ (CGFloat)selfHeight {
    return 426.f / 800.f * KSCREEN_WIDTH + 30 + 25;
}
@end
