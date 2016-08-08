//
//  UIViewController+.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/17.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "UIViewController+Extention.h"
#import "MainViewController.h"

@implementation UIViewController(Extention)



+ (void)load {
    
//    [self SwizzloingInit];
    [self SwizzloingViewDidLoad]; 
}

+ (void)SwizzloingInit {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL originalSEL = @selector(init);
        SEL swizzlingSEL = @selector(Swizzling_init);
        
        Method originalMethod = class_getInstanceMethod(selfClass, originalSEL);
        Method swizzlingMethod = class_getInstanceMethod(selfClass, swizzlingSEL);
        
        BOOL success = class_addMethod(selfClass, originalSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (success) {
            class_replaceMethod(selfClass, swizzlingSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
}
- (instancetype)Swizzling_init {
    [self Swizzling_init];
    self.bNetworkReachability = YES;
    return self;
}



+ (void)SwizzloingViewDidLoad {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL originalSEL = @selector(viewDidLoad);
        SEL swizzlingSEL = @selector(Swizzling_viewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(selfClass, originalSEL);
        Method swizzlingMethod = class_getInstanceMethod(selfClass, swizzlingSEL);
        
        BOOL success = class_addMethod(selfClass, originalSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (success) {
            class_replaceMethod(selfClass, swizzlingSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
}

- (void)Swizzling_viewDidLoad {
    [self Swizzling_viewDidLoad];
    
    [self setupNavigation];
}
- (void)setupNavigation {
    /** 标题样式设置 */
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"CODE LIGHT" size:15]};
    /** 返回按钮颜色 */
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    /** 透明/不透明 http://blog.csdn.net/yongyinmg/article/details/39957741 */
//    self.navigationController.navigationBar.translucent = NO;
    /** 导航栏背景色 */
    //    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

- (void)setBNetworkReachability:(BOOL)bNetworkReachability {
    objc_setAssociatedObject(self, @selector(setBNetworkReachability:), @(bNetworkReachability), OBJC_ASSOCIATION_ASSIGN);
    if (bNetworkReachability) {
        [self checkNetworkStatus];
    }
}
- (BOOL)bNetworkReachability {
    return ((NSNumber *)objc_getAssociatedObject(self, @selector(bNetworkReachability))).boolValue;
}
- (void)checkNetworkStatus {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: 
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSString *title = nil;
                if (status == AFNetworkReachabilityStatusNotReachable) {
                    title = @"未连接网络";
                } else {
                    title = @"没有连接Wifi";
                }
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
                alert.view.alpha = .6;
                [self presentViewController:alert animated:NO completion:^{
                    [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:1.2];
                }];
            }
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)dismissAlert:(UIAlertController *)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}

#pragma  mark TitleLabel

@end
