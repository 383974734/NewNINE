//
//  MyEvaluationTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/17.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MyEvaluationTableViewCell.h"

#import "MyEvaluationModel.h"

@interface MyEvaluationTableViewCell ()

/** 介绍信息父视图*/
@property (nonatomic, strong) UIView        *introduceView;
/** 发型详情对应头像图片*/
@property (nonatomic, strong) UIImageView   *headImageVIew;
/** 设计师名字*/
@property (nonatomic, strong) UILabel       *nameLable;
/** 级别*/
@property (nonatomic, strong) UILabel       *levelLable;
/** 设计师签名*/
@property (nonatomic, strong) UILabel       *autographLable;

/** 我的评价文字*/
@property (nonatomic, strong) UILabel       *evaluationName;
/** 我的评价内容*/
@property (nonatomic, strong) UILabel       *evaluationTitle;


/** 评价图片1*/
@property (nonatomic, strong) UIImageView   *oneImageVIew;
/** 评价图片2*/
@property (nonatomic, strong) UIImageView   *twoImageVIew;
/** 评价图片3*/
@property (nonatomic, strong) UIImageView   *threeImageVIew;

@property (nonatomic, strong) UILabel *xxLable;

@end



@implementation MyEvaluationTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MyEvaluationTableViewCell
 */
+ (instancetype) myEvaluationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    MyEvaluationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    //    cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;//箭头
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return MyEvaluationTableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self layoutSubviews22];
    }
    return self;
}


/**
 *  添加cell上的控件
 */
- (void) addUI {
    
    [self.contentView addSubview:self.introduceView];
    [self.introduceView addSubview:self.headImageVIew];
    [self.introduceView addSubview:self.nameLable];
    [self.introduceView addSubview:self.levelLable];
    [self.introduceView addSubview:self.autographLable];
    [self.introduceView addSubview:self.evaluationName];
    [self.introduceView addSubview:self.evaluationTitle];
    [self.introduceView addSubview:self.oneImageVIew];
    [self.introduceView addSubview:self.twoImageVIew];
    [self.introduceView addSubview:self.threeImageVIew];
    [self.introduceView addSubview:self.xxLable];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews22 {
//    [super layoutSubviews];
    [self.introduceView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [self.headImageVIew autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.headImageVIew autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.headImageVIew autoSetDimension:ALDimensionWidth toSize:55];
    [self.headImageVIew autoSetDimension:ALDimensionHeight toSize:55];
    
    [self.evaluationName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageVIew withOffset:10];
    [self.evaluationName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.evaluationName autoSetDimension:ALDimensionWidth toSize:120];
    [self.evaluationName autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.xxLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.xxLable autoSetDimension:ALDimensionHeight toSize:10];

}


#pragma mark   -  所有控件懒加载
- (UIView *) introduceView {
    if (!_introduceView) {
        _introduceView = [[UIView alloc] initForAutoLayout];
        _introduceView.backgroundColor = [UIColor whiteColor];
    }
    return _introduceView;
}

- (UIImageView *) headImageVIew {
    //http://blog.csdn.net/wuzehai02/article/details/8546288
    if (!_headImageVIew) {
        _headImageVIew = [[UIImageView alloc] initForAutoLayout];
        //        _headImageVIew.contentMode          = UIViewContentModeScaleAspectFit;
        _headImageVIew.layer.cornerRadius   = 27;
        _headImageVIew.layer.masksToBounds  = YES;
        _headImageVIew.image                = [UIImage imageNamed:@"发型缺省图"];
    }
    return _headImageVIew;
}

- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textColor = Color(64, 64, 64, 1);
        _nameLable.font      = SWP_SYSTEM_FONT_SIZE(15);
//        _nameLable.lineBreakMode = UILineBreakModeWordWrap;
    }
    return _nameLable;
}

- (UILabel *) levelLable {
    if (!_levelLable) {
        _levelLable = [[UILabel alloc] init];
        _levelLable.layer.borderWidth   = 1;
        _levelLable.layer.cornerRadius  = 2;
        _levelLable.font                = SWP_SYSTEM_FONT_SIZE(10);
        _levelLable.layer.borderColor   = Color(234, 41, 41, 1).CGColor;
        _levelLable.textColor           = Color(234, 41, 41, 1);
        _levelLable.textAlignment       = NSTextAlignmentCenter;
    }
    return _levelLable;
}

- (UILabel *) autographLable {
    if (!_autographLable) {
        _autographLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 34, SCREEN_WIDTH - 180, 18)];
        _autographLable.textColor   = Color(154, 154, 154, 1);
        _autographLable.font        = SWP_SYSTEM_FONT_SIZE(14);
    }
    return _autographLable;
}

- (UILabel *) evaluationName {
    if (!_evaluationName) {
        _evaluationName = [[UILabel alloc] initForAutoLayout];
        _evaluationName.textColor   = Color(64, 64, 64, 1);
        _evaluationName.font        = SWP_SYSTEM_FONT_SIZE(15);
        _evaluationName.text        = @"我的评价";
    }
    return _evaluationName;
}

- (UILabel *) evaluationTitle {
    if (!_evaluationTitle) {
        _evaluationTitle               = [[UILabel alloc] init];
        _evaluationTitle.textColor     = Color(154, 154, 154, 1);
        _evaluationTitle.font          = SWP_SYSTEM_FONT_SIZE(15);
        _evaluationTitle.numberOfLines = 0;
        _evaluationTitle.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _evaluationTitle;
}

- (UIImageView *) oneImageVIew {
    if (!_oneImageVIew) {
        _oneImageVIew = [[UIImageView alloc] init];
    }
    return _oneImageVIew;
}

- (UIImageView *) twoImageVIew {
    if (!_twoImageVIew) {
        _twoImageVIew = [[UIImageView alloc] init];
    }
    return _twoImageVIew;
}

- (UIImageView *) threeImageVIew {
    if (!_threeImageVIew) {
        _threeImageVIew = [[UIImageView alloc] init];
    }
    return _threeImageVIew;
}


- (UILabel *) xxLable {
    if (!_xxLable) {
        _xxLable = [[UILabel alloc] initForAutoLayout];
    }
    return _xxLable;
}

- (void) setDataModel:(MyEvaluationModel *)dataModel {
    _dataModel = dataModel;
    NSDictionary *userCommentDict = _dataModel.myUserComment;
    NSDictionary *stylistInfoDict = _dataModel.myStylistInfo;
    
    self.nameLable.text = [stylistInfoDict objectForKey:@"name"];
    CGSize nameSize = [self uiWithConstrained:self.nameLable.text];
    self.nameLable.frame = CGRectMake(80, 12, nameSize.width + 10, 20);
    
    self.levelLable.text = [stylistInfoDict objectForKey:@"leveName"];
    UIFont *levelFnt = [UIFont fontWithName:self.levelLable.text size:10];
    CGSize levelSize = [self.levelLable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:levelFnt, NSFontAttributeName, nil]];
    self.levelLable.frame = CGRectMake(90 + nameSize.width, 14, levelSize.width, 16);
    
    self.autographLable.text = [stylistInfoDict objectForKey:@"introduce"];
    
//    [self.headImageVIew sd_setImageWithURL:[NSURL URLWithString:[stylistInfoDict objectForKey:@"iconPhotoUrl"]] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
    
    [self.headImageVIew  sd_setImageWithURL:[NSURL URLWithString:[stylistInfoDict objectForKey:@"iconPhotoUrl"]]
                           placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  }];
    
    [self frameWithUI:userCommentDict stylistInfoDict:stylistInfoDict];
}


- (void) frameWithUI:(NSDictionary *)userCommentDict stylistInfoDict:(NSDictionary *)stylistInfoDict{
    
    self.evaluationTitle.text = [NSString stringWithFormat:@"%@", [userCommentDict objectForKey:@"content"] ];
    CGSize size = [self.evaluationTitle sizeThatFits:CGSizeMake(SCREEN_WIDTH - 30, MAXFLOAT)];
    self.evaluationTitle.lineBreakMode = NSLineBreakByWordWrapping;
    if (size.height > 80) {
        self.evaluationTitle.frame = CGRectMake(15, 105, SCREEN_WIDTH - 30, 80);
        self.oneImageVIew.frame = CGRectMake(15, 115 + 80, 70, 70);
        self.twoImageVIew.frame = CGRectMake(95, 115 + 80, 70, 70);
        self.threeImageVIew.frame = CGRectMake(175, 115 + 80, 70, 70);

    }else {
        
        self.evaluationTitle.frame = CGRectMake(15, 105, SCREEN_WIDTH - 30, size.height);
        self.oneImageVIew.frame = CGRectMake(15, 115 + size.height, 70, 70);
        self.twoImageVIew.frame = CGRectMake(95, 115 + size.height, 70, 70);
        self.threeImageVIew.frame = CGRectMake(175, 115 + size.height, 70, 70);
    }
    if ([[userCommentDict objectForKey:@"photos"] count] > 0) {
        NSArray *array = [userCommentDict objectForKey:@"photos"];
        for (int i = 0; array.count > i; i++) {
            if (i == 0) {
//                [self.oneImageVIew sd_setImageWithURL:[NSURL URLWithString:[array[0] objectForKey:@"photoUrl"]]];
                [self.oneImageVIew  sd_setImageWithURL:[NSURL URLWithString:[array[0] objectForKey:@"photoUrl"]]
                                       placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                              }];
            }
            if (i == 1) {
//                [self.twoImageVIew sd_setImageWithURL:[NSURL URLWithString:[array[1] objectForKey:@"photoUrl"]]];
                [self.twoImageVIew  sd_setImageWithURL:[NSURL URLWithString:[array[1] objectForKey:@"photoUrl"]]
                                      placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                             }];
            }
            if (i == 2) {
//                [self.threeImageVIew sd_setImageWithURL:[NSURL URLWithString:[array[2] objectForKey:@"photoUrl"]]];
                [self.threeImageVIew  sd_setImageWithURL:[NSURL URLWithString:[array[2] objectForKey:@"photoUrl"]]
                                      placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                             }];
            }
        }
        self.oneImageVIew.hidden = NO;
        self.twoImageVIew.hidden = NO;
        self.threeImageVIew.hidden = NO;
    }else {
        self.oneImageVIew.hidden = YES;
        self.twoImageVIew.hidden = YES;
        self.threeImageVIew.hidden = YES;
    }

}

- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,20);
//    CGSize nameSize = [title sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    NSDictionary *dict = @{NSFontAttributeName : nameFnt};
    
    CGSize nameSize = [title boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    return nameSize;
}

@end
