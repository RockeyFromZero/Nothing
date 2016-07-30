//
//  UIViewController+Extention.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/5.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIViewController(HUD)

@property (nonatomic, weak) MBProgressHUD *hud;

- (void)showHUD:(NSString *)text;
- (void)hideHUDAfterDelay:(NSTimeInterval)delay;

@end
