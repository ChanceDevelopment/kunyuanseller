//
//  HeGoodsManageCell.m
//  kunyuanseller
//
//  Created by Tony on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeGoodsManageCell.h"

@implementation HeGoodsManageCell
@synthesize bannerImage;
@synthesize nameLabel;
@synthesize contentLabel;
@synthesize priceLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellSize:cellSize];
    if (self) {
        CGFloat imageX = 10;
        CGFloat imageY = 10;
        CGFloat imageH = cellSize.height - 2 * imageY;
        CGFloat imageW = 80;
        bannerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comonDefaultImage"]];
        bannerImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
        bannerImage.contentMode = UIViewContentModeScaleAspectFill;
        bannerImage.layer.masksToBounds = YES;
        bannerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:bannerImage];
        
        CGFloat nameX = CGRectGetMaxX(bannerImage.frame) + 5;
        CGFloat nameY = imageY;
        CGFloat nameH = 20;
        CGFloat nameW = SCREENWIDTH - nameX - 10;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.text = @"红烧肉";
        nameLabel.numberOfLines = 0;
        nameLabel.font = [UIFont systemFontOfSize:15.0];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:nameLabel];
        
        CGFloat priceX = CGRectGetMaxX(bannerImage.frame) + 5;
        CGFloat priceH = 20;
        CGFloat priceY = cellSize.height - imageY - priceH;
        CGFloat priceW = SCREENWIDTH - priceX - 10;
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, priceW, priceH)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor colorWithRed:83.0 / 255.0 green:202.0 / 255.0 blue:196.0 / 255.0 alpha:1.0];
        priceLabel.text = @"￥10.00";
        priceLabel.font = [UIFont systemFontOfSize:13.0];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceLabel];
        
        CGFloat contentX = CGRectGetMaxX(bannerImage.frame) + 5;
        CGFloat contenH = CGRectGetMinY(priceLabel.frame) - CGRectGetMaxY(nameLabel.frame);
        CGFloat contenY = CGRectGetMaxY(nameLabel.frame);
        CGFloat contenW = SCREENWIDTH - contentX - 10;
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contenY, contenW, contenH)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor blackColor];
        priceLabel.numberOfLines = 0;
        priceLabel.text = @"红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉红烧肉";
        priceLabel.font = [UIFont systemFontOfSize:13.0];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceLabel];
    }
    return self;
}

@end
