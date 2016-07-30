//
//  CommentViewController.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCellModel.h"

@interface CommentViewController : UITableViewController

@property (nonatomic, copy) NSString *bbsID;

@property (nonatomic, strong) CommentCellModel *cellModel;

@end
