//
//  HeOrderManagementCell.h
//  kunyuanseller
//
//  Created by Tony on 16/6/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseTableViewCell.h"

@interface HeOrderManagementCell : HeBaseTableViewCell
@property(strong,nonatomic)UIView *orderBgView;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UILabel *priceLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize;

@end
