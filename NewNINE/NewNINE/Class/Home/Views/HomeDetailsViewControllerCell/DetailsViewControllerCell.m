//
//  DetailsViewControllerCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情控制器cell

#import "DetailsViewControllerCell.h"
// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface DetailsViewControllerCell ()

/** 发型详情对应图片*/
@property (nonatomic, strong) UIImageView   *detailsImageVIew;
/** 发型详情对应头像图片*/
@property (nonatomic, strong) UIImageView   *headImageVIew;
/** 返回按钮*/
@property (nonatomic, strong) UIButton      *returnBtn;
/** 分享按钮*/
@property (nonatomic, strong) UIButton      *shareBtn;
/** 预约按钮*/
@property (nonatomic, strong) UIButton      *appointmentBtn;
/** 发型详情内容详情*/
@property (nonatomic, strong) UILabel       *detailsLable;

/** 分享和设计师信息描述父视图*/
@property (nonatomic, strong) UIView        *shareView;
/** 介绍信息父视图*/
@property (nonatomic, strong) UIView        *introduceView;

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

/** 收藏图片*/
@property (nonatomic, strong) UIButton      *collectionButton;
/** 收藏数字图片*/
@property (nonatomic, strong) UIImageView   *collectionNumberImageView;
/** 收藏数字控件*/
@property (nonatomic, strong) UILabel       *collectionNumberLable;

/** 竖线一*/
@property (nonatomic, strong) UILabel       *oneLable;
/** 竖线二*/
@property (nonatomic, strong) UILabel       *twoLable;

@end

@implementation DetailsViewControllerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DetailsViewControllerCell
 */
+ (instancetype) detailsCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    DetailsViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    
    cell.backgroundColor    = SWPColor(248, 248, 248, 1);
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return DetailsViewControllerCell
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
    [self.contentView addSubview:self.detailsImageVIew];
    [self.contentView addSubview:self.shareView];
    [self.contentView addSubview:self.introduceView];
    
    [self.shareView addSubview:self.shareBtn];
    [self.shareView addSubview:self.detailsLable];
    
    [self.introduceView addSubview:self.headImageVIew];
    [self.introduceView addSubview:self.appointmentBtn];
    [self.introduceView addSubview:self.nameLable];
    [self.introduceView addSubview:self.levelLable];
    [self.introduceView addSubview:self.autographLable];
    [self.introduceView addSubview:self.collectionLable];
    [self.introduceView addSubview:self.singleLable];
    [self.introduceView addSubview:self.titleLable];
    [self.introduceView addSubview:self.priceLable];
    
    [self.detailsImageVIew addSubview:self.returnBtn];
    [self.detailsImageVIew addSubview:self.collectionButton];
    [self.detailsImageVIew addSubview:self.collectionNumberImageView];
    [self.detailsImageVIew addSubview:self.collectionNumberLable];
    
    [self.introduceView addSubview:self.oneLable];
    [self.introduceView addSubview:self.twoLable];
}

- (void)didBtton:(UIButton *)btn {
    if (btn.tag == 0) {
        if ([self.delegate respondsToSelector:@selector(detailsReturnViewControllerCell:) ]) {
            [self.delegate detailsReturnViewControllerCell:self];
        }
    }else if (btn.tag == 1) {
        if ([self.delegate respondsToSelector:@selector(detailsShareViewControllerCell:)]) {
            [self.delegate detailsShareViewControllerCell:self];
        }
    }else if (btn.tag == 2) {
        if ([self.delegate respondsToSelector:@selector(detailsAppointmentBtnViewControllerCell: didSelectRowAtIndexPath:)]) {
            [self.delegate detailsAppointmentBtnViewControllerCell:self didSelectRowAtIndexPath:self.indexPath];
        }
    }else if (btn.tag == 3) {
        if ([self.delegate respondsToSelector:@selector(detailsCollectionViewControllerCell:)]) {
            [self.delegate detailsCollectionViewControllerCell:self];
        }
    }
    
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.detailsImageVIew autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.detailsImageVIew autoSetDimension:ALDimensionHeight toSize:SCREEN_WIDTH];
    
    [self.shareView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.shareView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.shareView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.detailsImageVIew withOffset:0];
    [self.shareView autoSetDimension:ALDimensionHeight toSize:60];
    
    [self.introduceView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.introduceView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.introduceView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.shareView withOffset:10];
    [self.introduceView autoSetDimension:ALDimensionHeight toSize:75];
    
    [self.returnBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.returnBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    [self.returnBtn autoSetDimension:ALDimensionHeight toSize:36];
    [self.returnBtn autoSetDimension:ALDimensionWidth toSize:36];
    
    [self.headImageVIew autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 10, 0) excludingEdge:ALEdgeRight];
    [self.headImageVIew autoSetDimension:ALDimensionWidth toSize:55];
    
    [self.shareBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 10) excludingEdge:ALEdgeLeft];
    [self.shareBtn autoSetDimension:ALDimensionWidth toSize:60];
    
    [self.appointmentBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [self.appointmentBtn autoSetDimension:ALDimensionWidth toSize:75];
    
    [self.detailsLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 10, 100)];

    
}

#pragma mark   -  所有控件懒加载
- (UIImageView *) detailsImageVIew {
    if (!_detailsImageVIew) {
        _detailsImageVIew = [[UIImageView alloc] initForAutoLayout];
        _detailsImageVIew.userInteractionEnabled = YES;
        
    }
    return _detailsImageVIew;
}

- (UIView *) shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc] initForAutoLayout];
        _shareView.backgroundColor = [UIColor whiteColor];
    }
    return _shareView;
}

- (UIView *) introduceView {
    if (!_introduceView) {
        _introduceView = [[UIView alloc] initForAutoLayout];
        _introduceView.backgroundColor = [UIColor whiteColor];
    }
    return _introduceView;
}

- (UIButton *) returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] initForAutoLayout];
        [_returnBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        _returnBtn.tag = 0;
        [_returnBtn addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

- (UIButton *) shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] initForAutoLayout];
        [_shareBtn setImage:[UIImage imageNamed:@"Group 2"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.tag = 1;
    }
    return _shareBtn;
}

- (UIButton *) appointmentBtn {
    if (!_appointmentBtn) {
        _appointmentBtn = [[UIButton alloc] initForAutoLayout];
        [_appointmentBtn setImage:[UIImage imageNamed:@"发型详情"] forState:UIControlStateNormal];
        [_appointmentBtn addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
        _appointmentBtn.tag = 2;

    }
    return _appointmentBtn;
}

- (UILabel *) detailsLable {
    if (!_detailsLable) {
        _detailsLable = [[UILabel alloc] initForAutoLayout];
        _detailsLable.numberOfLines = 2;
        _detailsLable.textColor = Color(64, 64, 64, 1);
        _detailsLable.font = SWP_SYSTEM_FONT_SIZE(15);
    }
    return _detailsLable;
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

- (UILabel *) collectionNumberLable {
    if (!_collectionNumberLable) {
        _collectionNumberLable  = [[UILabel alloc] initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH - 53, 36)];
        _collectionNumberLable.textAlignment = NSTextAlignmentRight;
        _collectionNumberLable.textColor = [UIColor whiteColor];
        _collectionNumberLable.font = SWP_SYSTEM_FONT_SIZE(12);
    }
    return _collectionNumberLable;
}

- (UIButton *) collectionButton {
    if (!_collectionButton) {
        _collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 51.5, 40, 37, 36)];
//        _collectionButton.image = [UIImage imageNamed:@"已收藏-+nub--拷贝1"];
        _collectionButton.tag = 3;
        [_collectionButton addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}

- (UIImageView *) collectionNumberImageView {
    if (!_collectionNumberImageView) {
        _collectionNumberImageView = [[UIImageView alloc] init];
//        _collectionNumberImageView.image = [UIImage imageNamed:@"已收藏-+nub--拷贝-2"];
    }
    return _collectionNumberImageView;
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

- (void) setDetailsDict:(NSDictionary *)detailsDict {
    _detailsDict = detailsDict;
    if (detailsDict != nil) {
        NSLog(@"%@", [_detailsDict objectForKey:@"linkType"]);
        if ([[_detailsDict objectForKey:@"linkType"] intValue] == 2) {
            self.introduceView.hidden = YES;
        }else {
            self.introduceView.hidden = NO;
        }
   
        [_detailsImageVIew  sd_setImageWithURL:[NSURL URLWithString:[_detailsDict objectForKey:@"mainPhoto"]]
        placeholderImage:[UIImage imageNamed:@"banner缺省图"]
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        
        self.detailsLable.text = [_detailsDict objectForKey:@"infoDescription"];
        
        if ([[_detailsDict objectForKey:@"isCollect"] intValue] == 1) {
            NSLog(@"收藏过");
            [_collectionButton setImage:[UIImage imageNamed:@"已收藏-+nub--拷贝"] forState:UIControlStateNormal];
        }
        if ([[_detailsDict objectForKey:@"isCollect"] intValue] == 2) {
            NSLog(@"没收藏过");
            [_collectionButton setImage:[UIImage imageNamed:@"已收藏-+nub--拷贝1"] forState:UIControlStateNormal];
        }
        
        self.collectionNumberLable.text = [NSString stringWithFormat:@"%@", [_detailsDict objectForKey:@"collectCount"]];
        UIFont *fntimage = [UIFont fontWithName:_collectionNumberLable.text size:12];
        CGSize sizeimage = [_collectionNumberLable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fntimage, NSFontAttributeName, nil]];
        CGFloat numberW = sizeimage.width;
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 10, 0, 0);
        UIImage *image = [UIImage imageNamed:@"已收藏-+nub--拷贝-2"];
        _collectionNumberImageView.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        _collectionNumberImageView.frame = CGRectMake(SCREEN_WIDTH - numberW - 60, 41, numberW + 10, 36);
        
        if ([[_detailsDict objectForKey:@"stylistInfos"] count] > 0) {

            
            [self.headImageVIew  sd_setImageWithURL:[NSURL URLWithString:[[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"iconPhotoUrl"]]
                                   placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          }];
            

            self.nameLable.text = [[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"name"];

            CGSize nameSize = [self uiWithConstrained:self.nameLable.text];
            self.nameLable.frame = CGRectMake(80, 12, nameSize.width + 10, 20);
            
            self.levelLable.text = [[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"leveName"];
           
            CGSize levelSize = [self uiWithConstrained:self.levelLable.text];
            self.levelLable.frame = CGRectMake(90 + nameSize.width, 14, levelSize.width, 16);
            
            self.autographLable.text = [[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"introduce"];
 
            
            self.collectionLable.text = [NSString stringWithFormat:@"%@收藏", [[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"collected"]];
            CGSize atempSize = [self uiWithConstrained:self.collectionLable.text];
            self.collectionLable.frame = CGRectMake(80, 53, atempSize.width + 5, 14);
            
            self.oneLable.frame = CGRectMake(atempSize.width + 87, 54, 1, 12);
            
            self.singleLable.text = [NSString stringWithFormat:@"%@美单", [[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"bought"]];
            atempSize = [self uiWithConstrained:self.singleLable.text];
            self.singleLable.frame = CGRectMake(90 + self.collectionLable.frame.size.width, 53, atempSize.width + 5, 14);
            
            self.twoLable.frame = CGRectMake(atempSize.width + 97 + self.collectionLable.frame.size.width, 54, 1, 12);
            
            self.titleLable.frame = CGRectMake(self.singleLable.frame.origin.x + self.singleLable.frame.size.width + 10, 53, 40, 14);
            
            self.priceLable.text = [NSString stringWithFormat:@"￥%@", [[_detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"priceMast"]];
            atempSize = [self uiWithConstrained:self.priceLable.text];
            self.priceLable.frame = CGRectMake(self.titleLable.frame.origin.x + 40, 53, atempSize.width + 5, 14);
        }
    }
}

- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:14];
    CGSize size = CGSizeMake(320,20);

    NSDictionary *dict = @{NSFontAttributeName : nameFnt};
    
    CGSize nameSize = [title boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    return nameSize;
}

@end




//UIFont *fnt = [UIFont fontWithName:collectionLable.text size:12];
//CGSize size = [collectionLable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt, NSFontAttributeName, nil]];
//CGFloat numberW = size.width;

//  图片拉伸方法
//UIEdgeInsets insets = UIEdgeInsetsMake(0, 10, 0, 0);
//UIImage *image = [UIImage imageNamed:@"已收藏-+nub--拷贝-2"];
//collectionBGimage.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];