//
//  DetailWebCell.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artical.h"

@protocol DetailWebCellDelegate <NSObject>

@required
- (void)DetailWebCellGetHeight:(CGFloat)height;

@end


static id kDetailWebViewCellHeightChangeNoti = @"DetailWebViewCellHeightChangeNoti";
static id kDetailWebViewCellHeightKey = @"DetailWebCellHeightKey";
@interface DetailWebCell : UITableViewCell

@property (nonatomic, weak) id<DetailWebCellDelegate> delegate;
@property (nonatomic, strong) Artical *artical;

@end
