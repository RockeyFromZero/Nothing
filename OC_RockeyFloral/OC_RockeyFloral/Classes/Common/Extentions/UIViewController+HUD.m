//
//  UIViewController+Extention.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/5.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "UIViewController+HUD.h"

@implementation UIViewController(HUD)

- (MBProgressHUD *)hud {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MBProgressHUD *hud = [MBProgressHUD new];
        hud.userInteractionEnabled = YES;
        hud.animationType = MBProgressHUDAnimationFade;
//        hud.mode = MBProgressHUDModeCustomView;
        hud.color = [UIColor colorWithWhite:0.8 alpha:0.6];
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_cell_praiseSelected"]];
    
        objc_setAssociatedObject(self, @selector(setHud:), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
    return objc_getAssociatedObject(self, @selector(setHud:));
}
- (void)setHud:(MBProgressHUD *)hud {
    objc_setAssociatedObject(self, @selector(setHud:), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUD:(NSString *)text {
    self.hud.labelText = text;
    [self.hud show:YES];
}
- (void)hideHUDAfterDelay:(NSTimeInterval)delay {
    [self.hud hide:YES afterDelay:delay];
}


@end
