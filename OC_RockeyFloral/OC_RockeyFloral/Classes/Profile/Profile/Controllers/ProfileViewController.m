//
//  ProfileViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ProfileViewController.h"

#import "ProfileArticalCell.h"
#import "ProfileUserInfoCell.h"
#import "ProfileCollectionHeader.h"

#import "ProfileArticalVM.h"

@interface ProfileViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, strong) ProfileArticalVM *articalVM;
@property (nonatomic, copy) NSArray *articals;

@end

@implementation ProfileViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (instancetype)init {
    _articals = [NSArray array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.collectionView.alwaysBounceVertical = true;
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getDatas];
    [self setupUI];
}

- (void)setupNavigation {
    self.title = @"个人中心";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn setImage:[UIImage imageNamed:@"pc_setting_40x40"] forState:UIControlStateNormal];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DEBUG_Log(@"setting ");
    }];
}

- (void)setupUI {
    [self setupNavigation];
    self.collectionView.backgroundColor = [UIColor gray:240];
    
    [self.collectionView registerClass:[ProfileUserInfoCell class] forCellWithReuseIdentifier:NSStringFromClass([ProfileUserInfoCell class])];
    [self.collectionView registerClass:[ProfileArticalCell class] forCellWithReuseIdentifier:NSStringFromClass([ProfileArticalCell class])];
    [self.collectionView registerClass:[ProfileCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ProfileCollectionHeader class])];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshUserDetail];
        [self.articalVM getFirst];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.articalVM getNext];
    }];
}

- (void)refreshUserDetail {
    [[NetworkTool sharedTool] getAction:@"http://m.htxq.net/servlet/UserCustomerServlet?action=getUserDetail" paras:@{@"userId": _author.ID} success:^(id success) {
        if (success[@"result"]) {
            _author = [MTLJSONAdapter modelOfClass:[Author class] fromJSONDictionary:success[@"result"] error:nil];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    } failure:nil];
}

- (void)getDatas {
    [self refreshUserDetail];
    _articalVM = [ProfileArticalVM profileArticalVM:^(ErrorCode errorCode, NSArray *obj) {
        [self endRefresh:errorCode];
        if (ErrorCode_success == errorCode) {
            self.articals = [obj copy];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        } else if (ErrorCode_NoMore != errorCode) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络故障,请检查网络设置" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:true completion:^{
                [self dismissAlert:alert];
            }];
        }
    }];
}
- (void)dismissAlert:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:true completion:nil];
}

- (void)endRefresh:(ErrorCode)errorCode {
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    } else if ([self.collectionView.mj_footer isRefreshing]) {
        if (ErrorCode_NoMore == errorCode) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.collectionView.mj_footer endRefreshing];
        }
    }
}

#pragma mark - CollectionDelegate && dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0==section ? 1 : self.articals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        ProfileUserInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProfileUserInfoCell class]) forIndexPath:indexPath];
        cell.author = _author;
        return cell;
    } else {
        if (indexPath.row == self.articals.count-1) {
            [self.articalVM getNext];
        }
        ProfileArticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProfileArticalCell class]) forIndexPath:indexPath];
        cell.model = self.articals[indexPath.row];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ProfileCollectionHeader class]) forIndexPath:indexPath];
    header.title = @"订阅";
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return 0==section ? CGSizeZero : CGSizeMake(kScreenWidth, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return 0==indexPath.section ? CGSizeMake(kScreenWidth, 160) : CGSizeMake((kScreenWidth-24)/2, 230);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return 0==section ? UIEdgeInsetsMake(5, 0, 5, 0) : UIEdgeInsetsMake(10, 10, 0, 10);
}


#pragma mark - lazy load


@end
