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
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.imageViewHead autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.imageViewHead autoSetDimension:ALDimensionHeight toSize:35];
    
    [self.imageViewFooter autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 35, 0) excludingEdge:ALEdgeTop];
    [self.imageViewFooter autoSetDimension:ALDimensionHeight toSize:28];
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
        _imageViewHead.backgroundColor = [UIColor redColor];
    }
    return _imageViewHead;
}

- (UIImageView *) imageViewFooter {
    if (!_imageViewFooter) {
        _imageViewFooter = [[UIImageView alloc] initForAutoLayout];
        _imageViewFooter.backgroundColor = [UIColor orangeColor];
    }
    return _imageViewFooter;
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
