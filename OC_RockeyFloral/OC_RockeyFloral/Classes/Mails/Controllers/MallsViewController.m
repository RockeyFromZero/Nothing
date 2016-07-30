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

#import "MallsViewModel.h"
#import "MallsCategoryVM.h"

@interface MallsViewController ()
/**  NavigationItems 依次是：标题、右上角、左上角 */
@property (nonatomic, weak) TitleBtn *titleBtn;
@property (nonatomic, weak) TopSearchBarView *searchBar;
@property (nonatomic, strong) UIButton *menuBtn;
@property (nonatomic, weak) BlurView *blurView;

@property (nonatomic, strong) MallsCategoryVM *categoryVM;

@end

@implementation MallsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categoryVM = [MallsCategoryVM mallsCategoryComplete:^(ErrorCode errorCode, id success) {
        self.blurView.categories = self.categoryVM.categorys;
    } failure:^(ErrorCode errorCode, id failure) {
        
    }];
    
    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation {
    self.navigationItem.titleView = self.titleBtn;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuBtn];
    
    UIButton *rightBar = [UIButton new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    [rightBar setImage:[UIImage imageNamed:@"f_search"] forState:UIControlStateNormal];
    [[rightBar rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.searchBar startAnimation];
    }];
}
- (void)setupUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark - UITableViewDelegate && datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

#pragma mark - lazy load
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
        TopSearchBarView *searchBar = [[TopSearchBarView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
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
        [self.tableView addSubview:item];
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
            make.top.equalTo(kNavigationBarHeight+self.tableView.contentOffset.y);
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(kScreenWidth, kScreenHeight-kNavigationBarHeight-kTabBarItemHeight));
        }];
        self.blurView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight-self.tableView.contentOffset.y);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (!hideBlurView) {
            self.blurView.transform = CGAffineTransformIdentity;
            self.menuBtn.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.tableView.scrollEnabled = false;
        } else {
            self.blurView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight-self.tableView.contentOffset.y);
            self.menuBtn.transform = CGAffineTransformIdentity;
            self.tableView.scrollEnabled = true;
        }
        
    }];
    
}

@end
