//
//  UserMessageTwoTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "UserMessageTwoTableViewCell.h"

#import "UserModel.h"

@interface UserMessageTwoTableViewCell ()
// ---------------------- UI 控件 ----------------------
/** 显示左面文字*/
@property (nonatomic, strong) UILabel       *titleLable;
/** 显示右面文字*/
@property (nonatomic, strong) UILabel       *detailedLable;

// ---------------------- UI 控件 ----------------------

@end
@implementation UserMessageTwoTableViewCell

- (void)awakeFromNib {
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
 *  @return HomeTableViewCell
 */
+ (instancetype) userMessageTwoCellWithTableView:(UITableView *)tableView  {
    static NSString       *cellID   = @"UserMessageTwoTableViewCell";
    UserMessageTwoTableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UserMessageTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType       = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return PopAlertTableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.detailedLable];
}

/**
 *  设置控件自动布局
 */
- (void) settingAutoLayout {
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, SCREEN_WIDTH - 115)];
    
    [self.detailedLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 90, 0, 0)];
}

/**
 *  懒加载  显示左面文字  控件
 */
- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable             = [[UILabel alloc] initForAutoLayout];
        _titleLable.font        = [UIFont systemFontOfSize:15];
        _titleLable.textColor   = Color(64, 64, 64, 1);
    }
    return _titleLable;
}

/**
 *  懒加载  显示右面文字  控件
 */
- (UILabel *) detailedLable {
    if (!_detailedLable) {
        _detailedLable                   = [[UILabel alloc] initForAutoLayout];
        _detailedLable.font              = [UIFont systemFontOfSize:13];
        _detailedLable.textAlignment     = NSTextAlignmentRight;
        _detailedLable.textColor         = Color(154, 154, 154, 1);
    }
    return _detailedLable;
}
/**
 *  set方法
 */
- (void) setTwoUserData:(UserModel *)twoUserData {
    _twoUserData                    = twoUserData;
    self.titleLable.text            = _twoUserData.oneTitle;
    self.detailedLable.hidden       = _twoUserData.twojudge;
    self.detailedLable.text         = _twoUserData.twoTitle;
}


@end
