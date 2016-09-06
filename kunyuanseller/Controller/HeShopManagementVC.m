//
//  HeShopManagementVC.m
//  kunyuanseller
//
//  Created by Tony on 16/6/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeShopManagementVC.h"
#import "HeShopManagementCell.h"
#import "UIButton+Bootstrap.h"
#import "TKAlertViewController.h"

#define SHOPSTATETAG 300

@interface HeShopManagementVC ()
{
    BOOL onBusiness;
}
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)NSArray *shopInfoArray;

@end

@implementation HeShopManagementVC
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
        label.text = @"门店管理";
        [label sizeToFit];
        self.title = @"门店管理";
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
    shopInfoArray = @[@"天天水果店",@"留下西溪路256号",@"店铺简介",@"店铺公告",@"营业时间"];
    onBusiness = NO;
}

- (void)initView
{
    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:tableview];
    
    CGFloat headH = 150;
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headH)];
    headerview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]];
    tableview.tableHeaderView = headerview;
    
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    footerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    tableview.tableFooterView = footerview;
    footerview.userInteractionEnabled = YES;
    
    UIButton *openShopButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [openShopButton setTitle:@"一键开店" forState:UIControlStateNormal];
    [openShopButton dangerStyle];
    [openShopButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]] withImageSize:openShopButton.frame.size] forState:UIControlStateNormal];
    [openShopButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [openShopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerview addSubview:openShopButton];
    [openShopButton addTarget:self action:@selector(openShopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:openShopButton];
    
    CGFloat imageW = 50;
    CGFloat imageH = imageW;
    CGFloat imageX = 20;
    CGFloat imageY = (headH - imageH) / 2.0;
    UIImageView *userHead = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    userHead.image = [UIImage imageNamed:@"userDefalut_icon"];
    [headerview addSubview:userHead];
    userHead.layer.borderWidth = 1.0;
    userHead.layer.borderColor = [UIColor whiteColor].CGColor;
    userHead.layer.masksToBounds = YES;
    userHead.layer.cornerRadius = imageW / 2.0;
    [headerview addSubview:userHead];
    
    NSString *name = @"外卖体验店";
    CGFloat nameX = imageW + imageX + 5;
    CGFloat nameY = imageY;
    CGFloat nameW = SCREENWIDTH - nameX - 10;
    CGFloat nameH = imageH;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = name;
    nameLabel.font = [UIFont systemFontOfSize:16.0];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [headerview addSubview:nameLabel];
    
    NSString *state = @"打烊中";
    CGFloat stateW = 100;
    CGFloat stateX = SCREENWIDTH - stateW - 10;
    CGFloat stateY = nameY;
    CGFloat stateH = imageH;
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(stateX, stateY, stateW, stateH)];
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textColor = [UIColor redColor];
    stateLabel.text = state;
    stateLabel.tag = SHOPSTATETAG;
    stateLabel.font = [UIFont systemFontOfSize:15.0];
    stateLabel.textAlignment = NSTextAlignmentRight;
    [headerview addSubview:stateLabel];
    
    CGFloat arrowWidth = 20;
    
    CGFloat buttonH = 20;
    CGFloat buttonW = 100;
    CGFloat buttonY = headH - buttonH - 10;
    CGFloat buttonX = SCREENWIDTH - buttonW - arrowWidth - 10;
    
    UIButton *scanButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [scanButton setTitle:@"查看我的门店" forState:UIControlStateNormal];
    [scanButton.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [scanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    scanButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [scanButton addTarget:self action:@selector(scanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerview addSubview:scanButton];
    
    UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_into"]];
    arrowImage.frame = CGRectMake(CGRectGetMaxX(scanButton.frame), buttonY, arrowWidth, arrowWidth);
    [headerview addSubview:arrowImage];
}

- (void)openShopButtonClick:(UIButton *)button
{
    NSLog(@"openShopButtonClick");
    onBusiness = !onBusiness;
    NSString *shopState = @"打烊中";
    if (onBusiness) {
        shopState = @"营业中";
    }
    UILabel *stateLabel = [tableview.tableHeaderView viewWithTag:SHOPSTATETAG];
    stateLabel.text = shopState;
    if (onBusiness) {
        stateLabel.textColor = [UIColor colorWithRed:83.0 / 255.0 green:202.0 / 255.0 blue:196.0 / 255.0 alpha:1.0];
    }
    else{
        stateLabel.textColor = [UIColor redColor];
    }
    
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    footerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    tableview.tableFooterView = footerview;
    footerview.userInteractionEnabled = YES;
    
    UIButton *openShopButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [openShopButton setTitle:@"一键打烊" forState:UIControlStateNormal];
    [openShopButton dangerStyle];
    if (!onBusiness) {
        [openShopButton setTitle:@"一键开店" forState:UIControlStateNormal];
        [openShopButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]] withImageSize:openShopButton.frame.size] forState:UIControlStateNormal];
        [openShopButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [openShopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [openShopButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [openShopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerview addSubview:openShopButton];
    [openShopButton addTarget:self action:@selector(openShopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:openShopButton];
    
    [tableview reloadData];
}

- (void)scanButtonClick:(UIButton *)button
{
    NSLog(@"scanButtonClick");
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (onBusiness) {
        return [shopInfoArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HeShopManagementCell";
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeShopManagementCell *cell = (HeShopManagementCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[HeShopManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellSize:cellsize];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = shopInfoArray[row];
    
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
    
    
    NSString *message = nil;
    NSString *title = nil;
    switch (row) {
        case 2:
        {
            title = @"店铺简介";
            message = @"店铺暂无简介";
            break;
        }
        case 3:
        {
            title = @"店铺公告";
            message = @"店铺暂无公告";
            break;
        }
        case 4:
        {
            title = @"营业时间";
            message = @"未设置营业时间";
            break;
        }
        default:
            break;
    }
    if (title == nil || message == nil) {
        return;
    }
    TKAlertViewController *alert = [TKAlertViewController alertWithTitle:title message:message];
    //    alert.customeViewInset = UIEdgeInsetsMake(100, 0, 100, 0);
    //    [alert addButtonWithTitle:@"" block:^(NSUInteger index) {
    //        [self testTextFieldAlertView];
    //    }];
    //
    //    [alert addButtonWithTitle:@"cancel" block:nil];
    alert.dismissWhenTapWindow = YES;
    [alert showWithAnimationType:TKAlertViewAnimationPathStyle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!onBusiness) {
        return 0;
    }
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!onBusiness) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    bgView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:bgView.bounds];
    titleLabel.text = @"  店铺信息";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textColor = [UIColor grayColor];
    [bgView addSubview:titleLabel];
    
    return bgView;
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
