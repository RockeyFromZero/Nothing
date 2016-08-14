//
//  HomeViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "HomeViewController.h"
#import "NavigationController.h"
#import "TitleBtn.h"
#import "BlurView.h"
#import "Category.h"
#import "HomeArticalCell.h"
#import "CategoryViewModel.h"
#import "HomeViewModel.h"
#import "DetailViewController.h"
#import "TopViewController.h"

static NSString *kHomeArticalReuseId = @"kHomeArticalReuseId";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 菜单按钮 */
@property (nonatomic, strong) UIButton *menuBtn;
/** 左上角 */
@property (nonatomic, weak) BlurView *blurView;
/** 标题按钮 */
@property (nonatomic, weak) TitleBtn *titleBtn;
/** tabelView */
@property (nonatomic, weak) UITableView *tableView;


/** 当前页 */
@property (nonatomic) NSUInteger currentPage;
/** 主题列表 */
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, copy) NSArray *showAriticals;

@end

@implementation HomeViewController

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [HomeViewModel viewModel:^(NSArray *value) {
            
            _showAriticals = [value copy];
            [self hideHUDAfterDelay:.8];
            if ([self.tableView.mj_footer isRefreshing]) {
                [self.tableView.mj_footer endRefreshing];
            } else if ([self.tableView.mj_header isRefreshing]) {
                [self.tableView.mj_header endRefreshing];
            }
            [self.tableView reloadData];
        } failure:^(id value) {
            [self hideHUDAfterDelay:.8];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }];
    }
    return _homeVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [CategoryViewModel viewModel:^(id success) {
        self.blurView.categories = success;
    } failure:^(id failure) { }];
    
    [self setup];
    
    [self showHUD:@""];
    [self.homeVM getFirst];
}

- (void)setupNavigation {
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = self.titleBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"TOP" style:UIBarButtonItemStylePlain target:self action:@selector(toTop)];
}

- (void)setup {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavigation];
    
    _showAriticals = [NSArray array];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(kNavigationBarHeight, 0, 0, 0));
    }];
    [self.tableView registerClass:[HomeArticalCell class] forCellReuseIdentifier:kHomeArticalReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 330;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.homeVM getNext];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self showHUD:@""];
        [self.homeVM getFirst];
    }];
    
    self.hudSuperView = kWindow;
}

- (void)toTop {
    [self.navigationController pushViewController:[[TopViewController alloc] init] animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showAriticals.count;
}
- (HomeArticalCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticalCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeArticalReuseId];
    cell.artical = (Artical *)self.showAriticals[indexPath.row];
    
    if (indexPath.row == self.showAriticals.count-1) {
        [self.homeVM getNext];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Artical *artical = (Artical *)self.showAriticals[indexPath.row];
    DetailViewController *detail = [DetailViewController new];
    detail.artical = artical;
    /**  在ios7以上运行却发现在push一半的时候会卡顿一下，这是由于UIViewController是一个空的，背景色为透明的导致的 */
//    detail.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.menuBtn.enabled = _currentPage==0;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.menuBtn.enabled = YES;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        self.menuBtn.enabled = YES;
    }
}

#pragma  mark - 懒加载
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
        titleBtn.topTitle = NSLocalizedString(@"Home_title", @"");
        [[titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [CategoryViewModel viewModel:^(id obj) {
                NSLog(@"obj is %@",obj);
            } failure:^(id obj) {
                
            }];
        }];
        
        _titleBtn = titleBtn;
    }
    return _titleBtn;
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
        item.type = BlurViewType_home;
        [self.view addSubview:item];
        _blurView = item;
        
        [item makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kNavigationBarHeight);
            make.left.equalTo(self.tableView);
            make.size.equalTo(CGSizeMake(kScreenWidth, kScreenHeight-64-49));
        }];
        item.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
    }
    return _blurView;
}

- (void)hideBlurView:(BOOL)hideBlurView {
    self.menuBtn.selected = !hideBlurView;
    [UIView animateWithDuration:0.5 animations:^{
        if (!hideBlurView) {
            [self.blurView updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(64);
                make.left.equalTo(self.tableView);
                make.size.equalTo(CGSizeMake(kScreenWidth, kScreenHeight-64-49));
            }];
            self.blurView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight);
        }
        
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.tableView testMethod];
    NSLog(@"touch began");
}


#pragma mark - Others
- (void)dealloc {
    [CategoryViewModel removeArchived];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [CategoryViewModel removeArchived];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end












