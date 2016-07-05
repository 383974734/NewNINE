//
//  CollectionTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "CollectionTableViewCell.h"


// ---------------------- view       ----------------------
#import "CommonInformationView.h"
#import "DesignerViewModel.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface CollectionTableViewCell ()<CommonInformationViewDelegate>
#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

@property (nonatomic, strong) CommonInformationView *viewCommon;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------


@end

@implementation CollectionTableViewCell
/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return CollectionTableViewCell
 */
+ (instancetype) collectionCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
 *  @return CollectionTableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        self.backgroundColor = SWPColor(248, 248, 248, 1);
    }
    return self;
}

/**
 *  添加cell上的控件
 */
- (void) addUI {
    [self.contentView addSubview:self.viewCommon];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.viewCommon autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


- (void) commonInformationView:(CommonInformationView *)commonInformationView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(CollectionTableViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate CollectionTableViewCell:self didSelectItemAtIndexPath:self.indexPath];
    }
}

- (CommonInformationView *) viewCommon {
    if (!_viewCommon) {
        _viewCommon = [[CommonInformationView alloc] initForAutoLayout];
        _viewCommon.delegate = self;
    }
    return _viewCommon;
}

- (void)setDataModel:(DesignerViewModel *)dataModel {
    _dataModel = dataModel;
    _viewCommon.dataModel = _dataModel;
}

@end
