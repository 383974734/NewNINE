//
//  HomeStarHotTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 明星标题、明星轮播、热门标题 视图

#import "HomeStarHotTableViewCell.h"

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface HomeStarHotTableViewCell ()

/** 明星*/
@property (nonatomic, strong) UIView *starView;
/** 热门*/
@property (nonatomic, strong) UIView *hotView;

@end

@implementation HomeStarHotTableViewCell

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
 *  @return HomeStarHotTableViewCell
 */
+ (instancetype) homeStarHotCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    HomeStarHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return HomeStarHotTableViewCell
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
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.hotView];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.starView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.starView autoSetDimension:ALDimensionHeight toSize:39];
    [self.hotView  autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.hotView  autoSetDimension:ALDimensionHeight toSize:39];
}

#pragma mark   -  所有控件懒加载
- (UIView *) starView {
    if (!_starView) {
        _starView = [[UIView alloc] initForAutoLayout];
        _starView.backgroundColor = [UIColor redColor];
    }
    return _starView;
}

- (UIView *) hotView {
    if (!_hotView) {
        _hotView = [[UIView alloc] initForAutoLayout];
        _hotView.backgroundColor = [UIColor orangeColor];
    }
    return _hotView;
}

@end
