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
#import "HomeBannerModels.h"
// ---------------------- model      ----------------------

@interface HomeStarHotTableViewCell ()<UIScrollViewDelegate>

/** 明星*/
@property (nonatomic, strong) UIView        *starView;
/** 热门*/
@property (nonatomic, strong) UIView        *hotView;
/** 明星 红色竖线*/
@property (nonatomic, strong) UIImageView   *starImageView;
/** 热门 红色竖线*/
@property (nonatomic, strong) UIImageView   *hotImageView;
/** 明星 文字*/
@property (nonatomic, strong) UILabel       *starLabel;
/** 热门 文字*/
@property (nonatomic, strong) UILabel       *hotLabel;
/** 明星 轮播*/
@property (nonatomic, strong) UIScrollView  *starScrollerView;
/** 明星 轮播图片*/
@property (nonatomic, strong) UIImageView   *starScrollerImageView;

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
//    [self.contentView addSubview:self.starScrollerView];
    
    [self.starView addSubview:self.starImageView];
    [self.hotView  addSubview:self.hotImageView];
    [self.starView addSubview:self.starLabel];
    [self.hotView  addSubview:self.hotLabel];
    
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.starView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.starView autoSetDimension:ALDimensionHeight toSize:39];
    
    [self.starScrollerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(39, 0, 39, 0)];
    
    [self.hotView  autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.hotView  autoSetDimension:ALDimensionHeight toSize:39];
    
    [self.starImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 20, 12, 0) excludingEdge:ALEdgeRight];
    [self.starImageView autoSetDimension:ALDimensionWidth toSize:2];
    
    [self.hotImageView  autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 20, 12, 0) excludingEdge:ALEdgeRight];
    [self.hotImageView  autoSetDimension:ALDimensionWidth toSize:2];
    
    [self.starLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(4, 30, 4, 0)];
    
    [self.hotLabel  autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(4, 30, 4, 0)];
  
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark   -  所有控件懒加载
- (UIView *) starView {
    if (!_starView) {
        _starView = [[UIView alloc] initForAutoLayout];
        _starView.backgroundColor = [UIColor whiteColor];
    }
    return _starView;
}

- (UIView *) hotView {
    if (!_hotView) {
        _hotView = [[UIView alloc] initForAutoLayout];
        _hotView.backgroundColor = [UIColor whiteColor];
    }
    return _hotView;
}

- (UIImageView *) starImageView {
    if (!_starImageView) {
        _starImageView = [[UIImageView alloc] initForAutoLayout];
        _starImageView.backgroundColor = [UIColor redColor];
    }
    return _starImageView;
}

- (UIImageView *) hotImageView {
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc] initForAutoLayout];
        _hotImageView.backgroundColor = [UIColor redColor];
    }
    return _hotImageView;
}

- (UILabel *) starLabel {
    if (!_starLabel) {
        _starLabel = [[UILabel alloc] initForAutoLayout];
        _starLabel.text = @"STYLIST 明星设计师";
        _starLabel.font = SWP_SYSTEM_FONT_SIZE(16);
        _starLabel.textColor = SWPColor(64, 64, 64, 1);
    }
    return _starLabel;
}

- (UILabel *) hotLabel {
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc] initForAutoLayout];
        _hotLabel.text = @"HAIRSTYLE 热门发型";
        _hotLabel.font = SWP_SYSTEM_FONT_SIZE(16);
        _hotLabel.textColor = SWPColor(64, 64, 64, 1);
    }
    return _hotLabel;
}

- (UIScrollView *) starScrollerView {
    //http://www.xuanyusong.com/archives/1713
    if (!_starScrollerView) {
        _starScrollerView = [[UIScrollView alloc] initForAutoLayout];
        _starScrollerView.delegate          = self;
        _starScrollerView.backgroundColor   = SWPColor(248, 248, 248, 1);
        _starScrollerView.bounces           = YES;
        _starScrollerView.pagingEnabled     = YES;
        _starScrollerView.contentInset      = UIEdgeInsetsMake(0, 15, 0, 0);
        _starScrollerView.showsHorizontalScrollIndicator = NO;

    }
    return _starScrollerView;
}

- (void) setStarHotArray:(NSArray *)starHotArray {
    _starHotArray = starHotArray;

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0 ; self.starHotArray.count > i; i++) {
        [array addObject:self.starHotArray[i]];
    }
    [array insertObject:@"http:baidu" atIndex:self.starHotArray.count];
    
    for (int i = 0; (self.starHotArray.count + 1) > i; i++) {
        int a = [NSString stringWithFormat:@"%lu", (unsigned long)self.starHotArray.count].intValue + 1;
        
        self.starScrollerView.contentSize           = CGSizeMake(SCREEN_WIDTH * a + 15, SCREEN_HEIGHT * 0.37 - 100);
        self.starScrollerImageView                  = [[UIImageView alloc] init];
        self.starScrollerImageView.layer.borderWidth = 1;
        self.starScrollerImageView.frame            = CGRectMake((i * (SCREEN_WIDTH - 50)) + 15, 10, SCREEN_WIDTH - 60, SCREEN_HEIGHT * 0.37 - 100);
//        NSLog(@"%@", self.starHotArray[i]);

        if (array.count == i + 1) {
            self.starScrollerImageView.backgroundColor = [UIColor redColor];
        }else {
            [self.starScrollerImageView sd_setImageWithURL:[NSURL URLWithString:array[i]] placeholderImage:[UIImage imageNamed:@"banner缺省图"]];
        }
        [self.starScrollerView addSubview:self.starScrollerImageView];

    }
    [self.contentView addSubview:self.starScrollerView];
}

- (void) setStarIdArray:(NSArray *)starIdArray {
    _starIdArray = starIdArray;
}

@end
