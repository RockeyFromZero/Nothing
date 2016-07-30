//
//  DetailViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "DetailViewController.h"
#import "CommentViewController.h"

#import "DetailHeaderView.h"
#import "DetailFooterView.h"
#import "DetailTopCell.h"
#import "DetailWebCell.h"

#import "ShareBlurView.h"

@interface DetailViewController ()<DetailWebCellDelegate,DetailHeaderDelegate,DetailFooterDelegate>

/** WebCell WebViewFinishLoad Cell Height */
@property (nonatomic, assign) CGFloat webCellHeight;
/** shareVeiw */
@property (nonatomic, weak) ShareBlurView *shareBlurView;


@end

@implementation DetailViewController
static CGFloat kHeaderFooterHeight = 45;
static CGFloat kTopCellHeight = 240;

- (void)rightItemAction {
    
}
- (void)setupNavi {
    self.navigationItem.title = _artical.title;
    
    UIButton *rightBarItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBarItem setImage:[[UIImage imageNamed:@"ad_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [rightBarItem setImage:[[UIImage imageNamed:@"ad_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarItem];
    
    [[rightBarItem rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.shareBlurView.isHidden) {
            [self.shareBlurView startAnimate];
        } else {
            [self.shareBlurView endAnimate];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
}
- (void)setupUI {
    [self setupNavi];
    [self shareBlurView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DetailHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DetailHeaderView class])];
    [self.tableView registerClass:[DetailFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([DetailFooterView class])];
    [self.tableView registerClass:[DetailTopCell class] forCellReuseIdentifier:NSStringFromClass([DetailTopCell class])];
    [self.tableView registerClass:[DetailWebCell class] forCellReuseIdentifier:NSStringFromClass([DetailWebCell class])];

}

#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (0 == indexPath.row) {
        DetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailTopCell class])];
        cell.artical = _artical;
        return cell;
    } else {
        DetailWebCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailWebCell class])];
        cell.delegate = self;
        cell.artical = _artical;
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    DetailFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([DetailFooterView class])];
    view.delegate = self;
    view.artical = _artical;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DetailHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([DetailHeaderView class])];
    view.delegate = self;
    view.artical = _artical;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kHeaderFooterHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kHeaderFooterHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        return kTopCellHeight;
    } else {
        
        return self.webCellHeight>kScreenHeight-2*kHeaderFooterHeight-kTopCellHeight? self.webCellHeight: kScreenHeight-2*kHeaderFooterHeight-kTopCellHeight;;
    }
}

#pragma mark - DetailWebCellDelegate
- (void)DetailWebCellGetHeight:(CGFloat)height {
    self.webCellHeight = height;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - DetailHeaderDelegate
- (void)detailHeaderAction {
    DEBUG_Log(@"您订阅了 ................");
}
#pragma mark - DetailFooterDelegate
- (void)detailFooterAction:(NSString *)ID {
    CommentViewController *comment = [[CommentViewController alloc] init];
    comment.bbsID = ID;
    [self.navigationController pushViewController:comment animated:NO];
}

#pragma lazy load
- (ShareBlurView *)shareBlurView {
    if (!_shareBlurView) {
        ShareBlurView *blurView = [[ShareBlurView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark] clickAtIndex:^(NSInteger index) {
            DEBUG_Log(@"index is %ld",index);
        }];
        blurView.hidden = YES;
        [kWindow addSubview:blurView];
        _shareBlurView = blurView;
        
        [blurView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(kNavigationBarHeight);
            make.left.right.bottom.equalTo(kWindow);
        }];
    }
    return _shareBlurView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
