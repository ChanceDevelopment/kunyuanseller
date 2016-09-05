//
//  HeChargeBackOrderCell.h
//  kunyuanseller
//
//  Created by HeDongMing on 16/9/5.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseTableViewCell.h"

@interface HeChargeBackOrderCell : HeBaseTableViewCell
@property(strong,nonatomic)UIView *orderBgView;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UILabel *priceLabel;

@property(strong,nonatomic)NSDictionary *orderDict;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;

@end
