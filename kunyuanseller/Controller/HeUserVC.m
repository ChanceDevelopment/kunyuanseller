//
//  HeUserVC.m
//  kunyuanseller
//
//  Created by HeDongMing on 16/8/15.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeUserVC.h"
#import "HeBaseTableViewCell.h"
#import "UIButton+Bootstrap.h"
#import "TKTextFieldAlertViewController.h"
#import "HeShopActivityVC.h"
#import "HeFinanceAccountVC.h"
#import "HeManageAnalyseVC.h"
#import "HeGoodsManageVC.h"
#import "HeHistoryOrderVC.h"
#import "HeUserCommentVC.h"

#define USERHEADTAD 200
#define USERNAMETAG 300
#define USERPHONETAG 400
#define SELLTOTALTAG 500
#define ORDERTOTALTAG 600

@interface HeUserVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)NSArray *shopInfoArray;

@end

@implementation HeUserVC
@synthesize tableview;
@synthesize shopInfoArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"我的";
        [label sizeToFit];
        self.title = @"我的";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)initializaiton
{
    [super initializaiton];
    shopInfoArray = @[@[@"店铺信息",@"外卖体验店",@"留下西溪路256好",@"18888888888",@"店铺简介",@"店铺公告",@"营业时间"]];
}
- (void)initView
{
    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:tableview];
    
    CGFloat headH = 400;
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headH)];
    headerview.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = headerview;
    
    CGFloat headBgH = 130;
    UIView *userHeadBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headBgH)];
    userHeadBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]];
    [headerview addSubview:userHeadBg];
    
    CGFloat imageW = 50;
    CGFloat imageH = imageW;
    CGFloat imageX = 20;
    CGFloat imageY = (headBgH - imageH) / 2.0;
    UIImageView *userHead = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    userHead.image = [UIImage imageNamed:@"userDefalut_icon"];
    [headerview addSubview:userHead];
    userHead.layer.borderWidth = 1.0;
    userHead.layer.borderColor = [UIColor whiteColor].CGColor;
    userHead.layer.masksToBounds = YES;
    userHead.layer.cornerRadius = imageW / 2.0;
    [userHeadBg addSubview:userHead];
    
    NSString *name = @"外卖体验店";
    CGFloat nameX = imageW + imageX + 5;
    CGFloat nameY = imageY;
    CGFloat nameW = SCREENWIDTH - nameX - 10;
    CGFloat nameH = imageH / 2.0;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = name;
    nameLabel.font = [UIFont systemFontOfSize:16.0];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [userHeadBg addSubview:nameLabel];
    
    nameY = nameY + nameH;
    NSString *phone = @"18888888888";
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.text = [NSString stringWithFormat:@"电话: %@",phone];
    phoneLabel.font = [UIFont systemFontOfSize:16.0];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    [userHeadBg addSubview:phoneLabel];
    
    CGFloat tipH = 80;
    
    CGFloat totalMoneyX = 0;
    CGFloat totalMoneyH = 30;
    CGFloat totalMoneyY = (tipH - 2 * totalMoneyH) / 2.0 + CGRectGetMaxY(userHeadBg.frame);
    CGFloat totalMoneyW = SCREENWIDTH / 2.0;
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalMoneyX, totalMoneyY, totalMoneyW, totalMoneyH)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.font = [UIFont systemFontOfSize:17.0];
    moneyLabel.text = @"￥92";
    moneyLabel.tag = SELLTOTALTAG;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:moneyLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalMoneyX, CGRectGetMaxY(moneyLabel.frame), totalMoneyW, totalMoneyH)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.text = @"今日销售总额";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:titleLabel];
    
    
    
    UILabel *moneyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel.frame), totalMoneyY, totalMoneyW, totalMoneyH)];
    moneyLabel1.backgroundColor = [UIColor clearColor];
    moneyLabel1.textColor = [UIColor blackColor];
    moneyLabel1.font = [UIFont systemFontOfSize:17.0];
    moneyLabel1.text = @"2";
    moneyLabel1.tag = ORDERTOTALTAG;
    moneyLabel1.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:moneyLabel1];
    
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLabel.frame), CGRectGetMaxY(moneyLabel1.frame), totalMoneyW, totalMoneyH)];
    titleLabel1.backgroundColor = [UIColor clearColor];
    titleLabel1.textColor = [UIColor grayColor];
    titleLabel1.font = [UIFont systemFontOfSize:17.0];
    titleLabel1.text = @"今日有效订单";
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    [headerview addSubview:titleLabel1];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel1.frame), SCREENWIDTH, 10)];
    sepLine.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    [headerview addSubview:sepLine];
    
    CGFloat functionH = 100;
    CGFloat functionX = 0;
    CGFloat functionY = CGRectGetMaxY(sepLine.frame);
    CGFloat functionW = SCREENWIDTH;
    UIView *functionBgView = [[UIView alloc] initWithFrame:CGRectMake(functionX, functionY, functionW, functionH)];
    functionBgView.userInteractionEnabled = YES;
    functionBgView.backgroundColor = [UIColor whiteColor];
    functionBgView.userInteractionEnabled = YES;
    [headerview addSubview:functionBgView];
    
    NSArray *icon_titleArray = @[@[@"店铺活动",@"财务对账",@"经营分析"],@[@"商品管理",@"历史订单",@"用户评价"]];
    NSArray *icon_ImageArray = @[@[@"icon_home_activity",@"icon_home_reconciliation",@"icon_home_analysis"],@[@"icon_home_administration",@"icon_home_history",@"icon_home_evaluate"]];
    [self addButtonToView:functionBgView withImage:icon_ImageArray andTitle:icon_titleArray];
    
    headH = CGRectGetMaxY(functionBgView.frame);
    CGRect headFrame = headerview.frame;
    headFrame.size.height = headH;
    headerview.frame = headFrame;
    tableview.tableHeaderView = headerview;
    
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    footerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    tableview.tableFooterView = footerview;
    footerview.userInteractionEnabled = YES;
    
    UIButton *logOutButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, SCREENWIDTH - 40, 40)];
    [logOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logOutButton dangerStyle];
    [logOutButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [footerview addSubview:logOutButton];
    [logOutButton addTarget:self action:@selector(logOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:logOutButton];
}

//添加按钮
- (void)addButtonToView:(UIView *)buttonBG withImage:(NSArray *)imagearray andTitle:(NSArray *)nameArray
{
    CGFloat viewW = buttonBG.frame.size.width;
    CGFloat viewH = buttonBG.frame.size.height;
    NSInteger buttonCountRow = [(NSArray *)[imagearray objectAtIndex:0] count];
    NSInteger buttonCountColumn = [imagearray count];
    CGFloat buttonX = 20;
    CGFloat buttonHDistance = 40;
    CGFloat buttonVDistance = 10;
    CGFloat buttonY = 10;
    CGFloat buttonW = (viewW - (buttonCountRow - 1) * buttonHDistance - 2 * buttonX) / ((CGFloat)buttonCountRow);
    CGFloat buttonH = buttonW * 3 / 2.0;
    
    CGFloat bgY = 0;
    
    for (int i = 0; i < [nameArray count]; i++) {
        for (int j = 0; j < [(NSArray *)[imagearray objectAtIndex:i] count]; j++) {
            NSString *imagename = imagearray[i][j];
            UIImage *image = [UIImage imageNamed:imagename];
            UIImageView *subImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, buttonW, buttonW)];
            subImage.image = image;
            UIImageView *iconImage = [[UIImageView alloc] init];
            [iconImage addSubview:subImage];
            iconImage.backgroundColor = [UIColor whiteColor];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(buttonX + j * buttonHDistance + j * buttonW, buttonY + i * buttonVDistance + i * buttonH, buttonW, buttonH);
            button.tag = i * [(NSArray *)[imagearray objectAtIndex:i] count] + j;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttonBG addSubview:button];
            
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            label.frame = CGRectMake(0, buttonH - 20, buttonW, 20);
            label.text = [[nameArray objectAtIndex:i] objectAtIndex:j];
            label.textAlignment = NSTextAlignmentCenter;
            [button addSubview:label];
            
            iconImage.frame = button.frame;
            [buttonBG addSubview:iconImage];
            [buttonBG addSubview:button];
            bgY = button.frame.origin.y + button.frame.size.height + buttonY;
            
        }
        
    }
    CGRect frame = buttonBG.frame;
    frame.size.height = bgY;
    buttonBG.frame = frame;
}

- (void)buttonClick:(UIButton *)sender
{
    NSArray *viewControllerArray = @[@"HeShopActivityVC",@"HeFinanceAccountVC",@"HeManageAnalyseVC",@"HeGoodsManageVC",@"HeHistoryOrderVC",@"HeUserCommentVC"];
    NSString *viewControllerName = viewControllerArray[sender.tag];
    id myViewControllerObj = [[NSClassFromString(viewControllerName) alloc] init];
    if ([myViewControllerObj isKindOfClass:[UIViewController class]]) {
        UIViewController *myViewController = (UIViewController *)myViewControllerObj;
        myViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myViewController animated:YES];
    }
}

- (void)logOutButtonClick:(UIButton *)sender
{
    NSLog(@"logOutButtonClick");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [shopInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [shopInfoArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeSettingCell";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeBaseTableViewCell *cell = (HeBaseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.text = shopInfoArray[section][row];
    if (row == 0) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        
        NSArray *subTitleArray = @[@"",@"名称",@"地址",@"联系方式",@"",@"",@""];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        if (row == 3) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        CGFloat subTitleW = 100;
        CGFloat subTitleY = 0;
        CGFloat subTitleH = cellsize.height;
        CGFloat subTitleX = SCREENWIDTH - subTitleW - 30;
        UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleW, subTitleH)];
        subTitleLabel.textColor = [UIColor grayColor];
        subTitleLabel.textAlignment = NSTextAlignmentRight;
        subTitleLabel.font = [UIFont systemFontOfSize:13.0];
        subTitleLabel.text = subTitleArray[row];
        [cell addSubview:subTitleLabel];
    }
    
    return cell;
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (row == 3) {
        return;
    }
    NSArray *subTitleArray = @[@[@"",@"店铺名称",@"店铺地址",@"联系方式",@"店铺简介",@"店铺公告",@"营业时间"]];
    NSString *defaultText = subTitleArray[section][row];
    TKTextFieldAlertViewController *textFieldAlertView = [[TKTextFieldAlertViewController alloc] initWithTitle:@"请输入" placeholder:defaultText];
    [textFieldAlertView addButtonWithTitle:@"确定"  block:^(NSUInteger index) {
        
    }];
    [textFieldAlertView addButtonWithTitle:@"取消" block:^(NSUInteger index) {
        
    }];
    [textFieldAlertView show];
//    NSArray *viewControllerArray = @[@[@"",@""]];
//    NSString *viewControllerName = viewControllerArray[section][row];
//    id controllerObj = [[NSClassFromString(viewControllerName) alloc] init];
//    if ([controllerObj isKindOfClass:[UIViewController class]]) {
//        UIViewController *viewController = (UIViewController *)controllerObj;
//        viewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    headerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    return headerview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
