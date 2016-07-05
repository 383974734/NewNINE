//
//  StoreAddressTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "StoreAddressTableViewCell.h"

#import "StoreAddressModel.h"

@interface StoreAddressTableViewCell ()

/** 地址*/
@property (nonatomic, strong) UILabel       *addr;
/** 名字*/
@property (nonatomic, strong) UILabel       *names;
/** 图片*/
@property (nonatomic, strong) UIImageView   *photoUrl;
/** 电话图片*/
@property (nonatomic, strong) UIImageView   *phoneImageView;
/** 地址图片*/
@property (nonatomic, strong) UIImageView   *addrImageView;
/** 电话*/
@property (nonatomic, strong) UILabel      *phone;

@end

@implementation StoreAddressTableViewCell


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return StoreAddressTableViewCell
 */
+ (instancetype) soreAddressCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    StoreAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    //    cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;//箭头
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return StoreAddressTableViewCell
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
    [self.contentView addSubview:self.addr];
    [self.contentView addSubview:self.names];
    [self.contentView addSubview:self.photoUrl];
    [self.contentView addSubview:self.phoneImageView];
    [self.contentView addSubview:self.addrImageView];
    [self.contentView addSubview:self.phone];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.photoUrl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(7, 0, 7, 15) excludingEdge:ALEdgeLeft];
    [self.photoUrl autoSetDimension:ALDimensionWidth toSize:60];
    
    [self.names autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(8, 15, 0, 80) excludingEdge:ALEdgeBottom];
    [self.names autoSetDimension:ALDimensionWidth toSize:17];
    
    [self.phoneImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.names withOffset:5];
    [self.phoneImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.phoneImageView autoSetDimension:ALDimensionWidth toSize:10];
    [self.phoneImageView autoSetDimension:ALDimensionHeight toSize:10];
    
    [self.addrImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneImageView withOffset:5];
    [self.addrImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.addrImageView autoSetDimension:ALDimensionWidth toSize:10];
    [self.addrImageView autoSetDimension:ALDimensionHeight toSize:10];
    
    [self.phone autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.phoneImageView withOffset:5];
    [self.phone autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.names withOffset:5];
    [self.phone autoSetDimension:ALDimensionWidth toSize:200];
    [self.phone autoSetDimension:ALDimensionHeight toSize:14];

    [self.addr autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.addrImageView withOffset:5];
    [self.addr autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phone withOffset:0];
    [self.addr autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.photoUrl withOffset:5];
    [self.addr autoSetDimension:ALDimensionHeight toSize:17];
}


- (UILabel *) addr {
    if (!_addr) {
        _addr = [[UILabel alloc] initForAutoLayout];
        _addr.font = SWP_SYSTEM_FONT_SIZE(12);
        _addr.textColor = Color(154, 154, 154, 1);
    }
    return _addr;
}

- (UILabel *) names {
    if (!_names) {
        _names = [[UILabel alloc] initForAutoLayout];
        _names.font = SWP_SYSTEM_FONT_SIZE(14);
        _names.textColor = Color(64, 64, 64, 1);
        _names.text= @"sdfasdfasdfasd";
    }
    return _names;
}

- (UIImageView *) phoneImageView {
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc] initForAutoLayout];
        _phoneImageView.image = [UIImage imageNamed:@"tel"];
    }
    return _phoneImageView;
}

- (UIImageView *) photoUrl {
    if (!_photoUrl) {
        _photoUrl = [[UIImageView alloc] initForAutoLayout];
        _photoUrl.image = [UIImage imageNamed:@"发型缺省图"];
        
    }
    return _photoUrl;
}

- (UIImageView *) addrImageView {
    if (!_addrImageView) {
        _addrImageView = [[UIImageView alloc] initForAutoLayout];
        _addrImageView.image = [UIImage imageNamed:@"address"];
    }
    return _addrImageView;
}

- (UILabel *) phone {
    if (!_phone) {
        _phone = [[UILabel alloc] initForAutoLayout];
        _phone.font = SWP_SYSTEM_FONT_SIZE(12);
        _phone.textColor = Color(154, 154, 154, 1);
    }
    return _phone;
}

- (void) setDataModel:(StoreAddressModel *)dataModel {
    _dataModel      = dataModel;
    self.phone.text = _dataModel.storeAddressPhone;
    self.names.text = _dataModel.storeAddressNames;
    self.addr.text  = _dataModel.storeAddressShopDistrict;
    [self.photoUrl sd_setImageWithURL:[NSURL URLWithString:_dataModel.storeAddressPhotoUrl] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
}

@end
