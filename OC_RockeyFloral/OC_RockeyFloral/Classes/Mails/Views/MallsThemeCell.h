//
//  MallsThemeCell.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/2.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallsGoods.h"

#define kMallsThemeCellHeaderHeight  60

@interface MallsThemeCell : UITableViewCell

@property (nonatomic, strong) MallsGoods *model;

@end

@interface MallsFlowLayout : UICollectionViewFlowLayout

@end
