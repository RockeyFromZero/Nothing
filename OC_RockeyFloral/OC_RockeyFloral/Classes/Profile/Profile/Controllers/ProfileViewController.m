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

@interface ProfileViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) TitleBtn *titleBtn;

@property (nonatomic, copy) NSArray *dataList;

@end

@implementation ProfileViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (instancetype)init {
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

- (void)getDatas {
    _dataList = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0];
}

- (void)setupNavigation {
    self.navigationItem.titleView = self.titleBtn;
}

- (void)setupUI {
    [self setupNavigation];
    self.collectionView.backgroundColor = [UIColor gray:240];
    
    [self.collectionView registerClass:[ProfileUserInfoCell class] forCellWithReuseIdentifier:NSStringFromClass([ProfileUserInfoCell class])];
    [self.collectionView registerClass:[ProfileArticalCell class] forCellWithReuseIdentifier:NSStringFromClass([ProfileArticalCell class])];
    [self.collectionView registerClass:[ProfileCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ProfileCollectionHeader class])];
}

#pragma mark - CollectionDelegate && dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0==section ? 1 : self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        ProfileUserInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProfileUserInfoCell class]) forIndexPath:indexPath];
        return cell;
    } else {
        ProfileArticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ProfileArticalCell class]) forIndexPath:indexPath];
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
- (TitleBtn *)titleBtn {
    if (!_titleBtn) {
        TitleBtn *titleBtn = [[TitleBtn alloc] init];
        titleBtn.topTitle = NSLocalizedString(@"Profile_title", @"");
        _titleBtn = titleBtn;
    }
    return _titleBtn;
}

@end
