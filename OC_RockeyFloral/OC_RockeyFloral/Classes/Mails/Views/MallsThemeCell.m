//
//  MallsThemeCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/2.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsThemeCell.h"
#import "MallsThemeCellHeader.h"

@interface MallsThemeCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** Header */
@property (nonatomic, weak) MallsThemeCellHeader *header;
/** content */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation MallsThemeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        kMallsThemeCellHeaderHeight;
    }
    return self;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath:indexPath];
    return cell;
}

#pragma mark - lazy load
- (MallsThemeCellHeader *)header {
    if (!_header) {
        MallsThemeCellHeader *header = [MallsThemeCellHeader new];
        [self.contentView addSubview:header];
        _header = header;
    }
    return _header;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
    }
    return _collectionView;
}

@end


#pragma mark - MallsFlowLayout
@interface MallsFlowLayout ()

@end
    
@implementation MallsFlowLayout

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
