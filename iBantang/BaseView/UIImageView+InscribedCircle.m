//
//  UITableView+InscribedCircle.m
//  GraphicsDemo
//
//  Created by cloudtopxm on 16/3/3.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "UIImageView+InscribedCircle.h"
#import <objc/message.h>

@implementation UIImageView (InscribedCircle)

@dynamic markView;

- (UIImageView *)markView {
    return objc_getAssociatedObject(self, @selector(markView));
}

- (void)setMarkView:(UIImageView *)view {
    objc_setAssociatedObject(self, @selector(markView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  将图片设置成圆形
 *
 *  @param color 背景颜色
 */
- (void)jo_InscribedCircleWidthBackgroud:(UIColor *)color {
    
    __weak typeof(self) weakSelf = self;
    
    UIImage *image = [UIImageView imageDrawWithsize:self.frame.size backGroudColor:color];
    if (!image) { return; }
    
    if (!self.markView) {
        [self setMarkView:[UIImageView new]];
        [self addSubview:self.markView];
    }
    self.markView.image = image;
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

/**
 *  将图片设置成圆形
 *
 */
- (void)jo_InscribedCircle {

}



/**
 *  生成镂空内切圆的Image
 *
 *  @param size           矩形大小
 *  @param backgroudColor 矩形颜色
 *
 *  @return 镂空内切圆的矩形Image
 */
+ (UIImage *)imageDrawWithsize:(CGSize)size backGroudColor:(UIColor *)backgroudColor {
    
    if ((size.height == 0 && size.width != 0) || (size.width == 0 && size.height != 0)) {
        return nil;
    }
    
    CGFloat scalae;
    if (size.width == size.height) {
        size.width = size.height = [UIScreen mainScreen].bounds.size.width;
        scalae = 1;
    } else {
        scalae = size.width / size.height;
        CGSize temp = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / scalae);
        size = temp;
    }
    
    NSMutableArray <NSDictionary *> *jo_inscribedCircle = [[[NSUserDefaults standardUserDefaults] objectForKey:@"jo_inscribedCircle"] mutableCopy];
    if (!jo_inscribedCircle) {
        jo_inscribedCircle = [NSMutableArray new];
    }
    
    NSString *key = [NSString stringWithFormat:@"%f-%@", scalae, backgroudColor];
    UIImage  *image = nil;
    for (NSDictionary *dict in jo_inscribedCircle) {
        if ([dict objectForKey:key]) {
            image = [UIImage imageWithData:[dict objectForKey:key]];
            break;
        }
    }
    
    if (image) {
        return image;
    } else {
        // 生成图片
        CGFloat minWidth = MIN(size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextAddRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
        CGMutablePathRef roundedRectPath = CGPathCreateMutable();
        CGPathAddRoundedRect(roundedRectPath,
                             NULL,
                             CGRectMake(0, (size.height - minWidth) / 2, minWidth, minWidth),
                             minWidth / 2,
                             minWidth / 2);
        CGContextAddPath(UIGraphicsGetCurrentContext(), roundedRectPath);
        [backgroudColor setFill];
        CGContextEOFillPath(UIGraphicsGetCurrentContext());
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGPathRelease(roundedRectPath);
        
        // 储存到NSUserDefaults
        NSDictionary *dict = [NSDictionary dictionaryWithObject:UIImagePNGRepresentation(image) forKey:key];
        [jo_inscribedCircle addObject:dict];
        // 设置最大储存上限
        if (jo_inscribedCircle.count > 15) {
            [jo_inscribedCircle removeObjectAtIndex:0];
        }
        [[NSUserDefaults standardUserDefaults] setObject:jo_inscribedCircle forKey:@"jo_inscribedCircle"];
        
        return image;
    }
}

@end
