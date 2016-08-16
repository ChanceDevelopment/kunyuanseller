//
//  HeOrderManagementCell.m
//  kunyuanseller
//
//  Created by Tony on 16/6/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeOrderManagementCell.h"
#import "UIButton+Bootstrap.h"
#import "MLLabel+Size.h"

#define TextLineHeight 1.2f

@implementation HeOrderManagementCell
@synthesize orderBgView;
@synthesize timeLabel;
@synthesize nameLabel;
@synthesize phoneLabel;
@synthesize addressLabel;
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
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
        
        CGFloat viewX = 10;
        CGFloat viewY = 10;
        CGFloat viewW = cellSize.width - 2 * viewX;
        CGFloat viewH = cellSize.height - 2 * viewY;
        
        orderBgView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        orderBgView.backgroundColor = [UIColor whiteColor];
        orderBgView.layer.cornerRadius = 5.0;
        orderBgView.layer.masksToBounds = YES;
        [self addSubview:orderBgView];
        
        CGFloat iconX = 10;
        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconX, 20, 30, 30)];
        iconLabel.backgroundColor = [UIColor redColor];
        iconLabel.textColor = [UIColor whiteColor];
        iconLabel.font = [UIFont systemFontOfSize:17.0];
        iconLabel.text = @"新";
        iconLabel.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:iconLabel];
        
        CGFloat titleX = 0;
        CGFloat titleY = 10;
        CGFloat titleH = 30;
        CGFloat titleW = viewW;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = APPDEFAULTORANGE;
        titleLabel.text = @"订单未处理";
        titleLabel.font = [UIFont systemFontOfSize:18.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:titleLabel];
        
        CGFloat timeX = 0;
        CGFloat timeY = titleY + titleH;
        CGFloat timeH = 20;
        CGFloat timeW = viewW;
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = APPDEFAULTORANGE;
        timeLabel.text = @"下单时间: 06-13 11:30";
        timeLabel.font = [UIFont systemFontOfSize:15.0];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:timeLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(timeLabel.frame) + 8, viewW - 20, 2)];
        line.backgroundColor = APPDEFAULTORANGE;
        [orderBgView addSubview:line];
        
        UIFont *textFont = [UIFont systemFontOfSize:16.0];
        CGFloat labelH = 35;
        //名字
        CGFloat nameX = iconX;
        CGFloat nameY = CGRectGetMaxY(line.frame) + 5;
        CGFloat nameH = labelH;
        CGFloat nameW = 150;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"何晓明（先生）：";
        nameLabel.font = textFont;
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:nameLabel];
        
        CGFloat nameLabelW = (viewW - iconX )/ 2.0;
        nameW = [MLLinkLabel getViewSizeByString:nameLabel.text maxWidth:nameLabelW font:textFont lineHeight:TextLineHeight lines:0].width;
        nameLabel.frame = CGRectMake(nameX, nameY, nameW, nameH);
        
        //电话
        CGFloat phoneX = CGRectGetMaxX(nameLabel.frame);
        CGFloat phoneY = nameY;
        CGFloat phoneH = labelH;
        CGFloat phoneW = (viewW - iconX )/ 2.0;;
        phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneX, phoneY, phoneW, phoneH)];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.textColor = APPDEFAULTORANGE;
        phoneLabel.text = @"13650707294";
        phoneLabel.font = textFont;
        phoneLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:phoneLabel];
        
        //地址
        CGFloat addressX = iconX;
        CGFloat addressY = CGRectGetMaxY(nameLabel.frame);
        CGFloat addressH = labelH;
        CGFloat addressW = viewW;
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressX, addressY, addressW, addressH)];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.text = @"地址：大柳树富海中心4号楼304";
        addressLabel.font = textFont;
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:addressLabel];
        
        //价格
        CGFloat priceX = iconX;
        CGFloat priceY = CGRectGetMaxY(addressLabel.frame);
        CGFloat priceH = labelH;
        
        UILabel *priceTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, 50, priceH)];
        priceTipLabel.backgroundColor = [UIColor clearColor];
        priceTipLabel.textColor = [UIColor blackColor];
        priceTipLabel.text = @"总计：";
        priceTipLabel.font = textFont;
        priceTipLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:priceTipLabel];
        
        priceX = CGRectGetMaxX(priceTipLabel.frame);
        CGFloat priceW = viewW;
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, priceW, priceH)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.text = @"8元";
        priceLabel.font = textFont;
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:priceLabel];
        
        CGFloat detailX = 30;
        CGFloat detailY = CGRectGetMaxY(priceLabel.frame) + 10;
        CGFloat detailW = viewW - 2 * detailX;
        CGFloat detailH = 40;
        UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, detailH)];
        [detailButton infoStyle];
        [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [detailButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor orangeColor] withImageSize:detailButton.frame.size] forState:UIControlStateNormal];
        [detailButton addTarget:self action:@selector(detailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [orderBgView addSubview:detailButton];
        
    }
    return self;
}


- (void)detailButtonClick:(UIButton *)button
{
    NSLog(@"button = %@",button);
}

@end
