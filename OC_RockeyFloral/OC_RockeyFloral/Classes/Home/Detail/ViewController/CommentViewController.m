//
//  CommentViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CommentViewController.h"

#import "CommentCell.h"
#import "CommentBottomView.h"

@interface CommentViewController ()<CommentBottomDelegate,UIScrollViewDelegate>

/** 评论列表 */
@property (nonatomic, copy) NSArray *commentsList;
/** bottom view */
@property (nonatomic, weak) CommentBottomView *bottomView;

@end

@implementation CommentViewController
static CGFloat kBottomHeight = 44;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
    _cellModel = [CommentCellModel commentCellModel:_bbsID 
                                            success:^(ErrorCode errorCode, NSString *error){
        [self cellModel:errorCode error:error];
    } failure:^{
        [self cellModel:ErrorCode_Network error:@"网络故障"];
    }];
    
    [self setupUI];
}


- (void)setupUI {
    
    [self setupTableView];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(kWindow);
        make.height.equalTo(kBottomHeight);
    }];
}

- (void)setupTableView {

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CommentCell class] forCellReuseIdentifier:NSStringFromClass([CommentCell class])];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomHeight, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.cellModel getFirst];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.cellModel getNext];
    }];
}

- (void)cellModel:(ErrorCode)errorCode error:(NSString *)error {
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    } else if ([self.tableView.mj_footer isRefreshing]) {
        if (ErrorCode_NoMore == errorCode) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    
    if (errorCode == ErrorCode_success) {
        [self.tableView reloadData];
    }
    
}
#pragma UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModel.comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CommentCell class])];
    CommentModel *model = self.cellModel.comments[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.cellModel.comments[indexPath.row];
    return model.rowHeight;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.bottomView endEditing];
}

#pragma mark - CommentBottomViewDelegate
- (void)CommentBottomDelegate:(CommentBottomView *)bottomView keyboardFrameWillChange:(NSDictionary *)userInfo {
//    for (NSString *key in [userInfo allKeys]) {
//        DEBUG_Log(@"%@\n",key);
//    }
    @weakify(self);
    [UIView animateWithDuration:0.8 animations:^{
        @strongify(self);
        CGRect rect = ((NSValue *)userInfo[@"UIKeyboardFrameEndUserInfoKey"]).CGRectValue;
        [self.bottomView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(kWindow).offset(rect.origin.y-kScreenHeight);
        }];
        [kWindow setNeedsLayout];
    }];
}

- (void)CommentBottomDelegate:(CommentBottomView *)bottomView send:(id)sendInfo {
    
    /** dispatch_after 的作用是 为了在 键盘隐藏后才滚动到底部；如果不加延时，滚动到底部的时候，底部是在键盘上方 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.cellModel.comments.count > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellModel.comments.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    });
    
}

#pragma mark - lazy Load 
- (CommentBottomView *)bottomView {
    if (!_bottomView) {
        CommentBottomView *view = [CommentBottomView new];
        view.delegate = self;
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 0.5;
        [kWindow addSubview:view];
        _bottomView = view;
    }
    return _bottomView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.bottomView.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
