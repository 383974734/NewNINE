//
//  ClassificationView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//发型-----------> 发型控分类view

#import "ClassificationView.h"

#import "HairstyleViewControllerModel.h"

@interface ClassificationView ()<UITableViewDelegate, UITableViewDataSource>

/** 发型控分类view*/
@property (nonatomic, strong) UITableView *classificationTableView;
/** 发型控分类imageView*/
@property (nonatomic, strong) UIImageView *classificationImageView;

@property (nonatomic, strong) UIView *baView;

@property (nonatomic, strong) NSArray *classificationArray;

@end

@implementation ClassificationView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.baView];
    [self addSubview:self.classificationTableView];
    [self addSubview:self.classificationImageView];
}

- (void)settingAutoLayout {
//    [self.classificationTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)settingData {
    
}

#pragma mark UITableView DataSource
/**
 *  tableView 数据源方法 返回tabvelView 分组个数
 *
 *  @param tableView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 *  tableView 数据源方法  返回tableView 每个分组中cell的个数
 *
 *  @param tableView
 *  @param section
 *
 *  @return NSInteger
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%@",self.classificationArray);
    if ([self.designerStr isEqualToString:@"设计师"]) {
        return self.designerArray.count;
    }else {
        return self.classificationArray.count;
    }
    
}

/**
 *  tableView 数据源方法 返回每个cell显示的样式和数据
 *
 *  @param  tableView
 *  @param  indexPath
 *
 *  @return OrderTableViewCell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier =[NSString stringWithFormat:@"Cell%ld#%ld", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ClassificationViewCellID"];
    }
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 34)];
    lable.textColor = Color(154, 154, 154, 1);
    lable.font = SWP_SYSTEM_FONT_SIZE(15);
    lable.textAlignment = NSTextAlignmentCenter;
    if ([self.designerStr isEqualToString:@"设计师"]) {
        lable.text = self.designerArray[indexPath.row];
    }else {
        HairstyleViewControllerModel *model = self.classificationArray[indexPath.row];
       lable.text = model.hairstyleClasName;
    }
    
    [cell addSubview:lable];
    return cell;
}

/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.designerStr isEqualToString:@"设计师"]) {
        if ([self.delegate respondsToSelector:@selector(classificationView:didSelectRowWithClassification:classificationID:)]) {
            [self.delegate classificationView:self didSelectRowWithClassification:self.designerArray[indexPath.row] classificationID:nil];
        }
    }else {
        HairstyleViewControllerModel *model = self.classificationArray[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(classificationView:didSelectRowWithClassification:classificationID:)]) {
            [self.delegate classificationView:self didSelectRowWithClassification:model.hairstyleClasName classificationID:model.hairstyleClasID];
        }
    }
    
}

/**
 *  tableView 代理方法 返回对应索引返回的row的高度
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return CGFloat
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 34;
}


- (UITableView *) classificationTableView {
    if (!_classificationTableView) {
        _classificationTableView = [[UITableView alloc] init];
        _classificationTableView.delegate = self;
        _classificationTableView.dataSource = self;
        _classificationTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _classificationTableView;
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  - (UIView *) baView {
    if (!_baView) {
        _baView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _baView.backgroundColor = [UIColor blackColor];
        _baView.alpha = 0.5;
    }
    return _baView;
}

- (UIImageView *) classificationImageView {
    if (!_classificationImageView) {
        _classificationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 26 - 51, 0, 12, 10)];
        _classificationImageView.image = [UIImage imageNamed:@"设计师筛选下啦框三角"];
    }
    return _classificationImageView;
}

- (void) setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    self.classificationArray = [self hairstyleOpusClassDispose:_dataArray];
    if (self.classificationArray.count > 5) {
        self.classificationTableView.frame = CGRectMake(SCREEN_WIDTH - 26 - 90, 10, 90, 34 * 5);
    }else {
        self.classificationTableView.frame = CGRectMake(SCREEN_WIDTH - 26 - 90, 10, 90, 34 * self.classificationArray.count);
    }
    [self.classificationTableView reloadData];
}

- (NSMutableArray *) hairstyleOpusClassDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        HairstyleViewControllerModel *model = [HairstyleViewControllerModel hairstyleClasWithDict:dict];
        [array addObject:model];
    }
    return array;
}

- (void)setDesignerArray:(NSArray *)designerArray {
    _designerArray = designerArray;
    _classificationImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - 5, 0, 12, 10);
    _classificationTableView.frame = CGRectMake(SCREEN_WIDTH / 2 - 45, 10, 90, 34 * 4);
    [self.classificationTableView reloadData];
}
@end
