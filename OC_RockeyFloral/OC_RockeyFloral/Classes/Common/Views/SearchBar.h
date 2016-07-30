//
//  SearchBar.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/22.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchBar;

#define kSearchBarHeight 40
@protocol SearchBarDelegate <NSObject>


- (void)seachBarDidCancel:(SearchBar *)searchBar;
- (void)searchBar:(SearchBar *)searchBar searchKey:(NSString *)string;

@end

@interface SearchBar : UIView

@property (nonatomic, weak) id<SearchBarDelegate> delegate;

@end
