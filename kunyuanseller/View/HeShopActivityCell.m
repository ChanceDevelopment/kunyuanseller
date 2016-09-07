//
//  HeShopActivityCell.m
//  kunyuanseller
//
//  Created by Tony on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeShopActivityCell.h"

@implementation HeShopActivityCell
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize discountLabel;
@synthesize stateLabel;
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
        CGFloat nameX = 10;
        CGFloat nameH = 30;
        CGFloat nameY = 5;
        CGFloat nameW = cellSize.width - 2 * nameX - 60;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"iPhone";
        nameLabel.font = [UIFont systemFontOfSize:15.0];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:nameLabel];
        
        stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 80, 10, 80, 20)];
        stateLabel.backgroundColor = [UIColor redColor];
        stateLabel.textColor = [UIColor whiteColor];
        stateLabel.text = @"活动进行中";
        stateLabel.font = [UIFont systemFontOfSize:13.0];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:stateLabel];
        
        CGFloat timeX = 10;
        CGFloat timeH = 30;
        CGFloat timeY = CGRectGetMaxY(nameLabel.frame);
        CGFloat timeW = cellSize.width - 2 * timeX;
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.text = @"活动时间: 2016/08/09 - 2016/10/25";
        timeLabel.font = [UIFont systemFontOfSize:15.0];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLabel];
        
        CGFloat discountX = 10;
        CGFloat discountH = 30;
        CGFloat discountY = CGRectGetMaxY(timeLabel.frame);
        CGFloat discountW = cellSize.width - 2 * discountX;
        discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(discountX, discountY, discountW, discountH)];
        discountLabel.backgroundColor = [UIColor clearColor];
        discountLabel.textColor = [UIColor blackColor];
        discountLabel.text = @"优惠折扣: 5";
        discountLabel.font = [UIFont systemFontOfSize:15.0];
        discountLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:discountLabel];
    }
    return self;
}

@end
