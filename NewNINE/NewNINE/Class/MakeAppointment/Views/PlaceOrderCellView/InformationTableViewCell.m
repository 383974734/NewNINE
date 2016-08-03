//
//  InformationTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 信息view

#import "InformationTableViewCell.h"


@interface InformationTableViewCell ()

/** 标题 */
@property (nonatomic, strong) UILabel *titleLable;
/** 内容 */
@property (nonatomic, strong) UILabel *nameLable;


@end

@implementation InformationTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return InformationTableViewCell
 */
+ (instancetype) informationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return InformationTableViewCell
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
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.nameLable];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeRight];
    [self.titleLable autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH / 2 - 15];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 2, 0, 15)];
}


- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.textColor = Color(64, 64, 64, 1);
    }
    return _titleLable;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.textColor = [UIColor lightGrayColor];
        _nameLable.textAlignment = NSTextAlignmentRight;
        _nameLable.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLable;
}


- (void) setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLable.text = _titleStr;
}


- (void) setNameStr:(NSString *)nameStr {
    _nameStr = nameStr;
    self.nameLable.text = _nameStr;
}

@end
