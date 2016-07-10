//
//  HeEnrollVC.m
//  kunyuan
//
//  Created by HeDongMing on 16/6/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeEnrollVC.h"
#import "UIButton+Bootstrap.h"
#import "HeBaseTableViewCell.h"
#import "MLLabel+Size.h"
#import "MLLabel.h"

@interface HeEnrollVC ()<UITextFieldDelegate>
@property(strong,nonatomic)IBOutlet UITableView *enrollTable;
@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)NSArray *titleSource;
@property(strong,nonatomic)NSArray *fieldSource;

@property(strong,nonatomic)UITextField *acountField;
@property(strong,nonatomic)UITextField *passwordField;
@property(strong,nonatomic)UITextField *nameField;
@property(strong,nonatomic)UITextField *shopnameField;
@property(strong,nonatomic)UIButton *commitButton;
@property(strong,nonatomic)UIButton *selectButton;

@property(strong,nonatomic)NSString *shopType;

@end

@implementation HeEnrollVC
@synthesize enrollTable;
@synthesize dataSource;
@synthesize titleSource;
@synthesize acountField;
@synthesize fieldSource;
@synthesize passwordField;
@synthesize shopnameField;
@synthesize nameField;
@synthesize commitButton;
@synthesize shopType; //店铺类型
@synthesize selectButton;

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
        label.text = @"商家入驻" ;
        [label sizeToFit];
        self.title = @"商家入驻";
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
    
    dataSource = @[@[@"选择类型"],@[@"姓名",@"手机",@"店铺名称",@"用户密码"]];
    titleSource = @[@"商铺类型",@"联系人信息"];
}

- (void)initView
{
    [super initView];
    [Tool setExtraCellLineHidden:enrollTable];
    
    CGFloat fieldX = 10;
    CGFloat fieldY = 0;
    CGFloat fieldH = 50.0;
    CGFloat filedW = SCREENWIDTH - 2 * fieldX;
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, fieldY, filedW, fieldH)];
    nameField.backgroundColor = [UIColor clearColor];
    nameField.delegate = self;
    nameField.font = [UIFont systemFontOfSize:16.0];
    nameField.textColor = [UIColor blackColor];
    
    acountField = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, fieldY, filedW, fieldH)];
    acountField.backgroundColor = [UIColor clearColor];
    acountField.delegate = self;
    acountField.font = [UIFont systemFontOfSize:16.0];
    acountField.textColor = [UIColor blackColor];
    
    
    shopnameField = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, fieldY, filedW, fieldH)];
    shopnameField.backgroundColor = [UIColor clearColor];
    shopnameField.delegate = self;
    shopnameField.font = [UIFont systemFontOfSize:16.0];
    shopnameField.textColor = [UIColor blackColor];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(fieldX, fieldY, filedW, fieldH)];
    passwordField.backgroundColor = [UIColor clearColor];
    passwordField.delegate = self;
    passwordField.font = [UIFont systemFontOfSize:16.0];
    passwordField.textColor = [UIColor blackColor];
    passwordField.secureTextEntry = YES;
    
    fieldSource = @[nameField,acountField,shopnameField,passwordField];
    
    CGFloat footerHeight = 200;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, footerHeight)];
    footerView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    enrollTable.tableFooterView = footerView;
    
    CGFloat buttonX = 20;
    CGFloat buttonY = 20;
    CGFloat buttonW = SCREENWIDTH - 2 * buttonX;
    CGFloat buttonH = 40;
    
    selectButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonH / 2.0, buttonH / 2.0)];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"CheckBoxSelected"] forState:UIControlStateSelected];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"CheckBox"] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:selectButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(buttonX + buttonH / 2.0 + 10, buttonY, 200, 20)];
    label.text = @"我可以提供营业执照";
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor blackColor];
    [footerView addSubview:label];
    
    NSString *tipString = @"关于合作的资费和销售的联系方式我们暂时无法告知，请先提交合作申请后耐心等待我们工作人员与你联系";
    UIFont *textFont = [UIFont systemFontOfSize:15.0];
    CGSize textsize = [MLLinkLabel getViewSizeByString:tipString maxWidth:buttonW font:textFont lineHeight:0 lines:0];
    MLLinkLabel *tipLabel = [[MLLinkLabel alloc] initWithFrame:CGRectMake(buttonX, buttonY + buttonH + 5, buttonW, textsize.height)];
    tipLabel.numberOfLines = 0;
    tipLabel.text = tipString;
    tipLabel.font = textFont;
    tipLabel.textColor = [UIColor grayColor];
    [footerView addSubview:tipLabel];
    
    commitButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, CGRectGetMaxY(tipLabel.frame) + 10, buttonW, buttonH)];
    [commitButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [commitButton dangerStyle];
    commitButton.layer.borderWidth = 0;
    commitButton.layer.borderColor = [UIColor clearColor].CGColor;
    [commitButton setBackgroundImage:[Tool buttonImageFromColor:APPDEFAULTORANGE withImageSize:commitButton.frame.size] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:commitButton];
    
    footerView.userInteractionEnabled = YES;
    
    enrollTable.backgroundView = nil;
    enrollTable.backgroundColor = footerView.backgroundColor;
}

- (IBAction)getCodeButtonClick:(id)sender
{
    
}

- (void)selectButtonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)commitButtonClick:(id)sender
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource[section] count] + 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    static NSString *cellIndentifier = @"HeBaseTableViewCell";
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    HeBaseTableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if (section == 1) {
        UITextField *textfield = fieldSource[row];
        [cell addSubview:textfield];
        textfield.placeholder = dataSource[section][row];
    }
    else if (section == 0){
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.textLabel.text = shopType;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        if (shopType == nil) {
            cell.textLabel.text = @"类型选择";
            cell.textLabel.textColor = [UIColor grayColor];
        }
        else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return titleSource[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)didReceiveMemoryWarning {
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
