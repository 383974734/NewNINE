//
//  MyHeadTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MyHeadTableViewCell.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "MyButtonUIView.h"
#import "MyNumberView.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "UserModel.h"
// ---------------------- model      ----------------------

@interface MyHeadTableViewCell ()<MyNumberViewDelegate, MyButtonUIViewDelegate>
/** 背景图片*/
@property (nonatomic, strong) UIImageView   *backgroundImageView;
/** 用户头像*/
@property (nonatomic, strong) UIImageView   *userImage;
/** 用户头像*/
@property (nonatomic, strong) UIButton      *userImageView;
/** 用户名字*/
@property (nonatomic, strong) UIButton      *userName;
/** 我的美单父视图*/
@property (nonatomic, strong) UIButton      *backgroundVeiw;
/** 我的美单图片*/
@property (nonatomic, strong) UIImageView   *myImageView;
/** 我的美单*/
@property (nonatomic, strong) UILabel       *myLable;
/** 我的美单箭头*/
@property (nonatomic, strong) UIImageView   *nextImageView;
/** 查看全部订单*/
@property (nonatomic, strong) UILabel       *seeLable;
/** 未付款按钮*/
@property (nonatomic, strong)MyButtonUIView *noPaymenView;
/** 预约成功按钮*/
@property (nonatomic, strong)MyButtonUIView *appointmentSuccessView;
/** 完成按钮*/
@property (nonatomic, strong)MyButtonUIView *completeView;
/** 退款款按钮*/
@property (nonatomic, strong)MyButtonUIView *refundView;
/** 收藏*/
@property (nonatomic, strong)MyNumberView   *nuCollectionView;
/** 积分*/
@property (nonatomic, strong)MyNumberView   *nuIntegraView;
/** 优惠劵*/
@property (nonatomic, strong)MyNumberView   *nuDiscountdView;

@end

@implementation MyHeadTableViewCell


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MyHeadTableViewCell
 */
+ (instancetype) myHeadCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    MyHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return MyHeadTableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}


/**
 *  添加cell上的控件
 */
- (void) addUI {
    [self.contentView addSubview:self.backgroundImageView];
    [self.contentView addSubview:self.backgroundVeiw];
    [self.backgroundImageView addSubview:self.userImageView];
    [self.backgroundImageView addSubview:self.userName];
    [self.backgroundImageView addSubview:self.nuCollectionView];
    [self.backgroundImageView addSubview:self.nuIntegraView];
    [self.backgroundImageView addSubview:self.nuDiscountdView];
    
    [self.backgroundVeiw addSubview:self.myImageView];
    [self.backgroundVeiw addSubview:self.myLable];
    [self.backgroundVeiw addSubview:self.nextImageView];
    [self.backgroundVeiw addSubview:self.seeLable];
    
    [self.userImageView addSubview:self.userImage];
    
    [self.contentView addSubview:self.noPaymenView];
    [self.contentView addSubview:self.appointmentSuccessView];
    [self.contentView addSubview:self.completeView];
    [self.contentView addSubview:self.refundView];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.userImage autoPinEdgesToSuperviewEdges];
    
    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 110, 0)];
    [self.backgroundVeiw      autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-1, -1, 65, -1) excludingEdge:ALEdgeTop];
    [self.backgroundVeiw      autoSetDimension:ALDimensionHeight toSize:45];
}


- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initForAutoLayout];
        _backgroundImageView.image = [UIImage imageNamed:@"我的背景图"];
        _backgroundImageView.userInteractionEnabled = YES;
    }
    return _backgroundImageView;
}

- (UIButton *) userImageView {
    if (!_userImageView) {
        _userImageView = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 36, 42, 72, 72)];
        _userImageView.layer.borderWidth = 2;
        _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = 36;
        _userImageView.tag = 0;
        [_userImageView setImage:[UIImage imageNamed:@"160Wow"] forState:UIControlStateNormal];
        [_userImageView addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userImageView;
}

- (UIImageView *)userImage {
    if (!_userImage) {
        _userImage = [[UIImageView alloc] initForAutoLayout];
        _userImage.layer.cornerRadius       = 36;
        _userImage.layer.masksToBounds      = YES;
        _userImage.image                    = [UIImage imageNamed:@"160Wow"];
        _userImage.userInteractionEnabled   = YES;
    }
    return _userImage;
}

- (UIButton *) userName {
    if (!_userName) {
        _userName = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 36, 115, 72, 30)];
        _userName.tag = 2;
        _userName.titleLabel.font = SWP_SYSTEM_FONT_SIZE(14);
        [_userName setTitle:@"未登录" forState:UIControlStateNormal];
        [_userName addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userName;
}

- (UIButton *) backgroundVeiw{
    if (!_backgroundVeiw) {
        _backgroundVeiw = [[UIButton alloc] initForAutoLayout];
        _backgroundVeiw.tag = 1;
        _backgroundVeiw.layer.borderWidth = 0.5;
        _backgroundVeiw.layer.borderColor = Color(238, 238, 238, 1).CGColor;
        [_backgroundVeiw addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundVeiw;
}
    

- (UIImageView *) myImageView{
    if (!_myImageView) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
        _myImageView.image = [UIImage imageNamed:@"我的美单"];
    }
    return _myImageView;
}

- (UILabel *) myLable {
    if (!_myLable) {
        _myLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 80, 24)];
        _myLable.textColor = Color(64, 64, 64, 1);
        _myLable.text = @"我的美单";
    }
    return _myLable;
}

- (UILabel *) seeLable {
    if (!_seeLable) {
        _seeLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 215, 10, 180, 24)];
        _seeLable.textColor = Color(154, 154, 154, 1);
        _seeLable.textAlignment = NSTextAlignmentRight;
        _seeLable.text = @"查看全部订单";
    }
    return _seeLable;
}

- (UIImageView *) nextImageView {
    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 16, 13, 13)];
        _nextImageView.image = [UIImage imageNamed:@"进入箭头"];
    }
    return _nextImageView;
}

- (MyButtonUIView *) noPaymenView {
    if (!_noPaymenView) {
        _noPaymenView = [[MyButtonUIView alloc] initWithFrame:CGRectMake(0, 320 - 65, SCREEN_WIDTH / 4, 65)];
        _noPaymenView.delegate = self;
        [_noPaymenView setimageView:@"未付款" lableText:@"未付款" buttonWithTag:0];
    }
    return _noPaymenView;
}

- (MyButtonUIView *) appointmentSuccessView {
    if (!_appointmentSuccessView) {
        _appointmentSuccessView = [[MyButtonUIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 320 - 65, SCREEN_WIDTH / 4, 65)];
        _appointmentSuccessView.delegate = self;
        [_appointmentSuccessView setimageView:@"预约成功" lableText:@"已支付" buttonWithTag:1];
    }
    return _appointmentSuccessView;
}

- (MyButtonUIView *) completeView {
    if (!_completeView) {
        _completeView = [[MyButtonUIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 320 - 65, SCREEN_WIDTH / 4, 65)];
        _completeView.delegate = self;
        [_completeView setimageView:@"已完成" lableText:@"已完成" buttonWithTag:2];
    }
    return _completeView;
}

- (MyButtonUIView *) refundView {
    if (!_refundView) {
        _refundView = [[MyButtonUIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4 * 3, 320 - 65, SCREEN_WIDTH / 4, 65)];
        _refundView.delegate = self;
        [_refundView setimageView:@"退款" lableText:@"退款" buttonWithTag:3];
    }
    return _refundView;
}

- (MyNumberView *)nuCollectionView {
    if (!_nuCollectionView) {
        _nuCollectionView          = [[MyNumberView alloc] initWithFrame:CGRectMake(0, 156, SCREEN_WIDTH/ 3, 36)];
        _nuCollectionView.delegate = self;
        [_nuCollectionView setImageView:@"收藏" nameText:@"收藏" numberText:@"0" imageLandRWithHidden:YES tag:0];
    }
    return _nuCollectionView;
}

- (MyNumberView *)nuIntegraView {
    if (!_nuIntegraView) {
        _nuIntegraView          = [[MyNumberView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/ 3, 156, SCREEN_WIDTH/ 3, 36)];
        _nuIntegraView.delegate = self;
        [_nuIntegraView setImageView:@"积分" nameText:@"积分" numberText:@"0" imageLandRWithHidden:NO tag:1];
    }
    return _nuIntegraView;
}

- (MyNumberView *)nuDiscountdView {
    if (!_nuDiscountdView) {
        _nuDiscountdView            = [[MyNumberView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/ 3 * 2, 156, SCREEN_WIDTH/ 3, 36)];
        _nuDiscountdView.delegate   = self;
        [_nuDiscountdView setImageView:@"优惠券" nameText:@"优惠劵" numberText:@"0" imageLandRWithHidden:YES tag:2];
    }
    return _nuDiscountdView;
}

- (void)didView:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(myHeadTableViewCell:buttonWithTag:name:)]) {
        [self.delegate myHeadTableViewCell:self buttonWithTag:btn.tag name:@"0"];
    }
}

- (void) setUserDict:(NSDictionary *)userDict {
    _userDict = userDict;
    if (!([GetUserDefault(userUid) length] > 0)) {
        [_userImageView setImage:[UIImage imageNamed:@"160Wow"] forState:UIControlStateNormal];
        [_userName setTitle:@"未登录" forState:UIControlStateNormal];
        [_nuCollectionView setWithNumber:@"0"];
        [_nuIntegraView setWithNumber:@"0"];
        [_nuDiscountdView setWithNumber:@"0"];
    }else {
        if ([[_userDict objectForKey:@"iconPhotoUrl"]length] > 0) {
            
            [self.userImage  sd_setImageWithURL:[NSURL URLWithString:[_userDict objectForKey:@"iconPhotoUrl"]]
                                       placeholderImage:[UIImage imageNamed:@"160Wow"]
                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              }];
            
            
//            [self.userImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[_userDict objectForKey:@"iconPhotoUrl"]]]] forState:UIControlStateNormal];
        }
        
        [self.userName setTitle:[NSString stringWithFormat:@"%@", [_userDict objectForKey:@"userName"]] forState:UIControlStateNormal];
        
        [_nuCollectionView setWithNumber:[NSString stringWithFormat:@"%@", [_userDict objectForKey:@"collecNum"]]];
        [_nuIntegraView setWithNumber:[NSString stringWithFormat:@"%@", [_userDict objectForKey:@"integral"]]];
        [_nuDiscountdView setWithNumber:[NSString stringWithFormat:@"%@", [_userDict objectForKey:@"couponNum"]]];
        
        NSString *str = [NSString stringWithFormat:@"%@", [_userDict objectForKey:@"userName"]];
        UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
        CGSize size = CGSizeMake(320,20);
        NSDictionary *dict = @{NSFontAttributeName : nameFnt};
        
        CGSize nameSize = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
        self.userName.frame = CGRectMake((SCREEN_WIDTH  - nameSize.width) / 2 , 115, nameSize.width, 30);
    }
}

#pragma mark -MyNumberViewDelegate
- (void) myNumberView:(MyNumberView *)myNumberView buttonWithTag:(NSInteger)tag name:(NSString *)name{
    if ([self.delegate respondsToSelector:@selector(myHeadTableViewCell:buttonWithTag:name:)]) {
        [self.delegate myHeadTableViewCell:self buttonWithTag:tag name:@"1"];
    }
}

- (void) myButtonUIView:(MyButtonUIView *)myButtonUIView buttonWithTag:(NSInteger)tag name:(NSString *)name{
    if ([self.delegate respondsToSelector:@selector(myHeadTableViewCell:buttonWithTag:name:)]) {
        [self.delegate myHeadTableViewCell:self buttonWithTag:tag name:@"2"];
    }
}

//self.nameLable.text = [_dictData objectForKey:@"name"];
//UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
//CGSize size = CGSizeMake(320,20);
//CGSize nameSize = [self.nameLable.text sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//self.nameLable.frame = CGRectMake(5, 5, nameSize.width + 10, 20);


@end
