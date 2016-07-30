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

@interface HomeViewController ()<UITableViewDelegate,UITableViewDelegate>

/** 菜单按钮 */
@property (nonatomic, strong) UIButton *menuBtn;
/** 左上角 */
@property (nonatomic, weak) BlurView *blurView;
/** 标题按钮 */
@property (nonatomic, weak) TitleBtn *titleBtn;


/** 当前页 */
@property (nonatomic) NSUInteger currentPage;
/** 主题列表 */
@property (nonatomic, strong) HomeViewModel *homeVM;

@end

@implementation HomeViewController

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [HomeViewModel viewModel:^(id value) {
            
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

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [CategoryViewModel viewModel:^(id success) {
            self.blurView.categories = success;
        } failure:^(id failure) { }];
        [self homeVM];
    });
    
    [self setup];
}

- (void)setupNavigation {
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = self.titleBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.menuBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"TOP" style:UIBarButtonItemStylePlain target:self action:@selector(toTop)];
}

- (void)setup {
    [self setupNavigation];
    
    [self.tableView registerClass:[HomeArticalCell class] forCellReuseIdentifier:kHomeArticalReuseId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 330;
    self.tableView.decelerationRate = .991;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.homeVM getNext];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self showHUD:@""];
        [self.homeVM getFirst];
    }];
    
    [self.tableView addSubview:self.hud];
    [self showHUD:@""];
    [self.homeVM getFirst];
}

- (void)toTop {
    [self.navigationController pushViewController:[[TopViewController alloc] init] animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeVM.models.count;
}
- (HomeArticalCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticalCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeArticalReuseId];
    cell.artical = (Artical *)self.homeVM.models[indexPath.row];
    
    if (indexPath.row == self.homeVM.models.count-1) {
        [self.homeVM getNext];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Artical *artical = (Artical *)self.homeVM.models[indexPath.row];
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
        [self.tableView addSubview:item];
        _blurView = item;
        
        [item makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(self.tableView.contentOffset.y);
            make.left.equalTo(self.tableView);
            make.size.equalTo(CGSizeMake(kScreenWidth, kScreenHeight-64-49));
        }];
        item.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight-self.tableView.contentOffset.y);
    }
    return _blurView;
}

- (void)hideBlurView:(BOOL)hideBlurView {
    self.menuBtn.selected = !hideBlurView;
    [UIView animateWithDuration:0.5 animations:^{
        if (!hideBlurView) {
            [self.blurView updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tableView).offset(self.tableView.contentOffset.y+64);
                make.left.equalTo(self.tableView);
                make.size.equalTo(CGSizeMake(kScreenWidth, kScreenHeight-64-49));
            }];
            self.blurView.transform = CGAffineTransformMakeTranslation(0, -kScreenHeight-self.tableView.contentOffset.y);
        }
        
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











