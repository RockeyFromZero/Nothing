//
//  TopAuthorCell.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"


#define kTopAuthorCellHeight 60
@interface TopAuthorCell : UITableViewCell

/** 排名 */
@property (nonatomic, assign) NSInteger sort;
/** artical */
@property (nonatomic, strong) Author *author;

@end
