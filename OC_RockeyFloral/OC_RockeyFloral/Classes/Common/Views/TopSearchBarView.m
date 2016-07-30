//
//  TopSearchBarView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/22.
//  Copyright © 2016年 Rockey. All rights reserved.
//
/********* 顶部搜索框 *************/

#import "TopSearchBarView.h"
#import "SearchBar.h"

//static CGFloat kSearchBarHeight = 50.0;
static CGFloat kAnimateDuring = 0.4;
@interface TopSearchBarView ()<SearchBarDelegate>
/** 搜索框 */
@property (nonatomic, weak) SearchBar *searchBar;

@end

@implementation TopSearchBarView
- (instancetype)initWithEffect:(UIVisualEffect *)effect {
    if (self = [super initWithEffect:effect]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.opaque = YES;
    
    [self.searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(0);
        make.height.equalTo(kNavigationBarHeight);
    }];
}


- (void)startAnimation {
    [self.searchBar becomeFirstResponder];
    self.searchBar.transform = CGAffineTransformMakeTranslation(0, -kNavigationBarHeight);
    self.hidden = NO;
    [UIView animateWithDuration:kAnimateDuring animations:^{
        self.searchBar.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}
- (void)endAnimation {
    [self.searchBar resignFirstResponder];
    [UIView animateWithDuration:kAnimateDuring animations:^{
        self.searchBar.transform = CGAffineTransformMakeTranslation(0, -kNavigationBarHeight);
        self.alpha = 0.2;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma makr - SearchBarDelegate
- (void)seachBarDidCancel:(SearchBar *)searchBar {
    [self endAnimation] ;
}
- (void)searchBar:(SearchBar *)searchBar searchKey:(NSString *)string {
    [self endAnimation];
    DEBUG_Log(@"search %@",string);
}

#pragma mark - lazy load
- (SearchBar *)searchBar {
    if (!_searchBar) {
        SearchBar *searchBar = [[SearchBar alloc] init];
        searchBar.delegate = self;
        searchBar.backgroundColor = [UIColor whiteColor];
        [self addSubview:searchBar];
        _searchBar = searchBar;
    }
    return _searchBar;
}

@end
