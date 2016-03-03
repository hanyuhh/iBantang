//
//  ProductCellTableViewCell.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/15.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "ProductCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ProductCellTableViewCell() {
    
}

@property (nonatomic, strong) UIImageView    *indexView;
@property (nonatomic, strong) UILabel        *title;
@property (nonatomic, strong) UILabel        *content;
@property (nonatomic, strong) NSMutableArray *pics;
@property (nonatomic, strong) UILabel        *price;
@property (nonatomic, strong) UILabel        *likes;
@property (nonatomic, strong) NSMutableArray *likesUserheader;

@end

@implementation ProductCellTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
    }
    return self;
}

/* 初始化 */
- (void)initialization {
    if (_indexView) { return; }
    
    __weak __typeof(self)weakSelf = self;
    
    UIView *headerView = [UIView new];
    [self addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.width.equalTo(weakSelf);
        make.left.top.equalTo(weakSelf);
    }];
    
    //indexView
    _indexView = [UIImageView new];
    [headerView addSubview:_indexView];
    
    [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(10);
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(45.f / 3, 69.f / 3));
    }];
    
    _title = [UILabel new];
    _title.font = [UIFont fontWithName:@"PingFang TC" size:18];
    _title.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.indexView.mas_right).offset(15);
        make.top.equalTo(headerView);
        make.height.equalTo(headerView.mas_height);
    }];
    
    _content = [UILabel new];
    _content.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:15];
    _content.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    _content.numberOfLines = 0;
    _content.frame = CGRectMake(10, CGRectGetMaxY(headerView.frame), KSCREEN_WIDTH - 20, 0);
    
    [self addSubview:_content];
    
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(headerView.mas_bottom);
        make.width.equalTo(weakSelf).offset(-20);
    }];
    
    _pics = [NSMutableArray new];
    for (int index = 0 ; index < 2; index ++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.hidden = YES;
        [_pics addObject:imageView];
    }
    
    _price = [UILabel new];
    _price.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:14];
    _price.textColor = OCTHEMECOLOR;
    [self addSubview:_price];
    
    UIView *bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@120);
        make.width.equalTo(weakSelf);
        make.top.equalTo(weakSelf.price.mas_bottom);
        make.left.equalTo(weakSelf);
    }];
    
    UIView *topLine = [UIView new];
    topLine.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 0.3);
    [topLine setBackgroundColor:OCLINE];
    [bottomView addSubview:topLine];
    
    UIView *bottomLine = [UIView new];
    bottomLine.frame = CGRectMake(0, 70, KSCREEN_WIDTH, 0.3);
    [bottomLine setBackgroundColor:OCLINE];
    [bottomView addSubview:bottomLine];
    
    _likes = [UILabel new];
    _likes.textColor = [UIColor lightGrayColor];
    _likes.font = [UIFont systemFontOfSize:11.f];
    [_likes o_origin:(CGPointMake(10, 0))];
    [bottomView addSubview:_likes];
    
    _likesUserheader = [NSMutableArray new];
    UIImageView *lastHeaderView;
    int count = KSCREEN_WIDTH < 414 ? 8 : 11;
    
    for (int index = 0; index < count; index ++) {
        UIImageView *header = [UIImageView new];
        [header jo_InscribedCircleWidthBackgroud:[UIColor whiteColor]];
        [bottomView addSubview:header];
        
        [_likesUserheader addObject:header];
        
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView).offset(-20);
            make.height.equalTo(header.mas_width);
        }];
        
        if (!lastHeaderView) {
            [header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(bottomView).offset(6);
            }];
        } else {
            [header mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastHeaderView.mas_right).offset(6);
                make.width.equalTo(lastHeaderView);
                if (index == count - 1) {
                    make.right.equalTo(bottomView).offset(-6);
                }
            }];
        }
        if (index == count - 1) {
            UIImageView *arrow = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"ic_arrow_right_gray"]];
            [header addSubview:arrow];
            [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(header);
                make.size.mas_equalTo(CGSizeMake(20 / 2.2, 36 / 2.2));
            }];
        } else {
            
        }
        lastHeaderView = header;
    }
    
    
    UIView *maginView = [UIView new];
    [maginView setBackgroundColor:OCTHEMEBACKGROUDCOLOR];
    [self addSubview:maginView];
    [maginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom);
        make.left.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(KSCREEN_WIDTH, 10));
    }];
    
}

- (void)setModel:(FeatureProduct *)model index:(NSInteger)index {
    
    NSString *indexStr;
    if (index < 9) {
        indexStr = [NSString stringWithFormat:@"ind0%ld",(long)index + 1];
    } else {
        indexStr = [NSString stringWithFormat:@"ind%ld",(long)index + 1];
    }
    _indexView.image = [UIImage imageNamed:indexStr];
    
    // title
    _title.text = model.title;
    [_title sizeToFit];
    
    // content
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:model.desc];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineHeightMultiple:1.4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [model.desc length])];
    [_content setAttributedText:attributedString1];
    [_content o_sizeThatFits:(CGSizeMake(KSCREEN_WIDTH - 20, KSCREEN_HEIGHT))];
    
    // pic
    NSInteger different = model.pic.count - _pics.count;
    for (int index = 0; index < different; index ++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.hidden = YES;
        [_pics addObject:imageView];
    }
    
    __weak __typeof(self)weakSelf = self;
    UIImageView *lastView;
    for (UIImageView *imageView in _pics) {
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
        }];
        NSUInteger index = [_pics indexOfObject:imageView];
        if (index > model.pic.count - 1) {
            imageView.hidden = YES;
            continue;
        } else {
            imageView.hidden = NO;
        }
        
        Pic *pic = [model.pic objectAtIndex:index];
        [imageView sd_setImageWithURL:([NSURL URLWithString:[NSString stringWithFormat:@"http://bt.img.17gwx.com/%@", pic.p]])];
        CGSize size = CGSizeMake(KSCREEN_WIDTH - 20, (KSCREEN_WIDTH - 20) * pic.h / pic.w);
        
        if (!lastView) {
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(10);
                make.top.equalTo(weakSelf.content.mas_bottom).offset(10);
                make.size.mas_equalTo(size);
            }];
        } else {
            [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf).offset(10);
                make.top.equalTo(lastView.mas_bottom).offset(10);
                make.size.mas_equalTo(size);
            }];
        }
        
        lastView = imageView;
    }
    
    _price.text = [NSString stringWithFormat:@"参考价: ¥%@", model.price];
    [_price sizeToFit];
    [_price mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.top.equalTo(lastView ? lastView.mas_bottom : weakSelf.content.mas_bottom);
    }];
    
    _likes.text = [NSString stringWithFormat:@"%@人喜欢", model.likes];
    [_likes sizeToFit];
    [_likes o_height:20];
    
    NSUInteger count = model.likes_list.count;
    for (UIImageView *temp in _likesUserheader) {
        NSUInteger index = [_likesUserheader indexOfObject:temp];
        
        if (index < count && temp != [_likesUserheader lastObject]) {
            temp.hidden = NO;
            NSString *url = [NSString stringWithFormat:@"http://7te7t9.com2.z0.glb.qiniucdn.com/%@", [model.likes_list objectAtIndex:index].a];
            [temp sd_setImageWithURL:([NSURL URLWithString:url])];
        } else {
            if (temp != [_likesUserheader lastObject]) {
                temp.hidden = YES;
            }
        }
    }
}


+ (CGFloat)heightSelf:(FeatureProduct *)model label:(UILabel *)label {
    
    [label o_sizeThatFits:(CGSizeMake(label.o_width, KSCREEN_HEIGHT))];
    
    CGFloat height = 0.f;
    for (Pic *pic in model.pic) {
        height += ((KSCREEN_WIDTH - 20) * pic.h / pic.w + 10);
    }
    
    return 44 + label.o_height + height + 120 + 40 + 10;
}

@end
