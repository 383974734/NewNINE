//
//  DesignerViewTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/8.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "DesignerViewTableViewCell.h"
#import "DesignerViewModel.h"

@interface DesignerViewTableViewCell ()

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
/** 设计师图片*/
@property (nonatomic, strong) UIView        *imageviewView;
/** 图片1*/
@property (nonatomic, strong) UIImageView   *oneImageVIew;
/** 图片2*/
@property (nonatomic, strong) UIImageView   *twoImageVIew;
/** 图片3*/
@property (nonatomic, strong) UIImageView   *threeImageVIew;

/** 竖线一*/
@property (nonatomic, strong) UILabel       *oneLable;
/** 竖线二*/
@property (nonatomic, strong) UILabel       *twoLable;

@end


@implementation DesignerViewTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DesignerViewTableViewCell
 */
+ (instancetype) designerViewTableViewCellCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    DesignerViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    cell.backgroundColor    = Color(248, 248, 248, 1);
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return DesignerViewTableViewCell
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
    [self.contentView addSubview:self.introduceView];
    [self.contentView addSubview:self.imageviewView];
    [self.introduceView addSubview:self.headImageVIew];
    [self.introduceView addSubview:self.appointmentBtn];
    [self.introduceView addSubview:self.nameLable];
    [self.introduceView addSubview:self.levelLable];
    [self.introduceView addSubview:self.autographLable];
    [self.introduceView addSubview:self.collectionLable];
    [self.introduceView addSubview:self.singleLable];
    [self.introduceView addSubview:self.titleLable];
    [self.introduceView addSubview:self.priceLable];
    
    [self.imageviewView addSubview:self.oneImageVIew];
    [self.imageviewView addSubview:self.twoImageVIew];
    [self.imageviewView addSubview:self.threeImageVIew];
    
    [self.introduceView addSubview:self.oneLable];
    [self.introduceView addSubview:self.twoLable];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.introduceView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.introduceView autoSetDimension:ALDimensionHeight toSize:75];
    
    [self.headImageVIew autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 10, 0) excludingEdge:ALEdgeRight];
    [self.headImageVIew autoSetDimension:ALDimensionWidth toSize:55];
    
    [self.appointmentBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [self.appointmentBtn autoSetDimension:ALDimensionWidth toSize:75];
    
    [self.imageviewView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(95, 0, 0, 0)];
    
    [self.oneImageVIew autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 0) excludingEdge:ALEdgeRight];
    [self.oneImageVIew autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH / 3 - 10];
    
    [self.twoImageVIew autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.twoImageVIew autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.twoImageVIew autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.oneImageVIew withOffset:5];
    [self.twoImageVIew autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH / 3 - 10];
    
    
    [self.threeImageVIew autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 10) excludingEdge:ALEdgeLeft];
    [self.threeImageVIew autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH / 3 - 10];
}


- (void)didBtton:(UIButton *)btn {
    NSLog(@"预约按钮");
    if ([self.delegate respondsToSelector:@selector(designerViewTableViewCell:stylistinfoId:)]) {
        [self.delegate designerViewTableViewCell:self stylistinfoId:self.dataModel.designerId];
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
//        _headImageVIew.contentMode          = UIViewContentModeScaleAspectFit;
        _headImageVIew.layer.cornerRadius   = 27;
        _headImageVIew.layer.masksToBounds  = YES;
        _headImageVIew.image                = [UIImage imageNamed:@"发型缺省图"];
    }
    return _headImageVIew;
}

- (UIButton *) appointmentBtn {
    if (!_appointmentBtn) {
        _appointmentBtn = [[UIButton alloc] initForAutoLayout];
        [_appointmentBtn setImage:[UIImage imageNamed:@"发型详情"] forState:UIControlStateNormal];
        [_appointmentBtn addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appointmentBtn;
}



- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textColor = Color(64, 64, 64, 1);
        _nameLable.font      = SWP_SYSTEM_FONT_SIZE(15);
//        _nameLable.lineBreakMode = UILineBreakModeWordWrap;
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
        _collectionLable.font       = SWP_SYSTEM_FONT_SIZE(13);
    }
    return _collectionLable;
}

- (UILabel *) singleLable {
    if (!_singleLable) {
        _singleLable = [[UILabel alloc] init];
        _singleLable.textColor  = Color(154, 154, 154, 1);
        _singleLable.font       = SWP_SYSTEM_FONT_SIZE(13);
    }
    return _singleLable;
}

- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = Color(154, 154, 154, 1);
        _titleLable.font      = SWP_SYSTEM_FONT_SIZE(13);
        _titleLable.text      = @"洗剪吹";
    }
    return _titleLable;
}

- (UILabel *) priceLable {
    if (!_priceLable) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = [UIColor redColor];
        _priceLable.font      = SWP_SYSTEM_FONT_SIZE(13);
    }
    return _priceLable;
}


- (UIView *) imageviewView {
    if (!_imageviewView) {
        _imageviewView = [[UIImageView alloc] initForAutoLayout];
    }
    return _imageviewView;
}

- (UIImageView *) oneImageVIew {
    if (!_oneImageVIew) {
        _oneImageVIew = [[UIImageView alloc] initForAutoLayout];
    }
    return _oneImageVIew;
}

- (UIImageView *) twoImageVIew {
    if (!_twoImageVIew) {
        _twoImageVIew = [[UIImageView alloc] initForAutoLayout];
    }
    return _twoImageVIew;
}

- (UIImageView *) threeImageVIew {
    if (!_threeImageVIew) {
        _threeImageVIew = [[UIImageView alloc] initForAutoLayout];
    }
    return _threeImageVIew;
}

- (UILabel *) oneLable {
    if (!_oneLable) {
        _oneLable = [[UILabel alloc] init];
        _oneLable.backgroundColor = Color(154, 154, 154, 1);
    }
    return _oneLable;
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
//    
//    
//    [self.oneImageVIew sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerPhotoOne] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
//    [self.twoImageVIew sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerPhotoTwo] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
//    [self.threeImageVIew sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerPhotoThr] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
//    [self.headImageVIew sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerIconPhotoUrl] placeholderImage:[UIImage imageNamed:@"发型缺省图" ]];
    
    [self.oneImageVIew  sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerPhotoOne]
                            placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   }];
    [self.twoImageVIew  sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerPhotoTwo]
                          placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 }];
    [self.threeImageVIew  sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerPhotoThr]
                          placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 }];
    [self.headImageVIew  sd_setImageWithURL:[NSURL URLWithString:_dataModel.designerIconPhotoUrl]
                          placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 }];
    
    
    self.nameLable.text = _dataModel.designerName;
    CGSize nameSize = [self uiWithConstrained:self.nameLable.text];
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
    atempSize = [self uiWithConstrained:self.singleLable.text];//self.singleLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.singleLable.frame = CGRectMake(90 + self.collectionLable.frame.size.width, 53, atempSize.width + 5, 14);
    
    self.twoLable.frame = CGRectMake(atempSize.width + 97 + self.collectionLable.frame.size.width, 54, 1, 12);
    
    self.titleLable.frame = CGRectMake(self.singleLable.frame.origin.x + self.singleLable.frame.size.width + 10, 53, 40, 14);
    
    NSString *strPrice = [NSString stringWithFormat:@"￥%@",_dataModel.designerPriceMast];
    self.priceLable.text = strPrice;
    atempSize = [self uiWithConstrained:self.priceLable.text];//[self.priceLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.priceLable.frame = CGRectMake(self.titleLable.frame.origin.x + 40, 53, atempSize.width + 5, 14);
    
}


- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,20);

    NSDictionary *dict = @{NSFontAttributeName : nameFnt};
    
    CGSize nameSize = [title boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    return nameSize;
}

@end
