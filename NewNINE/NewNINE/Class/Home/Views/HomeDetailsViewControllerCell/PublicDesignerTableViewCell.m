//
//  PublicDesignerTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/1.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情公共设计师控制器cell

#import "PublicDesignerTableViewCell.h"

// ---------------------- view       ----------------------
#import "PublicDesignerCollectionViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

static NSString *cellID = @"PublicDesignerCollectionViewCell";

@interface PublicDesignerTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, PublicDesignerCollectionViewCellDelegate>
/** 推荐设计师文字图片 */
@property (nonatomic, strong) UIImageView *imageViewHead;
/** 查看更多文字图片 */
@property (nonatomic, strong) UIImageView *imageViewFooter;
/** 公共设计师展示列表*/
@property (nonatomic, strong) UICollectionView *collectionViewPD;

/** 推荐设计师\nSTYLIST  线*/
@property (nonatomic, strong) UILabel *xxLable;
/** 推荐设计师\nSTYLIST  文字*/
@property (nonatomic, strong) UILabel *nameLable;


/** 查看更多\nVIEW MORE  线*/
@property (nonatomic, strong) UILabel  *xxxLable;
/** 查看更多\nVIEW MORE  文字*/
@property (nonatomic, strong) UILabel  *xxxnameLable;
/** 查看更多\nVIEW MORE  按钮*/
@property (nonatomic, strong) UIButton *xxxButton;


@end

@implementation PublicDesignerTableViewCell

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
 *  @return PublicDesignerTableViewCell
 */
+ (instancetype) publicDesignerpCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    PublicDesignerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    cell.backgroundColor    = SWPColor(248, 248, 248, 1);
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return PublicDesignerTableViewCell
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
    [self.contentView addSubview:self.imageViewHead];
    [self.contentView addSubview:self.imageViewFooter];
    [self.contentView addSubview:self.collectionViewPD];
    
    [self.imageViewHead addSubview:self.xxLable];
    [self.imageViewHead addSubview:self.nameLable];
    
    [self.imageViewFooter addSubview:self.xxxLable];
    [self.imageViewFooter addSubview:self.xxxnameLable];
    [self.imageViewFooter addSubview:self.xxxButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.imageViewHead autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.imageViewHead autoSetDimension:ALDimensionHeight toSize:35];
    
    [self.imageViewFooter autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 20, 0) excludingEdge:ALEdgeTop];
    [self.imageViewFooter autoSetDimension:ALDimensionHeight toSize:35];
    
    [self.xxLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(14, 15, 0, 15) excludingEdge:ALEdgeBottom];
    [self.xxLable autoSetDimension:ALDimensionHeight toSize:1];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 2 - 80, 0, SCREEN_WIDTH / 2 - 80)];
    
    [self.xxxLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(14, 45, 0, 45) excludingEdge:ALEdgeBottom];
    [self.xxxLable autoSetDimension:ALDimensionHeight toSize:1];
    
    [self.xxxnameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 2 - 80, 0, SCREEN_WIDTH / 2 - 80)];
    
    [self.xxxButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 2 - 50, 0, SCREEN_WIDTH / 2 - 50)];
}

#pragma mark - UICollectionView Delegate
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arratData.count;
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PublicDesignerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.dictData  = self.arratData[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate  = self;
    cell.layer.borderColor = SWPUIColorFromRGB(0xdcdcdc).CGColor;
    return cell;

}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
 
}

#pragma mark - PublicDesignerCollectionViewCell 代理  点击公共发型预约触发事件
- (void) publicDesignerCollectionViewCell:(PublicDesignerCollectionViewCell *)publicDesignerCollectionViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(publicDesignerTableViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate publicDesignerTableViewCell:self didSelectItemAtIndexPath:indexPath];
    }
}

- (UIImageView *) imageViewHead {
    if (!_imageViewHead) {
        _imageViewHead = [[UIImageView alloc] initForAutoLayout];
    }
    return _imageViewHead;
}

- (UIImageView *) imageViewFooter {
    if (!_imageViewFooter) {
        _imageViewFooter = [[UIImageView alloc] initForAutoLayout];
    }
    return _imageViewFooter;
}

- (UILabel *) xxLable {
    if (!_xxLable) {
        _xxLable = [[UILabel alloc] initForAutoLayout];
        _xxLable.backgroundColor = Color(154, 154, 154, 1);
    }
    return _xxLable;
}

- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.numberOfLines   = 0;
        _nameLable.font            = SWP_SYSTEM_FONT_SIZE(13);
        _nameLable.textAlignment   = NSTextAlignmentCenter;
        _nameLable.text            = @"推荐设计师\nSTYLIST";
        _nameLable.backgroundColor = Color(248, 248, 248, 1);
        _nameLable.textColor       = Color(154, 154, 154, 1);
    }
    return _nameLable;
}

- (UILabel *) xxxLable {
    if (!_xxxLable) {
        _xxxLable = [[UILabel alloc] initForAutoLayout];
        _xxxLable.backgroundColor = Color(154, 154, 154, 1);
    }
    return _xxxLable;
}

- (UILabel *) xxxnameLable {
    if (!_xxxnameLable) {
        _xxxnameLable = [[UILabel alloc] initForAutoLayout];
        _xxxnameLable.numberOfLines     = 0;
        _xxxnameLable.font              = SWP_SYSTEM_FONT_SIZE(12);
        _xxxnameLable.textAlignment     = NSTextAlignmentCenter;
        _xxxnameLable.text              = @"查看更多\nVIEW MORE";
        _xxxnameLable.backgroundColor   = Color(248, 248, 248, 1);
        _xxxnameLable.textColor         = Color(154, 154, 154, 1);
    }
    return _xxxnameLable;
}

- (UIButton *) xxxButton {
    if (!_xxxButton) {
        _xxxButton = [[UIButton alloc] initForAutoLayout];
        _xxxButton.layer.borderWidth = 0.5;
        _xxxButton.layer.borderColor = Color(154, 154, 154, 1).CGColor;
        [_xxxButton.layer setCornerRadius:18.0];//button圆角
    }
    return _xxxButton;
}

- (UICollectionView *) collectionViewPD {
    if (!_collectionViewPD) {
        
        UICollectionViewFlowLayout *flowLayout      = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing               = 0;
        flowLayout.minimumInteritemSpacing          = 0;
        flowLayout.itemSize                         = CGSizeMake( (SCREEN_WIDTH - 40) / 2, (SCREEN_WIDTH - 40) / 2 + 46);
        flowLayout.minimumLineSpacing               = 15.0;
        flowLayout.minimumInteritemSpacing          = 5;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionViewPD = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 45,  SCREEN_WIDTH - 30, height) collectionViewLayout:flowLayout];
        _collectionViewPD.backgroundColor                = Color(248, 248, 248, 1);
        _collectionViewPD.delegate                       = self;
        _collectionViewPD.dataSource                     = self;
        _collectionViewPD.pagingEnabled                  = NO;
        _collectionViewPD.showsHorizontalScrollIndicator = NO;
        _collectionViewPD.showsVerticalScrollIndicator   = NO;
        [_collectionViewPD setScrollEnabled:NO];
        [_collectionViewPD registerClass:[PublicDesignerCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionViewPD;
}

- (void) setArratData:(NSArray *)arratData {
    _arratData = arratData;
    
    long a = _arratData.count;
    NSLog(@"%lu", a);
    
    if (a%2 == 0) {
        height = a / 2 * ((SCREEN_WIDTH - 40) / 2 + 35) + (a * 15) ;
        self.collectionViewPD.frame = CGRectMake(15, 45,  SCREEN_WIDTH - 30, height);
    }else {
        height = a / 2 * ((SCREEN_WIDTH - 40) / 2 + 46) + ((SCREEN_WIDTH - 40) / 2 + 31) + (a * 15);
        self.collectionViewPD.frame = CGRectMake(15, 45,  SCREEN_WIDTH - 30, height);
    }
    
}

@end
