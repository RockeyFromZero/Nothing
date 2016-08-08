//
//  CountryController.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/9.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryController : UITableViewController

@property (nonatomic) LoginType loginType;

@end

@interface CountryModel : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSArray *value;

@end