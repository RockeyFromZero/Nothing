//
//  MallsTopCell.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADS.h"

@protocol MallsTopCellDelegate <NSObject>

@required
- (void)mallsTopCellDidSelectAtIndex:(NSInteger)index;

@end

@interface MallsTopCell : UITableViewCell

@property (nonatomic, weak) id<MallsTopCellDelegate> delegate;

@property (nonatomic, strong) ADS *model;

@end
