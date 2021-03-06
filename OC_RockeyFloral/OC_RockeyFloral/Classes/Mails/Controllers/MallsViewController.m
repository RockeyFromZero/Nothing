//
//  MailsViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsViewController.h"

#import "TopSearchBarView.h"
#import "BlurView.h"
#import "MallsTopCell.h"
#import "MallsNormalCell.h"
#import "MallsThemeCell.h"

#import "MallsViewModel.h"
#import "MallsCategoryVM.h"
#import "ADSViewModel.h"

@interface MallsViewController () <MallsTopCellDelegate,UITableViewDataSource,UITableViewDelegate>
/**  NavigationItems 依次是：标题、右上角、左上角 */
@property (nonatomic, weak) TitleBtn *titleBtn;
@property (nonatomic, weak) TopSearchBarView *searchBar;
@property (nonatomic, strong) UIButton *menuBtn;
@property (nonatomic, weak) BlurView *blurView;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) MallsCategoryVM *categoryVM;
@property (nonatomic, strong) MallsViewModel *viewModel;
@property (nonatomic, assign) MallType mallType;

@property (nonatomic, strong) ADSViewModel *adsVM;
@property (nonatomic, strong) ADS *adsModel;

/** 精选 数据 */
@property (nonatomic, copy) NSArray *jingxuanDatas;
/** 商城 数据 */
@property (nonatomic, copy) NSArray *themeDatas;

@end

@implementation MallsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self bindModel];
}

- (void)bindModel {
    _categoryVM = [MallsCategoryVM mallsCategoryComplete:^(ErrorCode errorCode, id success) {
        self.blurView.categories = self.categoryVM.categorys;
    } failure:^(ErrorCode errorCode, id failure) { }];
    
    _adsVM = [ADSViewModel ADSViewModel:^(ErrorCode ErrorCode, id success) {
        if (ErrorCode_success == ErrorCode) {
            self.adsModel = success;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];

    [RACObserve(self, mallType) subscribeNext:^(NSNumber *x) {
        if ((MallType_jingxuan == (MallType)x.integerValue && 0 == self.jingxuanDatas.count) ||
            (MallType_theme == (MallType)x.integerValue && 0 == self.themeDatas.count)) {
            self.viewModel.mallType = (MallType)x.integerValue;
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (void)setupNavigation {
    self.navigationItem.titleView = self.titleBtn;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuBtn];
    
    UIButton *rightBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kNavImageViewWH, kNavImageViewWH)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    [rightBar setImage:[UIImage imageNamed:@"f_search"] forState:UIControlStateNormal];
    [[rightBar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.searchBar startAnimation];
    }];
}
- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavigation];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(kNavigationBarHeight, 0, 0, 0));
    }];
    
    self.hudSuperView = kWindow;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.tableView registerClass:[MallsNormalCell class] forCellReuseIdentifier:NSStringFromClass([MallsNormalCell class])];
    [self.tableView registerClass:[MallsThemeCell class] forCellReuseIdentifier:NSStringFromClass([MallsThemeCell class])];
    [self.tableView registerClass:[MallsTopCell class] forCellReuseIdentifier:NSStringFromClass([MallsTopCell class])];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self showHUD:@"get first"];
        [self.viewModel getFirst];
        [self.adsVM refresh];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        if (MallType_jingxuan == self.mallType) {
            [self showHUD:@"get next"];
            [self.viewModel getNext];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    
    [self.searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(kWindow);
    }];
}

#pragma mark - UITableViewDelegate && datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } 
    
    if (MallType_jingxuan == self.mallType) {
        return self.jingxuanDatas.count;
    } else {
        return self.themeDatas.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        MallsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MallsTopCell class])];
        cell.model = self.adsModel;
        cell.delegate = self;
        return cell;
    }
    if (MallType_jingxuan == self.mallType) {
        MallsNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MallsNormalCell class])];
        cell.model = (Goods *)self.jingxuanDatas[indexPath.row];
        return cell;
    }
    if (MallType_theme == self.mallType) {
        MallsThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MallsThemeCell class])];
        cell.model = (MallsGoods *)self.themeDatas[indexPath.row];
        return cell;
    }
    NSString *title = self.mallType == MallType_theme ? @"商城" : @"精选";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld-%@",(long)indexPath.section,(long)indexPath.row,title];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 264;
    } else if (MallType_jingxuan == self.mallType) {
        return 280;
    } else {
        MallsGoods *mall = self.themeDatas[indexPath.row];
        NSInteger count = mall.goodsList.count;
        CGFloat height = (count%2==0 ? count/2 : (count/2 + 1)) * kScreenWidth/2.0;
        return height + kMallsThemeCellHeaderHeight + 10;
    }
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [UITableView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (TitleBtn *)titleBtn {
    if (!_titleBtn) {
        TitleBtn *titleBtn = [[TitleBtn alloc] init];
        titleBtn.topTitle = NSLocalizedString(@"Malls_title", @"");
        _titleBtn = titleBtn;
    }
    return _titleBtn;
}
- (TopSearchBarView *)searchBar {
    if (!_searchBar) {
        TopSearchBarView *searchBar = [[TopSearchBarView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        searchBar.hidden = YES;
        [kWindow addSubview:searchBar];
        _searchBar = searchBar;  
    }
    return _searchBar;
}


- (UIButton *)menuBtn {
    if (!_menuBtn) {
        UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        _menuBtn = menuBtn;
        
        [[menuBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [self hideBlurView:self.menuBtn.selected];
        }];
    }
    return _menuBtn;
}

- (BlurView *)blurView {
    if (!_blurView) {
        @weakify(self);
        BlurView *item = [[BlurView alloc] initWithSelectCategory:^(RCategory *selectCategory) {
            @strongify(self);
            [self hideBlurView:true];
        }];
        item.type = BlurViewType_malls;
        item.hidden = YES;
        [self.view addSubview:item];
        _blurView = item;
    }
    return _blurView;
}

- (void)hideBlurView:(BOOL)hideBlurView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.blurView.hidden = NO;
    });
    self.menuBtn.selected = !hideBlurView;
    
    if (!hideBlurView) {
        [self.blurView updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kNavigationBarHeight);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(kScreenWidth, kScreenHeight-kNavigationBarHeight-kTabBarItemHeight));
        }];
        self.blurView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (!hideBlurView) {
            self.blurView.transform = CGAffineTransformIdentity;
            self.menuBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.tableView.scrollEnabled = false;
        } else {
            self.blurView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
            self.menuBtn.transform = CGAffineTransformIdentity;
            self.tableView.scrollEnabled = true;
        }
        
    }];
    
}

#pragma mark - lazy load
- (MallsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [MallsViewModel viewModel:^(ErrorCode ErrorCode, NSArray *array) {
            if (ErrorCode_success == ErrorCode) {
                if (MallType_jingxuan == self.mallType) {
                    self.jingxuanDatas = [array copy];
                } else {
                    self.themeDatas = [array copy];
                }
     
                [self.tableView reloadData];
                [self hideHUDAfterDelay:.8];
                if ([self.tableView.mj_footer isRefreshing]) {
                    [self.tableView.mj_footer endRefreshing];
                } else if ([self.tableView.mj_header isRefreshing]) {
                    [self.tableView.mj_header endRefreshing];
                }
            } else {
                if (ErrorCode_NoMore == ErrorCode) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self showHUD:@"网络故障，稍后请重试"];
                }
            }
            [self.hud hide:YES afterDelay:0.8];
        } failure:^{
            
            [self showHUD:@"网络故障，稍后请重试"];
            [self.hud hide:YES afterDelay:0.8];
        }];
    }
    return _viewModel;
}

#pragma mark - MallsTopCellDelegate
- (void)mallsTopCellDidSelectAtIndex:(NSInteger)index {
    self.mallType = index;
}

@end
