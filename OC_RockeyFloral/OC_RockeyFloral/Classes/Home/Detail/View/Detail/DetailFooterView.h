//
//  DetailFooterView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artical.h"

@protocol DetailFooterDelegate <NSObject>

- (void)detailFooterAction:(NSString *)ID;

@end

@interface DetailFooterView : UITableViewHeaderFooterView


@property (nonatomic, weak) id<DetailFooterDelegate> delegate;

@property (nonatomic, strong) Artical *artical; 

@end
