//
//  EvaluateViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 评价控制器

#import "EvaluateViewController.h"

// ---------------------- 框架工具类   ----------------------
// ---------------------- 框架工具类   ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "EvaluateView.h"
#import "EvaluateCollectionViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

static NSString *const cellID = @"pictureCollectionViewCell";
@interface EvaluateViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/**  确定按钮*/
@property (nonatomic, strong) UIButton     *determineBtn;

@property (nonatomic, strong) EvaluateView *evaluateView;

/** 显示照片的控件*/
@property (nonatomic, strong) UICollectionView *pictureCollectionView;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 评价图片控件数据*/
@property (nonatomic, strong) NSMutableArray *pictureMutableArray;
/** 星级*/
@property (nonatomic, copy) NSString *starLevel;
/** 内容*/
@property (nonatomic, copy) NSString *content;

@end

@implementation EvaluateViewController
#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

/**
 *  已经加载出视图 调用
 *
 *  @param animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
}

/**
 *  视图即将消失 调用
 *
 *  @param animated
 */
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
}

/**
 *  视图已经消失 调用
 *
 *  @param animated
 */
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}


/**
 *  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@" selfViewController Destroy ");
}

#pragma mark - Init Data Method
/**
 *  数据初始化
 */
- (void) initData {
    self.evaluateView.iconPhotoUrl = self.iconPhotoUrl;
    self.evaluateView.nameStr      = self.nameStr;
    
    self.pictureMutableArray       = [[NSMutableArray alloc] initWithObjects:@"add", nil];
    
}

#pragma mark - Setting UI Methods
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    
    [self setNavWithLeftBarButton:NO title:@"评价"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.determineBtn];
    [self.view addSubview:self.evaluateView];
    [self.view addSubview:self.pictureCollectionView];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:550];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [self.determineBtn autoSetDimension:ALDimensionWidth toSize:62];
    [self.determineBtn autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.evaluateView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.evaluateView autoSetDimension:ALDimensionHeight toSize:440];
}

#pragma mark - 接口数据
// 用户评价接口
- (void) getCommentsWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"comment/comments"];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"mobile,%@"    , GetUserDefault(userUid)],//手机号
                             [NSString stringWithFormat:@"stylistId,%@" , self.orderStylistId],//设计师ID
                             [NSString stringWithFormat:@"starLevel,%@" , self.starLevel],//星级
                             [NSString stringWithFormat:@"content,%@"   , self.content],//内容
                             nil];
    if (self.orderOrderId != nil) {
        [array addObject:[NSString stringWithFormat:@"orderId,%@" , self.orderOrderId]];//订单ID
    }
    if (self.pictureMutableArray.count > 1) {
        [array addObject:[NSString stringWithFormat:@"fphoto,%@" , self.pictureMutableArray[0]]];//图片1
    }
    if (self.pictureMutableArray.count > 2) {
        [array addObject:[NSString stringWithFormat:@"fphoto,%@" , self.pictureMutableArray[1]]];//图片2
    }
    if (self.pictureMutableArray.count > 3) {
        [array addObject:[NSString stringWithFormat:@"fphoto,%@" , self.pictureMutableArray[2]]];//图片3
    }
   
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
        }else {
            NSLog(@"用户评价接口%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"用户评价接口数据错误%@", error);
    }];
}

#pragma mark - UICollectionView DataSource Method

/**
 *  UICollectionView 数据源方法 返回 分组个数
 *
 *  @param  collectionView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 * UICollectionView 数据源方法 返回 collectionView 每个分组中的个数
 *
 *  @param  collectionView
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.pictureMutableArray.count > 3) {
        return 3;
    }else {
        return self.pictureMutableArray.count;
    }
}

/**
 *
 *  UICollectionView 数据源方法 返回每个显示的样式和数据
 *  @param  collectionView
 *  @param  indexPath
 *
 *  @return UICollectionViewCell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EvaluateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];

    cell.indexPath           = indexPath;
    cell.imageName           = self.pictureMutableArray[indexPath.row];
    cell.hiddenDeleteButton  = [indexPath row] != self.pictureMutableArray.count - 1 ? NO : YES;
    cell.DeletePhotos        = ^(NSIndexPath *indexPath){
        [self.pictureMutableArray removeObjectAtIndex:indexPath.row];
        [self.pictureCollectionView reloadData];
    };
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Delegate Method
/**
 *  UICollectionViewDelegateFlowLayout 代理方法 返回每个 格子大小
 *
 *  @param  collectionView
 *  @param  collectionViewLayout
 *  @param  indexPath
 *
 *  @return CGSize
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}

/**
 *  UICollectionViewDelegateFlowLayout 代理方法 返回每个 返回每个各自的上下间距
 *
 *  @param  collectionView
 *  @param  collectionViewLayout
 *  @param  section
 *
 *  @return CGFloat
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


#pragma mark - UICollectionView Delegate Method
/**
 *  UICollectionView 代理方法 点击每个格子 (跳转详情)
 *
 *  @param collectionView
 *  @param indexPath
 */
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
    if (indexPath.row + 1 == self.pictureMutableArray.count) {
        [self showOkayCancelAlert];
    };
}

- (void)showOkayCancelAlert {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        UIImagePickerController* pickPhoto = [[UIImagePickerController alloc]init];
        pickPhoto.delegate = self;
        BOOL support = NO;
        for(NSNumber* num in [UIImagePickerController availableCaptureModesForCameraDevice:UIImagePickerControllerCameraDeviceRear]){
            if([num intValue] == UIImagePickerControllerCameraCaptureModePhoto){
                support = YES;
                pickPhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickPhoto.allowsEditing = YES ;
            }
        }
        if(support){
            [self presentViewController:pickPhoto animated:YES completion:nil];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备不支持照相功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        UIImagePickerController *pick = [[UIImagePickerController alloc]init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate = self;
        pick.allowsEditing = YES;
        [self presentViewController:pick animated:YES completion:nil];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
//        imageUser = imageToSave;
        
        NSData *data = UIImageJPEGRepresentation(imageToSave, 1);
        NSString *dataStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        //上传照片
//        [self getUploadAvatarWithData:dataStr];
        NSLog(@"%@", self.pictureMutableArray);
        [self.pictureMutableArray insertObject:dataStr atIndex:self.pictureMutableArray.count - 1];
        NSLog(@"%@", self.pictureMutableArray);
        [self.pictureCollectionView reloadData];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    
    [self getCommentsWithData];
}

#pragma mark   -  所有控件懒加载

- (UIButton *)determineBtn {
    if (!_determineBtn) {
        _determineBtn = [[UIButton alloc] initForAutoLayout];
        _determineBtn.layer.borderWidth     = 1;
        _determineBtn.layer.cornerRadius    = 2;
        _determineBtn.layer.borderColor     = [UIColor redColor].CGColor;
        [_determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_determineBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineBtn;
}

- (EvaluateView *)evaluateView {
    if (!_evaluateView) {
        _evaluateView = [[EvaluateView alloc] initForAutoLayout];
        __weak typeof(self) selfViewController = self;
        self.evaluateView.EvaluateViewContent = ^(NSString *str, NSInteger tag){
            selfViewController.content = str;
            selfViewController.starLevel = [NSString stringWithFormat:@"%ld", (long)tag];
        };
    }
    return _evaluateView;
}

/**
 *  懒加载   显示照片的控件   控件
 */
- (UICollectionView *) pictureCollectionView {
    if (!_pictureCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing          = 5;//左右间距
        _pictureCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(30, 450, self.view.frame.size.width - 30, 90) collectionViewLayout:flowLayout];
        _pictureCollectionView.delegate     = self;
        _pictureCollectionView.dataSource   = self;
        _pictureCollectionView.backgroundColor                = [UIColor clearColor];
        _pictureCollectionView.showsHorizontalScrollIndicator = NO;
        _pictureCollectionView.showsVerticalScrollIndicator   = NO;
        [_pictureCollectionView registerClass:[EvaluateCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _pictureCollectionView;
}

@end
