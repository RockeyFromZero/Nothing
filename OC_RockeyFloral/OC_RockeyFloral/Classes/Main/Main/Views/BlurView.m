//
//  BlurView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/28.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "BlurView.h"
#import "Category.h"
#import "MallsCategoryHeader.h"
#import "MallsCategory.h"

static NSString *BlurViewReuserCellId = @"BlurViewReuserCellId";
@interface BlurView ()<UITableViewDelegate,UITableViewDataSource,MallsCategoryHeaderDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIImageView *underLine;
@property (nonatomic, weak) UIImageView *bottomView;

@property (nonatomic, copy) void (^selectCategoryBlock)(RCategory *);

/** headers  */
@property (nonatomic, strong) NSMutableArray *headers;

/** selected section */
@property (nonatomic, assign) NSInteger selectedSection;

@end

@implementation BlurView
- (instancetype)initWithSelectCategory:(void (^)(RCategory *))selectCategoryBlock {
    if (self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]]) {
        _headers = [NSMutableArray array];
        
        [self setupUI];
        [self bindModel];
        _selectCategoryBlock = selectCategoryBlock;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.underLine.mas_top);
    }];
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-10);
    }];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(27);
    }];
}

- (void)bindModel {
    [[RACObserve(self, categories) ignore:nil] subscribeNext:^(NSArray *categories) {
        if (BlurViewType_home == self.type) return ;
        self.headers = [[[[categories rac_sequence] map:^id(MallsCategory *mallsCategory) {
            MallsCategoryHeaderModel *headerModel = [MallsCategoryHeaderModel new];
            headerModel.title = mallsCategory.fnName;
            headerModel.isShowChild = NO;
            return headerModel;
        }] array] mutableCopy];
    }];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 60;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BlurViewReuserCellId];
        [tableView registerClass:[MallsCategoryHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([MallsCategoryHeader class])];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (UIImageView *)underLine {
    if (!_underLine) {
        UIImageView *underLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self addSubview:underLine];
        _underLine = underLine;
    }
    return _underLine;
}
- (UIImageView *)bottomView {
    if (!_bottomView) {
        UIImageView *bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"l_regist"]];
        [self addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (BlurViewType_home == self.type) {
        return 1;
    } else {
        return self.headers.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == BlurViewType_home) {
        return self.categories.count;
    } else {

        MallsCategoryHeaderModel *model = self.headers[section];
        if (NO == model.isShowChild) {
            return 0;
        } else {
            MallsCategory *category = (MallsCategory *)self.categories[section];
            return category.childrenList.count;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BlurViewReuserCellId];
    if (self.type == BlurViewType_home) {
        RCategory *category = self.categories[indexPath.row];
        cell.textLabel.text = category.name;
    } else {
        MallsCategory *categorySection = (MallsCategory *)self.categories[indexPath.section];
        NSArray *rows = categorySection.childrenList;
        MallsCategory *categoryRow = (MallsCategory *)rows[indexPath.row];
        cell.textLabel.text = categoryRow.fnName;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.type == BlurViewType_home) return nil;
    
    MallsCategoryHeader *header = (MallsCategoryHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([MallsCategoryHeader class])];
    header.tag = section;
    header.delegate = self;
    header.model = (MallsCategoryHeaderModel *)self.headers[section];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.type == BlurViewType_home) {
        return 0;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (BlurViewType_home == self.type) {
         _selectCategoryBlock((RCategory *)self.categories[indexPath.row]); 
    } else {
    
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}
#pragma mark - MallsCategoryHeaderDelegate
- (void)mallsCategoryHeader:(MallsCategoryHeader *)header didSelectAtSection:(NSInteger)section {
    if (BlurViewType_malls == self.type) {
// TODO: 这里的 调整 做的 很不漂亮，但是 现在 时间不多了，暂时 不作调整
        MallsCategoryHeaderModel *model = header.model;
        
        if (!model.isShowChild) {
            MallsCategoryHeaderModel *selectModel = (MallsCategoryHeaderModel *)self.headers[_selectedSection];
            if (selectModel.isShowChild) {
                selectModel.isShowChild = !selectModel.isShowChild;
                [self.headers replaceObjectAtIndex:_selectedSection withObject:selectModel];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:_selectedSection] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
        
        model.isShowChild = !model.isShowChild;
        [self.headers replaceObjectAtIndex:header.tag withObject:model];
        _selectedSection = header.tag;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:header.tag] withRowAnimation:UITableViewRowAnimationFade];

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _selectCategoryBlock(nil);
}

@end
