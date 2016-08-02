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
    if (!objc_getAssociatedObject(self, @selector(setHud:))) {
        MBProgressHUD *hud = [MBProgressHUD new];
        hud.userInteractionEnabled = NO;
        hud.animationType = MBProgressHUDAnimationFade;
        hud.color = [UIColor colorWithWhite:0.8 alpha:0.6];
        hud.removeFromSuperViewOnHide = YES;
        objc_setAssociatedObject(self, @selector(setHud:), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, @selector(setHud:));
}
- (void)setHud:(MBProgressHUD *)hud {
    objc_setAssociatedObject(self, @selector(setHud:), hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUD:(NSString *)text {
    self.hud.labelText = text;
    [self.hud show:YES];
    
    if (self.hudSuperView && ![self.hudSuperView.subviews containsObject:self.hud]) {
        [self.hudSuperView addSubview:self.hud];
    }
}
- (void)hideHUDAfterDelay:(NSTimeInterval)delay {
    [self.hud hide:YES afterDelay:delay];
    
    objc_setAssociatedObject(self, @selector(setHud:), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - hud superView
- (UIView *)hudSuperView {
    return objc_getAssociatedObject(self, @selector(setHudSuperView:));
}
- (void)setHudSuperView:(UIView *)hudSuperView {
    objc_setAssociatedObject(self, @selector(setHudSuperView:), hudSuperView, OBJC_ASSOCIATION_ASSIGN);
}
@end
