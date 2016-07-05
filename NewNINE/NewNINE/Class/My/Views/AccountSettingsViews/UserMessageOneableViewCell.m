//
//  UserMessageOneableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "UserMessageOneableViewCell.h"

#import "UserModel.h"

@interface UserMessageOneableViewCell ()
// ---------------------- UI 控件 ----------------------
/** 显示左面文字*/
@property (nonatomic, strong) UILabel       *titleLable;
/** 显示右面文字*/
@property (nonatomic, strong) UILabel       *detailedLable;
/** 显示右面图片*/
@property (nonatomic, strong) UIImageView   *detailedimageView;
///** 显示用户个人信息背景图片那条线的view*/
//@property (nonatomic, strong) UIImageView   *backgroundImageView;
// ---------------------- UI 控件 ----------------------

@end

@implementation UserMessageOneableViewCell

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
 *  @return UserMessageOneableViewCell
 */
+ (instancetype) userMessageOneCellWithTableView:(UITableView *)tableView {
    static NSString       *cellID   = @"UserMessageOneableViewCell";
    UserMessageOneableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UserMessageOneableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType     = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return UserMessageOneableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self settingAutoLayout];
    }
    return self;
}

- (void) addUI {

    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.detailedLable];
    [self.contentView addSubview:self.detailedimageView];
}


- (void) settingAutoLayout {
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, SCREEN_WIDTH - 115)];
    
    [self.detailedLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 90, 0, 0)];
    
    [self.detailedimageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(13 * 0.5, 0, 13 * 0.5, 0) excludingEdge:ALEdgeLeft];
    [self.detailedimageView autoSetDimension:ALDimensionWidth toSize:68 * 0.5];
    
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
        _detailedLable = [[UILabel alloc] initForAutoLayout];
        _detailedLable.font              = [UIFont systemFontOfSize:13];
        _detailedLable.textAlignment     = NSTextAlignmentRight;
        _detailedLable.textColor         = Color(154, 154, 154, 1);
    }
    return _detailedLable;
}

/**
 *  懒加载  显示右面图片  控件
 */
- (UIImageView *) detailedimageView {
    if (!_detailedimageView) {
        _detailedimageView = [[UIImageView alloc] initForAutoLayout];
        _detailedimageView.layer.cornerRadius  = 15.5;
        _detailedimageView.layer.masksToBounds = YES;
        _detailedimageView.image = [UIImage imageNamed:@"160Wow"];
    }
    return _detailedimageView;
}

/**
 *  set方法
 */
- (void) setUserData:(UserModel *)userData {
    _userData                   = userData;
    _titleLable.text            = _userData.oneTitle;
    _detailedimageView.hidden   = _userData.onejudge;
    _detailedLable.hidden       = _userData.twojudge;
    
    
    [_detailedimageView sd_setImageWithURL:[NSURL URLWithString:_userData.userIconPhotoUrl] placeholderImage:[UIImage imageNamed:@"160Wow"]];
    _detailedLable.text         = _userData.userName;
    
}

@end
