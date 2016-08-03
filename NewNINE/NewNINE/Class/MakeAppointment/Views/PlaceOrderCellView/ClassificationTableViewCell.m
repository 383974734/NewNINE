//
//  ClassificationTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 分类view

#import "ClassificationTableViewCell.h"

#import "orderViewModel.h"


@interface ClassificationTableViewCell ()
/** 头像view*/
@property (nonatomic, strong) UIImageView *headImageView;
/** 点view*/
@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *nameLable;

@end

@implementation ClassificationTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return ClassificationTableViewCell
 */
+ (instancetype) classificationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    ClassificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return ClassificationTableViewCell
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
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.nameLable];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];

    [self.userImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 20, 20, 0) excludingEdge:ALEdgeRight];
    [self.userImageView autoSetDimension:ALDimensionWidth toSize:5];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 15) excludingEdge:ALEdgeLeft];
    [self.nameLable autoSetDimension:ALDimensionWidth toSize:110];
    
//    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 35, 0, 0) excludingEdge:ALEdgeRight];
//    [self.titleLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.nameLable withOffset:-5];

}



-(UIImageView *)userImageView {
    if (!_userImageView) {
        _userImageView                      = [[UIImageView alloc] initForAutoLayout];
        _userImageView.backgroundColor      = [UIColor lightGrayColor];
        _userImageView.layer.masksToBounds  = YES;
        _userImageView.layer.cornerRadius   = 5;
    }
    return _userImageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable                           = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, SCREEN_WIDTH - 175, 45)];
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.backgroundColor           = [UIColor whiteColor];
    }
    return _titleLable;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable                           = [[UILabel alloc] initForAutoLayout];
        _nameLable.adjustsFontSizeToFitWidth = YES;
        _nameLable.textAlignment             = NSTextAlignmentRight;
    }
    return _nameLable;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 4, 40, 40)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius  = 20;
        _headImageView.image               = [UIImage imageNamed:@"logo144"];
    }
    return _headImageView;
}

- (void)setClassificationStr:(NSString *)classificationStr {
    _classificationStr = classificationStr;
    [self componentsSeparatedByString:_classificationStr];
}

- (void)componentsSeparatedByString:(NSString *)str {
    if ([[str componentsSeparatedByString:@","][0] isEqualToString:@"合计"]) {
        self.titleLable.frame     = CGRectMake(20, 0, SCREEN_WIDTH - 175, 45);
        self.titleLable.textColor = Color(64, 64, 64, 1);
        self.nameLable.textColor  = [UIColor redColor];
    }else {
        self.titleLable.frame      = CGRectMake(35, 0, SCREEN_WIDTH - 175, 45);
        self.titleLable.textColor  = [UIColor lightGrayColor];
        self.nameLable.textColor   = [UIColor lightGrayColor];
    }
    self.titleLable.text = [str componentsSeparatedByString:@","][0];
    self.nameLable.text  = [NSString stringWithFormat:@"￥%@", [str componentsSeparatedByString:@","][1]];
}


- (void) setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

-(void) setMakeAppointmentDic:(NSDictionary *)makeAppointmentDic {
    _makeAppointmentDic = makeAppointmentDic;
    if (self.indexPath.row == 0) {
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_makeAppointmentDic objectForKey:@"iconPhotoUrl"]]] placeholderImage:[UIImage imageNamed:@"logo144"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        self.headImageView.hidden = NO;
        self.userImageView.hidden = YES;
        self.titleLable.frame     = CGRectMake(70, 0, SCREEN_WIDTH - 175, 45);
        self.titleLable.textColor = Color(64, 64, 64, 1);
        self.nameLable.textColor  = [UIColor lightGrayColor];
        self.titleLable.text      = [NSString stringWithFormat:@"%@", [_makeAppointmentDic objectForKey:@"name"]];
        self.nameLable.text       = [NSString stringWithFormat:@"%@", [_makeAppointmentDic objectForKey:@"leveName"]];
    }else {
        self.headImageView.hidden = YES;
        self.userImageView.hidden = NO;
    }

}


- (void) setOrderViewModel:(OrderViewModel *)orderViewModel {
    _orderViewModel = orderViewModel;
    
    if (self.indexPath.row == 0) {
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _orderViewModel.orderIconPhotoUrl]] placeholderImage:[UIImage imageNamed:@"logo144"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        self.headImageView.hidden = NO;
        self.userImageView.hidden = YES;
        self.titleLable.frame     = CGRectMake(70, 0, SCREEN_WIDTH - 175, 45);
        self.titleLable.textColor = Color(64, 64, 64, 1);
        self.nameLable.textColor  = [UIColor lightGrayColor];
        self.titleLable.text      = [NSString stringWithFormat:@"%@", _orderViewModel.orderName];
        self.nameLable.text       = [NSString stringWithFormat:@"%@", _orderViewModel.orderLeveName];
    }else {
        self.headImageView.hidden = YES;
        self.userImageView.hidden = YES;
        if (_orderViewModel.OrderBookProducts.count >= self.indexPath.row) {
            self.titleLable.textColor  = [UIColor lightGrayColor];
            self.nameLable.textColor   = [UIColor lightGrayColor];
            self.nameLable.text        = [NSString stringWithFormat:@"￥%@", [_orderViewModel.OrderBookProducts[self.indexPath.row - 1] objectForKey:@"price"]];
            self.titleLable.text       = [_orderViewModel.OrderBookProducts[self.indexPath.row - 1] objectForKey:@"productName"];
        }else {
            self.titleLable.textColor = Color(64, 64, 64, 1);
            self.nameLable.textColor  = [UIColor redColor];
            self.nameLable.text       = [NSString stringWithFormat:@"￥%@",self.orderViewModel.orderOrderMoney];
            self.titleLable.text      = @"合计";
        }
    }
}

@end
