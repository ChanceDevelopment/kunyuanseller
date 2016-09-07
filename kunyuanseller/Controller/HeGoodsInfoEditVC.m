//
//  HeActivityEditVC.m
//  kunyuanseller
//
//  Created by Tony on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeGoodsInfoEditVC.h"
#import "HeBaseTableViewCell.h"
#import "SAMTextView.h"
#import "UIButton+Bootstrap.h"
#import "SRActionSheet.h"
#import "HcdDateTimePickerView.h"
#import "ScanPictureView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"

#define MAXUPLOADIMAGE 1
#define MAX_column  4
#define MAX_row 3
#define IMAGEWIDTH 70

@interface HeGoodsInfoEditVC ()<UITableViewDelegate,UITableViewDataSource,SRActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>
{
    HcdDateTimePickerView * dateTimePickerView;
    NSString *goodsCategory;
}

@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)UITextField *goodsNameField;
@property(strong,nonatomic)UITextField *goodsPriceField;
@property(strong,nonatomic)SAMTextView *goodsInfoTextView;
@property(strong,nonatomic)NSMutableArray *myCategoryArray;
@property(strong,nonatomic)UIView *distributeImageBG;
@property(strong,nonatomic)NSMutableArray *pictureArray;
@property(strong,nonatomic)UIButton *addPictureButton;
@property(strong,nonatomic)NSMutableArray *selectedAssets;
@property(strong,nonatomic)NSMutableArray *selectedPhotos;
@property(strong,nonatomic)NSMutableArray *takePhotoArray;

@end

@implementation HeGoodsInfoEditVC
@synthesize tableview;
@synthesize dataSource;
@synthesize goodsNameField;
@synthesize goodsPriceField;
@synthesize goodsInfoTextView;
@synthesize myCategoryArray;
@synthesize distributeImageBG;
@synthesize pictureArray;
@synthesize addPictureButton;

@synthesize takePhotoArray;


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
        label.text = @"商品编辑";
        [label sizeToFit];
        self.title = @"商品编辑";
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
    dataSource = @[@[@"请输入商品名",@"请选择商品类别",@"请输入商品价格",@"请输入商品简介"],@[@"请上传商品图片",@""]];
    myCategoryArray = [[NSMutableArray alloc] initWithArray:@[@"电子产品",@"美食"]];
    pictureArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (!_selectedPhotos) {
        _selectedPhotos = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if (!_selectedAssets) {
        _selectedAssets = [[NSMutableArray alloc] initWithCapacity:0];
    }
    takePhotoArray = [[NSMutableArray alloc] initWithCapacity:0];
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
    
    goodsNameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH - 30, 50)];
    goodsNameField.delegate = self;
    goodsNameField.font = [UIFont systemFontOfSize:15.0];
    goodsNameField.textColor = [UIColor blackColor];
    
    goodsPriceField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREENWIDTH - 50, 50)];
    goodsPriceField.delegate = self;
    goodsPriceField.font = [UIFont systemFontOfSize:15.0];
    goodsPriceField.textColor = [UIColor blackColor];
    
    goodsInfoTextView = [[SAMTextView alloc] initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, 100)];
    goodsInfoTextView.delegate = self;
    goodsInfoTextView.font = [UIFont systemFontOfSize:15.0];
    goodsInfoTextView.textColor = [UIColor blackColor];
    
    addPictureButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, IMAGEWIDTH, IMAGEWIDTH)];
    [addPictureButton setBackgroundImage:[UIImage imageNamed:@"icon_add_pho"] forState:UIControlStateNormal];
    addPictureButton.tag = 100;
    [addPictureButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat distributeX = 5;
    CGFloat distributeY = 5;
    CGFloat distributeW = SCREENWIDTH - 2 * distributeX;
    CGFloat distributeH = IMAGEWIDTH;
    
    int row = [Tool getRowNumWithTotalNum:[pictureArray count]];
    int column = [Tool getColumnNumWithTotalNum:[pictureArray count]];
    distributeImageBG = [[UIView alloc] initWithFrame:CGRectMake(distributeX, distributeY, distributeW, distributeH)];
    [distributeImageBG setBackgroundColor:[UIColor whiteColor]];
    [distributeImageBG addSubview:addPictureButton];
    distributeImageBG.userInteractionEnabled = YES;
    [self updateImageBG];
}

- (void)addButtonClick:(UIButton *)sender
{
    if ([goodsNameField isFirstResponder]) {
        [goodsNameField resignFirstResponder];
    }
    if ([goodsPriceField isFirstResponder]) {
        [goodsPriceField resignFirstResponder];
    }
    if ([goodsInfoTextView isFirstResponder]) {
        [goodsInfoTextView resignFirstResponder];
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"来自相册",@"来自拍照", nil];
    sheet.tag = 1;
    [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

//删除所选图片的代理方法
-(void)deleteImageAtIndex:(int)index
{
    [pictureArray removeObjectAtIndex:index];
    [self updateImageBG];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1) {
        switch (buttonIndex) {
            case 1:
            {
                if (ISIOS7) {
                    NSString *mediaType = AVMediaTypeVideo;
                    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
                    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此应用没有权限访问您的照片或摄像机，请在: 隐私设置 中启用访问" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alert show];
                    }else{
                        [self pickerCamer];
                    }
                }
                else{
                    [self pickerCamer];
                }
                
                
                break;
            }
            case 0:
            {
                if (ISIOS7) {
                    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
                    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
                        //无权限
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此应用没有权限访问您的照片或摄像机，请在: 隐私设置 中启用访问" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    else{
                        [self mutiplepickPhotoSelect];
                    }
                }
                else{
                    [self mutiplepickPhotoSelect];
                }
                break;
            }
            case 2:
            {
                break;
            }
            default:
                break;
        }
    }
}

- (void)updateImageBG
{
    for (UIView *subview in distributeImageBG.subviews) {
        [subview removeFromSuperview];
    }
    CGFloat buttonH = IMAGEWIDTH;
    CGFloat buttonW = IMAGEWIDTH;
    
    CGFloat buttonHDis = (SCREENWIDTH - 20 - MAX_column * buttonW) / (MAX_column - 1);
    CGFloat buttonVDis = 10;
    
    int row = [Tool getRowNumWithTotalNum:[pictureArray count]];
    int column = [Tool getColumnNumWithTotalNum:[pictureArray count]];
    for (int i = 0; i < row; i++) {
        if ((i + 1) * MAX_column <= [pictureArray count]) {
            column = MAX_column;
        }
        else{
            column = [pictureArray count] % MAX_column;
        }
        for (int j = 0; j < column; j++) {
            
            CGFloat buttonX = (buttonW + buttonHDis) * j;
            CGFloat buttonY = (buttonH + buttonVDis) * i;
            
            NSInteger picIndex = i * MAX_column + j;
            AsynImageView *asynImage = [pictureArray objectAtIndex:picIndex];
            asynImage.tag = picIndex;
            asynImage.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            asynImage.layer.borderColor = [UIColor clearColor].CGColor;
            asynImage.layer.borderWidth = 0;
            asynImage.layer.masksToBounds = YES;
            asynImage.contentMode = UIViewContentModeScaleAspectFill;
            asynImage.userInteractionEnabled = YES;
            [distributeImageBG addSubview:asynImage];
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanImageTap:)];
            tapGes.numberOfTapsRequired = 1;
            tapGes.numberOfTouchesRequired = 1;
            [asynImage addGestureRecognizer:tapGes];
        }
    }
    
    
    if ([pictureArray count] < MAXUPLOADIMAGE) {
        
        NSInteger last_i = -1;
        NSInteger last_j = -1;
        row = [Tool getRowNumWithTotalNum:[pictureArray count] + 1];
        for (int i = 0; i < row; i++) {
            if ((i + 1) * MAX_column <= [pictureArray count] + 1) {
                column = MAX_column;
            }
            else{
                column = ([pictureArray count] + 1) % MAX_column;
            }
            last_i = i;
            for (int j = 0; j < column; j++) {
                last_j = j;
            }
        }
        if (last_i == -1 || last_j == -1) {
            addPictureButton.hidden = YES;
        }
        else{
            addPictureButton.hidden = NO;
        }
        
        CGFloat buttonX = (buttonW + buttonHDis) * last_j;
        CGFloat buttonY = (buttonH + buttonVDis) * last_i;
        CGFloat buttonW = addPictureButton.frame.size.width;
        CGFloat buttonH = addPictureButton.frame.size.height;
        
        addPictureButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        CGFloat distributeX = distributeImageBG.frame.origin.x;
        CGFloat distributeY = distributeImageBG.frame.origin.y;
        CGFloat distributeW = distributeImageBG.frame.size.width;
        CGFloat distributeH = addPictureButton.frame.origin.y + addPictureButton.frame.size.height;
        
        distributeImageBG.frame = CGRectMake(distributeX, distributeY, distributeW, distributeH);
        
    }
    else{
        
        CGFloat distributeX = distributeImageBG.frame.origin.x;
        CGFloat distributeY = distributeImageBG.frame.origin.y;
        CGFloat distributeW = distributeImageBG.frame.size.width;
        CGFloat distributeH = (buttonH + buttonVDis) * (MAX_row - 1) + buttonH;
        
        distributeImageBG.frame = CGRectMake(distributeX, distributeY, distributeW, distributeH);
        
        addPictureButton.hidden = YES;
    }
    [distributeImageBG addSubview:addPictureButton];
    
    [tableview reloadData];
    
}

- (void)scanImageTap:(UITapGestureRecognizer *)tap
{
    NSInteger selectIndex = tap.view.tag + 1;
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (AsynImageView *asyImage in pictureArray) {
        if (asyImage.highlightedImage == nil) {
            [array addObject:asyImage];
        }
    }
    
    ScanPictureView *scanPictureView = [[ScanPictureView alloc] initWithArray:array selectButtonIndex:selectIndex];
    scanPictureView.deleteDelegate = self;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTintColor:[UIColor colorWithRed:65.0f/255.0f green:164.0f/255.0f blue:220.0f/255.0f alpha:1.0f]];
    scanPictureView.navigationItem.backBarButtonItem = backButton;
    scanPictureView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scanPictureView animated:YES];
}

- (void)handleSelectPhoto
{
    for (AsynImageView *imageview in pictureArray) {
        if (imageview.imageTag != -1) {
            [pictureArray removeObject:imageview];
        }
    }
    
    for (UIImage *image in _selectedPhotos) {
        AsynImageView *asyncImage = [[AsynImageView alloc] init];
        [asyncImage setImage:image];
        asyncImage.bigImageURL = nil;
        [pictureArray addObject:asyncImage];
        
    }
    [self updateImageBG];
}

- (void)mutiplepickPhotoSelect{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    // Set the appearance
    // 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // Set allow picking video & photo & originalPhoto or not
    // 设置是否可以选择视频/图片/原图
    // imagePickerVc.allowPickingVideo = NO;
    // imagePickerVc.allowPickingImage = NO;
    // imagePickerVc.allowPickingOriginalPhoto = NO;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark TZImagePickerControllerDelegate



/// User finish picking photo，if assets are not empty, user picking original photo.
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self dismissViewControllerAnimated:YES completion:^{
        [self handleSelectPhoto];
    }];
}

/// User finish picking video,
/// 用户选择好了视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [_selectedPhotos addObjectsFromArray:@[coverImage]];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self handleSelectPhoto];
    }];
    
    /*
     // open this code to send video / 打开这段代码发送视频
     [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
     NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
     // Export completed, send video here, send by outputPath or NSData
     // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
     
     }];
     */
    
}

#pragma mark -
#pragma mark ImagePicker method
//从相册中打开照片选择画面(图片库)：UIImagePickerControllerSourceTypePhotoLibrary
//启动摄像头打开照片摄影画面(照相机)：UIImagePickerControllerSourceTypeCamera

//按下相机触发事件
-(void)pickerCamer
{
    //照相机类型
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断属性值是否可用
    if([UIImagePickerController isSourceTypeAvailable:sourceType]){
        //UIImagePickerController是UINavigationController的子类
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        //设置可以编辑
        //        imagePicker.allowsEditing = YES;
        //设置类型为照相机
        imagePicker.sourceType = sourceType;
        //进入照相机画面
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

//当按下相册按钮时触发事件
-(void)pickerPhotoLibrary
{
    //图片库类型
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *photoAlbumPicker = [[UIImagePickerController alloc] init];
    photoAlbumPicker.delegate = self;
    photoAlbumPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    //设置可以编辑
    //    photoAlbumPicker.allowsEditing = YES;
    //设置类型
    photoAlbumPicker.sourceType = sourceType;
    //进入图片库画面
    [self presentViewController:photoAlbumPicker animated:YES completion:nil];
}


#pragma mark -
#pragma mark imagePickerController method
//当拍完照或者选取好照片之后所要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize sizeImage = image.size;
    float a = [self getSize:sizeImage];
    if (a>0) {
        CGSize size = CGSizeMake(sizeImage.width/a, sizeImage.height/a);
        image = [self scaleToSize:image size:size];
    }
    
    //    [self initButtonWithImage:image];
    
    AsynImageView *asyncImage = [[AsynImageView alloc] init];
    
    UIImageJPEGRepresentation(image, 0.6);
    [asyncImage setImage:image];
    
    asyncImage.bigImageURL = nil;
    asyncImage.imageTag = -1; //表明是调用系统相机、相册的
    [pictureArray addObject:asyncImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self updateImageBG];
    }];
    
}


//相应取消动作
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(float)getSize:(CGSize)size
{
    float a = size.width / 480.0;
    if (a > 1) {
        return a;
    }
    else
        return -1;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(void)initButtonWithImage:(UIImage *)image
{
    
    CGSize sizeImage = image.size;
    CGFloat width = sizeImage.width;
    CGFloat hight = sizeImage.height;
    CGFloat standarW = width;
    CGRect frame = CGRectMake(0, hight - width, standarW, standarW);
    
    if (width > hight) {
        standarW = hight;
        
        frame = CGRectMake(0, 0, standarW, standarW);
    }
    //截取图片
    UIImage *jiequImage = [self imageFromImage:image inRect:frame];
    //    CGSize jiequSize = jiequImage.size;
    
    
    addPictureButton.tag = 1;
    [addPictureButton setImage:jiequImage forState:UIControlStateNormal];
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

- (void)finishButtonClick:(UIButton *)button
{
    NSLog(@"finishButtonClick");
}

- (void)selectGoodsCategoryWithArray:(NSArray *)categoryArray
{
    [SRActionSheet sr_showActionSheetViewWithTitle:@"请选择商品类型"
                                 cancelButtonTitle:@"取消"
                            destructiveButtonTitle:nil
                                 otherButtonTitles:categoryArray
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      NSLog(@"%zd", actionIndex);
                                      goodsCategory = categoryArray[actionIndex];
                                      [tableview reloadData];
                                  }];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView isFirstResponder]) {
        [textView resignFirstResponder];
    }
    return YES;
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
    return [dataSource[section] count];
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
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    goodsNameField.placeholder = dataSource[section][row];
                    [cell addSubview:goodsNameField];
                    
                    break;
                }
                case 1:
                {
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = goodsCategory;
                    if (!goodsCategory) {
                        cell.textLabel.text = dataSource[section][row];
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
                    unitLabel.text = @"元";
                    [cell addSubview:unitLabel];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    goodsPriceField.placeholder = dataSource[section][row];
                    [cell addSubview:goodsPriceField];
                    break;
                }
                case 3:
                {
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    goodsInfoTextView.placeholder = dataSource[section][row];
                    [cell addSubview:goodsInfoTextView];
                    break;
                }
                
                default:
                    break;
            }
            break;
        }
        case 1:{
            switch (row) {
                case 0:{
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    cell.textLabel.text = dataSource[section][row];
                    break;
                }
                case 1:
                {
                    [cell addSubview:distributeImageBG];
                    break;
                }
                default:
                    break;
            }
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
    switch (section) {
        case 0:
        {
            if (row == 3) {
                return 120;
            }
            break;
        }
        case 1:{
            if (row == 1) {
                return 80;
            }
        }
        default:
            break;
    }
    
    
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    headerview.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    return headerview;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (section) {
        case 0:
        {
            switch (row) {
                case 1:
                {
                    [self selectGoodsCategoryWithArray:myCategoryArray];
                    break;
                }
                default:
                    break;
            }
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
