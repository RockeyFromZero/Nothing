//
//  LoginInputView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoginInputType) {
    LoginInputType_local = 1,
    LoginInputType_phone,
    LoginInputType_verify,
    LoginInputType_password
};

@interface LoginInputView : UIView

@property (nonatomic) LoginType loginType;
@property (nonatomic) LoginInputType inputType;

- (void)cancelTimer;

@end
