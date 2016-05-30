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

/** 发型详情对用图片*/
@property (nonatomic, strong) UIImageView *detailsImageVIew;
@property (nonatomic, strong) UIButton *returnBtn;

/** 分享和设计师信息描述父视图*/
@property (nonatomic, strong) UIView *shareView;
/** 介绍信息父视图*/
@property (nonatomic, strong) UIView *introduceView;

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
    [self.detailsImageVIew addSubview:self.returnBtn];
}

- (void)didBtton:(UIButton *)btn {
    
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
    [self.returnBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:18];
    [self.returnBtn autoSetDimension:ALDimensionHeight toSize:36];
    [self.returnBtn autoSetDimension:ALDimensionWidth toSize:36];
}

#pragma mark   -  所有控件懒加载
- (UIImageView *) detailsImageVIew {
    if (!_detailsImageVIew) {
        _detailsImageVIew = [[UIImageView alloc] initForAutoLayout];
    }
    return _detailsImageVIew;
}

- (UIView *) shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc] initForAutoLayout];
    }
    return _shareView;
}

- (UIView *) introduceView {
    if (!_introduceView) {
        _introduceView = [[UIView alloc] initForAutoLayout];
    }
    return _introduceView;
}

- (UIButton *) returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] initForAutoLayout];
        [_returnBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(didBtton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

- (void) setDetailsDict:(NSDictionary *)detailsDict {
    _detailsDict = detailsDict;
    if (detailsDict != nil) {
        [_detailsImageVIew sd_setImageWithURL:[NSURL URLWithString:[_detailsDict objectForKey:@"mainPhoto"]] placeholderImage:[UIImage imageNamed:@"banner缺省图"]];
    }
}

@end
