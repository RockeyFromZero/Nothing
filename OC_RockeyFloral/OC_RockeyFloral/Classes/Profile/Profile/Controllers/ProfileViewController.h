//
//  ProfileViewController.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UICollectionViewController

@property (nonatomic, strong) Author *author;
@property (nonatomic, assign)  BOOL isUser;

@end
