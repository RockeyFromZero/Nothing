//
//  LoginView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)loginViewDidSelected:(LoginType)loginType;

@end

@interface LoginView : UIView

@property (nonatomic) LoginType loginType;

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end
