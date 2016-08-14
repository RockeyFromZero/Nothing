//
//  ProfileUserInfoCell.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/9.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileUserInfoCellDelegate <NSObject>


@end

@interface ProfileUserInfoCell : UICollectionViewCell

@property (nonatomic, weak) id <ProfileUserInfoCellDelegate> delegate;

@property (nonatomic, strong) Author *author;

@end
