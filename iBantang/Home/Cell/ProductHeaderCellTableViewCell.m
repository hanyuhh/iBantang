//
//  ProductHeaderCellTableViewCell.m
//  iBantang
//
//  Created by cloudtopxm on 16/2/16.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "ProductHeaderCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ProductHeaderCellTableViewCell()

@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, strong)FeatureModel *model;
@end

@implementation ProductHeaderCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialization];
    }
    return self;
}

/* 初始化 */
- (void)initialization {
    if (_picView) { return; }
    
    _picView = [UIImageView new];
    [self addSubview:_picView];
    
    _title = [UILabel new];
    _title.font = [UIFont fontWithName:@"PingFang TC" size:16];
    _title.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
    
    [self addSubview:_title];
    
    _content = [UILabel new];
    _content.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:14];
    _content.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    _content.numberOfLines = 0;
    [self addSubview:_content];
    
}

- (void)setPlaceholderImage:(UIImageView *)image model:(FeatureModel *)model {
    
    _model         = model;
    
    _picView.frame = CGRectMake(0, 0, image.o_width, image.o_height);
    _picView.image = image.image;
    _title.frame   = CGRectMake(10, CGRectGetMaxY(_picView.frame), KSCREEN_WIDTH - 20, 44);
    [_content o_width:KSCREEN_WIDTH - 20];
    [_content o_origin:(CGPointMake(10, CGRectGetMaxY(_title.frame)))];
    
    _title.text = _model.data.title;
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_model.data.desc];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineHeightMultiple:1.4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_model.data.desc length])];
    [_content setAttributedText:attributedString1];
    
    [_content o_sizeThatFits:(CGSizeMake(_content.o_width, KSCREEN_HEIGHT))];
}


+ (CGFloat)heightSelf:(FeatureModel *)model {
    
    UILabel *label = [UILabel new];
    label.font = [UIFont fontWithName:@"AmericanTypewriter-Light" size:14];
    label.textColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    label.numberOfLines = 0;
    [label o_width:KSCREEN_WIDTH - 20];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:model.data.desc];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineHeightMultiple:1.4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [model.data.desc length])];
    [label setAttributedText:attributedString1];
    
    [label o_sizeThatFits:(CGSizeMake(label.o_width, KSCREEN_HEIGHT))];
    
    return 44 + label.o_height;
}

@end
