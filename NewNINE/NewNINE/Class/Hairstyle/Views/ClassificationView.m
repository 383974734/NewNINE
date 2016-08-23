//
//  ClassificationView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//发型-----------> 发型控分类view

#import "ClassificationView.h"

#import "DesignerWholeRegionTwoUIView.h"

#import "HairstyleViewControllerModel.h"


@interface ClassificationView ()<UITableViewDelegate, UITableViewDataSource>

/** 发型控分类view*/
@property (nonatomic, strong) UITableView *classificationTableView;
/** 发型控分类imageView*/
@property (nonatomic, strong) UIImageView *classificationImageView;
/** 显示区域二级视图*/
@property (nonatomic, strong) DesignerWholeRegionTwoUIView *twoTableview;

@property (nonatomic, strong) UIButton *baView;

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
    [self addSubview:self.twoTableview];
    [self addSubview:self.classificationImageView];
}

- (void)settingAutoLayout {
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
    if (self.designerStr.length > 4) {
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
    if (self.designerStr.length > 4) {
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
    if ([self.designerStr isEqualToString:@"设计师排序"]) {
        if ([self.delegate respondsToSelector:@selector(classificationView:didSelectRowWithClassification:classificationID:)]) {
            [self.delegate classificationView:self didSelectRowWithClassification:self.designerArray[indexPath.row] classificationID:nil];
        }
        return;
    }
    if ([self.designerStr isEqualToString:@"设计师区域"]) {
        [self setDesignerNameWithDesignerID:indexPath];
        return;
    }
    HairstyleViewControllerModel *model = self.classificationArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(classificationView:didSelectRowWithClassification:classificationID:)]) {
        [self.delegate classificationView:self didSelectRowWithClassification:model.hairstyleClasName classificationID:model.hairstyleClasID];
    }
    
}

/**
 *  设计师门店名字和id
 */
- (void) setDesignerNameWithDesignerID:(NSIndexPath *)indexPath{
    NSMutableArray *arrayNmame = [NSMutableArray array];//门店名字
    NSMutableArray *arrayID    = [NSMutableArray array];//门店ID
    if (indexPath.row == 0) {
        NSMutableArray *arrayname = [NSMutableArray arrayWithObjects:@"全部区域", nil];
        NSMutableArray *arrayid   = [NSMutableArray arrayWithObjects:@"", nil];
        for (int i = 0; i < _wholeRegionAray.count; i ++) {
            for (int a = 0; a < [[_wholeRegionAray[i] objectForKey:@"studioLst"] count]; a ++) {
                [arrayname addObject:[[_wholeRegionAray[i] objectForKey:@"studioLst"][a] objectForKey:@"names"]];
                [arrayid   addObject:[[_wholeRegionAray[i] objectForKey:@"studioLst"][a] objectForKey:@"id"]];
            }
        }
        arrayNmame = arrayname;
        arrayID = arrayid;
    }else {
        for (int i = 0; i < [[self.wholeRegionAray[indexPath.row - 1] objectForKey:@"studioLst"] count]; i ++) {
            [arrayNmame addObject:[[self.wholeRegionAray[indexPath.row - 1] objectForKey:@"studioLst"][i] objectForKey:@"names"]];
            [arrayID    addObject:[[self.wholeRegionAray[indexPath.row - 1] objectForKey:@"studioLst"][i] objectForKey:@"id"]];
        }
    }
    self.twoTableview.wholeRegionAray   = arrayNmame;//门店名字
    self.twoTableview.wholeRegionIDAray = arrayID;
    
    
    __weak typeof (self) selfView = self;
    self.twoTableview.designerIdBlock = ^(NSString *strID, NSString *strName){
        NSLog(@"这里面会输出什么呢？？********————————————%@********————————————%@", strID, strName);
        if (selfView.classificationID) {
            selfView.classificationID(strID, strName);
        }
    };
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
    return 40;
}

#pragma mark - 控件点击事件
- (void)didButton:(UIButton *)btn {
    if (self.buttonTouchUpInside) {
        self.buttonTouchUpInside();
    }
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

- (UIButton *) baView {
    if (!_baView) {
        _baView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _baView.backgroundColor = [UIColor blackColor];
        _baView.alpha = 0.5;
        [_baView addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _baView;
}

- (UIImageView *) classificationImageView {
    if (!_classificationImageView) {
        _classificationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 26 - 51, 2, 14, 10)];
        _classificationImageView.image = [UIImage imageNamed:@"设计师筛选下啦框三角"];
    }
    return _classificationImageView;
}


- (DesignerWholeRegionTwoUIView *)twoTableview {
    if (!_twoTableview) {
        _twoTableview = [[DesignerWholeRegionTwoUIView alloc] init];
        _twoTableview.backgroundColor = [UIColor redColor];
    }
    return _twoTableview;
}

- (void) setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    self.twoTableview.hidden = YES;
    self.classificationArray = [self hairstyleOpusClassDispose:_dataArray];
    if (self.classificationArray.count > 5) {
        self.classificationTableView.frame = CGRectMake(SCREEN_WIDTH - 26 - 90, 10, 90, 34 * 5);
    }else {
        self.classificationTableView.frame = CGRectMake(SCREEN_WIDTH - 26 - 90, 10, 90, 34 * self.classificationArray.count);
    }
    [self.classificationTableView reloadData];
}

- (NSMutableArray *) hairstyleOpusClassDispose:(NSArray *)param {
    
    self.twoTableview.hidden = YES;
    NSMutableArray *array    = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        HairstyleViewControllerModel *model = [HairstyleViewControllerModel hairstyleClasWithDict:dict];
        [array addObject:model];
    }
   
    return array;
}

- (void)setDesignerArray:(NSArray *)designerArray {
    
    _designerArray = designerArray;
    self.twoTableview.hidden       = YES;
    _classificationImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - 7, 2, 14, 10);
    _classificationTableView.frame = CGRectMake(SCREEN_WIDTH / 2 - 45, 10, 90, 40 * _designerArray.count);
    [self.classificationTableView reloadData];
}

- (void)setWholeRegionAray:(NSArray *)wholeRegionAray {
    _wholeRegionAray = wholeRegionAray;
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"全部区域", nil];
    for (int i = 0; i < _wholeRegionAray.count; i ++) {
        [array1   addObject:[_wholeRegionAray[i] objectForKey:@"area"]];

    }
    
    NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"全部区域", nil];
    NSMutableArray *arrayid   = [NSMutableArray arrayWithObjects:@"", nil];
    for (int i = 0; i < _wholeRegionAray.count; i ++) {
        for (int a = 0; a < [[_wholeRegionAray[i] objectForKey:@"studioLst"] count]; a ++) {
            [array2   addObject:[[_wholeRegionAray[i] objectForKey:@"studioLst"][a] objectForKey:@"names"]];
            [arrayid  addObject:[[_wholeRegionAray[i] objectForKey:@"studioLst"][a] objectForKey:@"id"]];
        }
    }
    
    self.designerArray = array1;
    self.classificationImageView.frame      = CGRectMake(SCREEN_WIDTH / 6 - 7, 2, 14, 10);
    self.classificationTableView.frame      = CGRectMake(20, 12, 90, array1.count * 34);
    
    
    self.twoTableview.frame             = CGRectMake(110, 12, SCREEN_WIDTH - 130, array1.count * 34);
    self.twoTableview.wholeRegionAray   = array2;
    self.twoTableview.wholeRegionIDAray = arrayid;
    self.twoTableview.hidden            = NO;
    [self.classificationTableView reloadData];
    
    __weak typeof (self) selfView = self;
    self.twoTableview.designerIdBlock = ^(NSString *strID, NSString *strName){
        NSLog(@"这里面会输出什么呢？？********————————————%@********————————————%@", strID, strName);
        if (selfView.classificationID) {
            selfView.classificationID(strID, strName);
        }
    };
}


@end
