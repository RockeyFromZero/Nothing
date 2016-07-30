//
//  TopArticalCell.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/20.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artical.h"

@interface TopArticalCell : UITableViewCell

/** 主题图片 */
@property (nonatomic, weak) UIImageView *smallImg;
/** 排行 */
@property (nonatomic, weak) UILabel *topSort;
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** topLine */
@property (nonatomic, weak) UIView *topLine;
/** underLine */
@property (nonatomic, weak) UIView *underLine;

/** 排名 */
@property (nonatomic, assign) NSInteger sort;
/** artical */
@property (nonatomic, strong) Artical *artical;


- (void)setupUI;
- (void)bindModel;

@end
