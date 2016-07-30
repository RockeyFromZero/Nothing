//
//  TopViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopViewController.h"

#import "TopMenuView.h"
#import "TopArticalCell.h"
#import "TopArticalCell+Other.h"
#import "TopArticalCell+Normal.h"

#import "TopAuthorCell.h"

#import "TopViewModel.h"
#import "TopSearchBarView.h"

@interface TopViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 搜索框 */
@property (nonatomic, weak) TopSearchBarView *topSearchBar;

/** 菜单 */
@property (nonatomic, weak) TopMenuView *topMenu;
@property (nonatomic, weak) UITableView *tableView;

/** TopViewModel */
@property (nonatomic, strong) TopViewModel *topViewModel;
/** refresh tag 不是每次点击就会刷新，默认一个小时 */
@property (nonatomic, assign) BOOL refresh;

/** action type */
@property (nonatomic, assign) TopType actionType;


@end

@implementation TopViewController
CGFloat kTopMenuHeight = 45;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigation];
    [self setupUI];
    
    [self topViewModel];
}
- (void)setupNavigation {
    self.navigationItem.title = @"本周排行TOP10";
    
    UIButton *rightBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    [rightBar setImage:[UIImage imageNamed:@"f_search"] forState:UIControlStateNormal];
    [[rightBar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DEBUG_Log(@" top 10 right clicked ");
        [self.topSearchBar startAnimation];
    }];
}
- (void)setupUI {
    
    [self.topMenu makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kNavigationBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(kTopMenuHeight);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topMenu.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.topSearchBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(kWindow);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TopType_artical == self.topViewModel.actionType ? self.topViewModel.topAritcals.count : self.topViewModel.topAuthors.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (TopType_author == self.topViewModel.actionType) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        TopAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TopAuthorCell class])];
        cell.sort = indexPath.row;
        cell.author = (Author *)self.topViewModel.topAuthors[indexPath.row];
        return cell;
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.row < 4) {
        TopArticalNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TopArticalNormalCell class])];
        cell.sort = indexPath.row;
        cell.artical = (Artical *)self.topViewModel.topAritcals[indexPath.row];
        return cell;
    }
    
    TopArticalOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TopArticalOtherCell class])];
    cell.sort = indexPath.row;
    cell.artical = (Artical *)self.topViewModel.topAritcals[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TopType_author == self.topViewModel.actionType) {
        return 60;
    }
    
    return indexPath.row < 3 ? kTopArticalNormalCellHeight : kTopArticalOtherCellHeight;
}

#pragma mark - lazy load
- (TopMenuView *)topMenu {
    if (!_topMenu) {
        TopMenuView *view = [TopMenuView topMenu:^(TopType type) {
            if (self.topViewModel.actionType != type) {
                self.topViewModel.actionType = type;
            } 
        }];
        [self.view addSubview:view];
        _topMenu = view;
    }
    return _topMenu;
}
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[TopArticalNormalCell class] forCellReuseIdentifier:NSStringFromClass([TopArticalNormalCell class])];
        [tableView registerClass:[TopArticalOtherCell class] forCellReuseIdentifier:NSStringFromClass([TopArticalOtherCell class])];
        [tableView registerClass:[TopAuthorCell class] forCellReuseIdentifier:NSStringFromClass([TopAuthorCell class])];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (TopViewModel *)topViewModel {
    if (!_topViewModel) {
        _topViewModel = [TopViewModel viewModelSuccess:^(ErrorCode ErrorCode, NSString *error) {
            [self.tableView reloadData];
        } failure:^{
            
        }];
    }
    return _topViewModel;
}

- (TopSearchBarView *)topSearchBar {
    if (!_topSearchBar) {
        TopSearchBarView *searchBar = [[TopSearchBarView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        searchBar.hidden = YES;
        [kWindow addSubview:searchBar];
        _topSearchBar = searchBar;  
    }
    return _topSearchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
