//
//  MyContentTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MyContentTableViewCell.h"

@interface MyContentTableViewCell ()

@property (nonatomic, strong) UIImageView *myImageView;

@property (nonatomic, strong) UILabel     *myLable;

@property (nonatomic, strong) UIImageView *nextImageView;

@end

@implementation MyContentTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MyContentTableViewCell
 */
+ (instancetype) myContentCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    MyContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
//    cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;//箭头
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return MyContentTableViewCell
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
    [self.contentView addSubview:self.myImageView];
    [self.contentView addSubview:self.myLable];
    [self.contentView addSubview:self.nextImageView];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
}

- (UIImageView *) myImageView{
    if (!_myImageView) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
    }
    return _myImageView;
}

- (UILabel *) myLable {
    if (!_myLable) {
        _myLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 80, 24)];
        _myLable.textColor = Color(64, 64, 64, 1);
    }
    return _myLable;
}

- (UIImageView *) nextImageView {
    if (!_nextImageView) {
        _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 25, 16, 13, 13)];
        _nextImageView.image = [UIImage imageNamed:@"进入箭头"];
    }
    return _nextImageView;
}

- (void) setStrLable:(NSString *)strLable {
    _strLable = strLable;
    self.myLable.text = _strLable;
}

- (void) setStrImage:(NSString *)strImage {
    _strImage = strImage;
    self.myImageView.image = [UIImage imageNamed:_strImage];
}
@end
