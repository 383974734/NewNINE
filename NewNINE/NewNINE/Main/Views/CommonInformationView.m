//
//  CommonInformationView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 公共的视图   封装   用来介绍设计师信息

#import "CommonInformationView.h"
#import "DesignerViewModel.h"

@interface CommonInformationView ()

/** 介绍信息父视图*/
@property (nonatomic, strong) UIView        *introduceView;
/** 预约按钮*/
@property (nonatomic, strong) UIButton      *appointmentBtn;
/** 发型详情对应头像图片*/
@property (nonatomic, strong) UIImageView   *headImageVIew;
/** 设计师名字*/
@property (nonatomic, strong) UILabel       *nameLable;
/** 级别*/
@property (nonatomic, strong) UILabel       *levelLable;
/** 设计师签名*/
@property (nonatomic, strong) UILabel       *autographLable;
/** 收藏*/
@property (nonatomic, strong) UILabel       *collectionLable;
/** 美单*/
@property (nonatomic, strong) UILabel       *singleLable;
/** 洗剪吹文字*/
@property (nonatomic, strong) UILabel       *titleLable;
/** 价钱*/
@property (nonatomic, strong) UILabel       *priceLable;

/** 竖线一*/
@property (nonatomic, strong) UILabel       *oneLable;
/** 竖线二*/
@property (nonatomic, strong) UILabel       *twoLable;

@end


@implementation CommonInformationView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.introduceView];
    
    [self.introduceView addSubview:self.headImageVIew];
    [self.introduceView addSubview:self.appointmentBtn];
    [self.introduceView addSubview:self.nameLable];
    [self.introduceView addSubview:self.levelLable];
    [self.introduceView addSubview:self.autographLable];
    [self.introduceView addSubview:self.collectionLable];
    [self.introduceView addSubview:self.singleLable];
    [self.introduceView addSubview:self.titleLable];
    [self.introduceView addSubview:self.priceLable];
    [self.introduceView addSubview:self.oneLable];
    [self.introduceView addSubview:self.twoLable];
}

- (void)settingAutoLayout {
    [self.introduceView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.introduceView autoSetDimension:ALDimensionHeight toSize:75];
    
    [self.headImageVIew autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 10, 0) excludingEdge:ALEdgeRight];
    [self.headImageVIew autoSetDimension:ALDimensionWidth toSize:55];
    
    [self.appointmentBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [self.appointmentBtn autoSetDimension:ALDimensionWidth toSize:75];

}

- (void)settingData {
    
}

#pragma mark   -  点击事件
- (void)didBtton:(UIButton *)btn {
    NSLog(@"预约按钮");
    if ([self.delegate respondsToSelector:@selector(commonInformationView:didSelectItemAtIndexPath:)]) {
        [self.delegate commonInformationView:self didSelectItemAtIndexPath:self.indexPath];
    }
}
#pragma mark   -  所有控件懒加载
- (UIView *) introduceView {
    if (!_introduceView) {
        _introduceView = [[UIView alloc] initForAutoLayout];
        _introduceView.backgroundColor = [UIColor whiteColor];
    }
    return _introduceView;
}

- (UIImageView *) headImageVIew {
    //http://blog.csdn.net/wuzehai02/article/details/8546288
    if (!_headImageVIew) {
        _headImageVIew = [[UIImageView alloc] initForAutoLayout];
        _headImageVIew.contentMode          = UIViewContentModeScaleAspectFit;
        _headImageVIew.layer.cornerRadius   = 27;
        _headImageVIew.layer.masksToBounds  = YES;
        _headImageVIew.image                = [UIImage imageNamed:@"发型缺省图"];
    }
    return _headImageVIew;
}

- (UIButton *) appointmentBtn {
    if (!_appointmentBtn) {
        _appointmentBtn = [[UIButton alloc] initForAutoLayout];
        [_appointmentBtn setTitle:@"预约按钮" forState:UIControlStateNormal];
        [_appointmentBtn addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
        _appointmentBtn.backgroundColor = [UIColor lightGrayColor];
        //按钮的图片宽和高一样
    }
    return _appointmentBtn;
}



- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textColor = Color(64, 64, 64, 1);
        _nameLable.font      = SWP_SYSTEM_FONT_SIZE(15);
        _nameLable.lineBreakMode = UILineBreakModeWordWrap;
    }
    return _nameLable;
}

- (UILabel *) levelLable {
    if (!_levelLable) {
        _levelLable = [[UILabel alloc] init];
        _levelLable.layer.borderWidth   = 1;
        _levelLable.layer.cornerRadius  = 2;
        _levelLable.font                = SWP_SYSTEM_FONT_SIZE(10);
        _levelLable.layer.borderColor   = Color(234, 41, 41, 1).CGColor;
        _levelLable.textColor           = Color(234, 41, 41, 1);
        _levelLable.textAlignment       = NSTextAlignmentCenter;
    }
    return _levelLable;
}

- (UILabel *) autographLable {
    if (!_autographLable) {
        _autographLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 34, SCREEN_WIDTH - 180, 18)];
        _autographLable.textColor   = Color(154, 154, 154, 1);
        _autographLable.font        = SWP_SYSTEM_FONT_SIZE(14);
    }
    return _autographLable;
}

- (UILabel *) collectionLable {
    if (!_collectionLable) {
        _collectionLable = [[UILabel alloc] init];
        _collectionLable.textColor  = Color(154, 154, 154, 1);
        _collectionLable.font       = SWP_SYSTEM_FONT_SIZE(10);
    }
    return _collectionLable;
}

- (UILabel *) singleLable {
    if (!_singleLable) {
        _singleLable = [[UILabel alloc] init];
        _singleLable.textColor  = Color(154, 154, 154, 1);
        _singleLable.font       = SWP_SYSTEM_FONT_SIZE(10);
    }
    return _singleLable;
}

- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = Color(154, 154, 154, 1);
        _titleLable.font      = SWP_SYSTEM_FONT_SIZE(10);
        _titleLable.text      = @"洗剪吹";
    }
    return _titleLable;
}

- (UILabel *) priceLable {
    if (!_priceLable) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = [UIColor redColor];
        _priceLable.font      = SWP_SYSTEM_FONT_SIZE(10);
    }
    return _priceLable;
}

- (UILabel *) twoLable {
    if (!_twoLable) {
        _twoLable = [[UILabel alloc] init];
        _twoLable.backgroundColor = Color(154, 154, 154, 1);
    }
    return _twoLable;
}

- (void) setDataModel:(DesignerViewModel *)dataModel {
    _dataModel = dataModel;
    
    [self.headImageVIew sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerIconPhotoUrl] placeholderImage:[UIImage imageNamed:@"发型缺省图" ]];
    
    self.nameLable.text = _dataModel.designerName;
//    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
//    CGSize size = CGSizeMake(320,20);
    CGSize nameSize = [self uiWithConstrained:self.nameLable.text];//[self.nameLable.text sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.nameLable.frame = CGRectMake(80, 12, nameSize.width + 10, 20);
    
    self.levelLable.text = _dataModel.designerLeveName;
    UIFont *levelFnt = [UIFont fontWithName:_dataModel.designerLeveName size:10];
    CGSize levelSize = [self.levelLable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:levelFnt, NSFontAttributeName, nil]];
    self.levelLable.frame = CGRectMake(90 + nameSize.width, 14, levelSize.width, 16);
    
    self.autographLable.text = _dataModel.designerIntroduce;
    
//    UIFont *tempFnt = [UIFont fontWithName:@"Arial" size:10];
//    CGSize tempSize = CGSizeMake(320,14);
    NSString *str = [NSString stringWithFormat:@"%@收藏",_dataModel.designerCollected];
    self.collectionLable.text = str;
    CGSize atempSize = [self uiWithConstrained:self.collectionLable.text];//[self.collectionLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.collectionLable.frame = CGRectMake(80, 53, atempSize.width + 5, 14);
    
    self.oneLable.frame = CGRectMake(atempSize.width + 87, 54, 1, 12);
    
    NSString *strSingle = [NSString stringWithFormat:@"%@美单",_dataModel.designerBought];
    self.singleLable.text = strSingle;
    atempSize = [self uiWithConstrained:self.singleLable.text];//[self.singleLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.singleLable.frame = CGRectMake(90 + self.collectionLable.frame.size.width, 53, atempSize.width + 5, 14);
    
    self.twoLable.frame = CGRectMake(atempSize.width + 97 + self.collectionLable.frame.size.width, 54, 1, 12);
    
    self.titleLable.frame = CGRectMake(self.singleLable.frame.origin.x + self.singleLable.frame.size.width + 10, 53, 40, 14);
    
    NSString *strPrice = [NSString stringWithFormat:@"%@",_dataModel.designerPriceMast];
    self.priceLable.text = strPrice;
    atempSize = [self uiWithConstrained:self.priceLable.text];//[self.priceLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.priceLable.frame = CGRectMake(self.titleLable.frame.origin.x + 30, 53, atempSize.width + 5, 14);
}


- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,20);
    CGSize nameSize = [title sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return nameSize;
}

@end
