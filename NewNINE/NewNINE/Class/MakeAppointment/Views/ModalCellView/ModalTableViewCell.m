//
//  ModalTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/5.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ModalTableViewCell.h"


@interface ModalTableViewCell ()

@property (nonatomic, strong) UIButton  *imageViewBtn;

@property (nonatomic, strong) UILabel   *nameLable;

@property (nonatomic, strong) UILabel   *moneyLable;

@end

@implementation ModalTableViewCell



/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return ModalTableViewCell
 */
+ (instancetype) modalTableViewCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    ModalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
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
    }
    return self;
}


/**
 *  添加cell上的控件
 */
- (void) addUI {
    [self.contentView addSubview:self.imageViewBtn];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
}




-(UIButton *)imageViewBtn {
    if (!_imageViewBtn) {
        _imageViewBtn = [[UIButton alloc] initForAutoLayout];
        [_imageViewBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    return _imageViewBtn;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.textColor = [UIColor redColor];
    }
    return _nameLable;
}

- (UILabel *)moneyLable {
    if (_moneyLable) {
        _moneyLable = [[UILabel alloc] initForAutoLayout];
        _moneyLable.textColor       = [UIColor redColor];
        _moneyLable.textAlignment   = NSTextAlignmentRight;
    }
    return _moneyLable;
}

@end
