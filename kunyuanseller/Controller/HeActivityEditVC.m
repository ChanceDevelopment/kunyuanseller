//
//  HeActivityEditVC.m
//  kunyuanseller
//
//  Created by Tony on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeActivityEditVC.h"
#import "HeBaseTableViewCell.h"
#import "UIButton+Bootstrap.h"
#import "SRActionSheet.h"
#import "HcdDateTimePickerView.h"


@interface HeActivityEditVC ()<UITableViewDelegate,UITableViewDataSource,SRActionSheetDelegate,UITextFieldDelegate,UITextFieldDelegate>
{
    HcdDateTimePickerView * dateTimePickerView;
    NSString *goodsName;
    NSString *goodsCategory;
}
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)UITextField *discountField;
@property(strong,nonatomic)NSString *activityEndTime;
@property(strong,nonatomic)NSString *activityStartTime;
@property(strong,nonatomic)NSMutableArray *myGoodsArray;
@property(strong,nonatomic)NSMutableArray *myCategoryArray;

@end

@implementation HeActivityEditVC
@synthesize tableview;
@synthesize dataSource;
@synthesize discountField;
@synthesize activityEndTime;
@synthesize activityStartTime;
@synthesize myGoodsArray;
@synthesize myCategoryArray;

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
        label.text = @"活动编辑";
        [label sizeToFit];
        self.title = @"活动编辑";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)initializaiton
{
    [super initializaiton];
    myGoodsArray = [[NSMutableArray alloc] initWithArray:@[@"苹果",@"三星"]];
    myCategoryArray = [[NSMutableArray alloc] initWithArray:@[@"电子产品",@"美食"]];
    dataSource = @[@"请选择商品名",@"请选择活动类别",@"请输入商品优惠折扣",@"请选择活动截止时间"];
}

- (void)initView
{
    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:tableview];
    
    UIView *footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    footerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    tableview.tableFooterView = footerview;
    footerview.userInteractionEnabled = YES;
    
    UIButton *finishButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 40)];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton dangerStyle];
    [finishButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]] withImageSize:finishButton.frame.size] forState:UIControlStateNormal];
    [finishButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerview addSubview:finishButton];
    [finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:finishButton];
    
    discountField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH - 50, 50)];
    discountField.delegate = self;
    discountField.font = [UIFont systemFontOfSize:15.0];
    discountField.textColor = [UIColor blackColor];
    
}

- (void)finishButtonClick:(UIButton *)button
{
    NSLog(@"finishButtonClick");
}

- (void)selectGoodsWithGoodsArray:(NSArray *)goodsArray
{
    [SRActionSheet sr_showActionSheetViewWithTitle:@"请选择商品名"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                                 otherButtonTitles:goodsArray
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      NSLog(@"%zd", actionIndex);
                                      goodsName = goodsArray[actionIndex];
                                      [tableview reloadData];
                                  }];
}

- (void)selectActivityCategoryWithArray:(NSArray *)categoryArray
{
    [SRActionSheet sr_showActionSheetViewWithTitle:@"请选择活动类别"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                                 otherButtonTitles:categoryArray
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      NSLog(@"%zd", actionIndex);
                                      goodsCategory = categoryArray[actionIndex];
                                      [tableview reloadData];
                                  }];
}

- (void)selectTimeWithDate:(NSDate *)defaultDate
{
    __block HeActivityEditVC *weakSelf = self;
    
    dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        NSLog(@"%@", datetimeStr);
        activityEndTime = datetimeStr;
        [weakSelf.tableview reloadData];
        
    };
    if (dateTimePickerView) {
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - SRActionSheetDelegate

- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index {
    
    NSLog(@"%zd", index);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    static NSString *cellIndentifier = @"HeBaseTableViewCell";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    NSDictionary *dict = nil;
    //    @try {
    //        orderDict = [messageArray objectAtIndex:row];
    //    }
    //    @catch (NSException *exception) {
    //
    //    }
    //    @finally {
    //
    //    }
    
    HeBaseTableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    switch (row) {
        case 0:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = goodsName;
            if (!goodsName) {
                cell.textLabel.text = dataSource[row];
            }
            
            break;
        }
        case 1:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = goodsCategory;
            if (!goodsCategory) {
                cell.textLabel.text = dataSource[row];
            }
            break;
        }
        case 2:
        {
            UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 30 - 10, 0, 30, cellSize.height)];
            unitLabel.textColor = [UIColor blackColor];
            unitLabel.textAlignment = NSTextAlignmentCenter;
            unitLabel.font = [UIFont systemFontOfSize:15.0];
            unitLabel.backgroundColor = [UIColor clearColor];
            unitLabel.text = @"折";
            [cell addSubview:unitLabel];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            discountField.placeholder = dataSource[row];
            [cell addSubview:discountField];
            break;
        }
        case 3:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = activityEndTime;
            if (!activityEndTime) {
                cell.textLabel.text = dataSource[row];
            }
            
            break;
        }
        default:
            break;
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (row) {
        case 0:
        {
            [self selectGoodsWithGoodsArray:myGoodsArray];
            break;
        }
        case 1:{
            [self selectActivityCategoryWithArray:myCategoryArray];
            break;
        }
        case 3:{
            [self selectTimeWithDate:nil];
            break;
        }
        default:
            break;
    }
    
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
