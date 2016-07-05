//
//  HomeBannerTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 轮播视图

#import "HomeBannerTableViewCell.h"

// ---------------------- view       ----------------------
#import "STBannerView.h"            // 轮播
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface HomeBannerTableViewCell ()<STBannerViewDelegate, StBannerViewDataSource>

/** 轮播*/
@property (nonatomic, strong) STBannerView *stBannerView;

@end

@implementation HomeBannerTableViewCell

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
 *  @return HomeBannerTableViewCell
 */
+ (instancetype) homeBannerCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    HomeBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return HomeBannerTableViewCell
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
    [self.contentView addSubview:self.stBannerView];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.stBannerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

/**
 *  刷新轮播数据
 */
- (void)refreshData {
    [self.stBannerView stBannerReloadData];
}

#pragma mark - SwpBannerView DataSource Methods

/**
 *  StBannerView 数据源方法 (设置 swpBannerView 分组的 个数)
 *
 *  @param  swpBannerView
 *
 *  @return NSInteger
 */
- (NSInteger)stBannerViewNmberOfSections:(STBannerView *)swpBannerView {
    return 1;
}


/**
 *  STBannerView 数据源方法 (设置 swpBannerView 每个分组显示数据的个数)
 *
 *  @param  stBannerView
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger)stBannerView:(STBannerView *)stBannerView numberOfItemsInSection:(NSInteger)section {
//        NSLog(@"看看有几个小点点 --- %lu", (unsigned long)self.bannerArray.count);
    return self.bannerArray.count;
}

/**
 *  STBannerView 数据源方法 (设置 swpBannerView 显示默认的cell 显示图片的名称)
 *
 *  (注意: stCustomCell 值 为 NO 时 才会调用， stCustomCell 默认为 NO)
 *
 *  @param  stBannerView
 *  @param  indexPath
 *
 *  @return NSString
 */
- (NSString *)stBannerView:(STBannerView *)swpBannerView cellTitleForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bannerArray[indexPath.row];
}


#pragma mark - SwpBannerView Deleage Methods

/**
 *  STBannerView 代理方法 (点击 swpBannerView 每个cell调用代理方法)
 *
 *  @param stBannerView
 *  @param indexPath
 */
- (void)stBannerView:(STBannerView *)stBannerView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(stPushBannerView:didSelectItemAtIndexPath:)]) {
        [self.delegate stPushBannerView:self didSelectItemAtIndexPath:indexPath];
    }
    
}


#pragma mark   -  所有控件懒加载
/**
 *  轮播
 *
 *  @return STBannerView
 */
- (STBannerView *) stBannerView {
    if (!_stBannerView) {
        _stBannerView = [[STBannerView alloc] initForAutoLayout];
        _stBannerView.stBannerBounces           = NO;
        _stBannerView.delegate                  = self;
        _stBannerView.dataSource                = self;
        _stBannerView.stBannerPageControlHidden = YES;
        _stBannerView.numberOfPagesColor        = [UIColor whiteColor];
    }
    return _stBannerView;
}


- (void) setBannerArray:(NSArray *)bannerArray {
    _bannerArray = bannerArray;
    [self refreshData];
}

@end
