//
//  MallsThemeCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/2.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsThemeCell.h"
#import "MallsThemeCellHeader.h"
#import "MallsThemeCollectionCell.h"

@interface MallsThemeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** Header */
@property (nonatomic, weak) MallsThemeCellHeader *header;
/** content */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation MallsThemeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        [self bindModel];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor gray:241];
//    self.contentView.backgroundColor = [UIColor whiteColor];
//    
//    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(0);
//    }];
    
    [self.header makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(kMallsThemeCellHeaderHeight);
    }];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.header.mas_bottom).offset(10);
        make.left.right.equalTo(self);
    }];
}

- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(MallsGoods *model) {
        self.header.model = model;
        
        NSInteger count = model.goodsList.count;
        CGFloat height = (count%2==0 ? count/2 : (count/2+1)) * kScreenWidth / 2;
        [self.collectionView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height);
        }];
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.goodsList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MallsThemeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MallsThemeCollectionCell class]) forIndexPath:indexPath];
    cell.model = (Goods *)self.model.goodsList[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DEBUG_Log(@" select at indexPath %@",indexPath);
}

#pragma mark - lazy load
- (MallsThemeCellHeader *)header {
    if (!_header) {
        MallsThemeCellHeader *header = [MallsThemeCellHeader new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [header addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            DEBUG_Log(@" MallsThemeCell Header clicked ");
        }];
        [self addSubview:header];
        _header = header;
    }
    return _header;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[MallsFlowLayout alloc] init]];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[MallsThemeCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([MallsThemeCollectionCell class])];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end


#pragma mark - MallsFlowLayout
@interface MallsFlowLayout ()

@end
    
@implementation MallsFlowLayout
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat width = (kScreenWidth - 2)/2.0;
    self.itemSize = CGSizeMake(width, width);
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

@end
