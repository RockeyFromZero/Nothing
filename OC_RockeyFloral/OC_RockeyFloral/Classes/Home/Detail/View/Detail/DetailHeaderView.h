//
//  DetailHeaderView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artical.h"

@protocol DetailHeaderDelegate <NSObject>

- (void)detailHeaderAction;

@end

@interface DetailHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<DetailHeaderDelegate> delegate;

@property (nonatomic, strong) Artical *artical;

@end
