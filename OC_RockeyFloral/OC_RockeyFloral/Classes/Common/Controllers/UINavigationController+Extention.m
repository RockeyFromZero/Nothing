//
//  NavigationController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "NavigationController.h"
#import <objc/runtime.h>

@implementation UINavigationController (Extention)
//
//+ (void)load {
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        Class selfClass = [self class];
//        
//        SEL originalSEL = @selector(pushViewController:animated:);
//        SEL swizzlingSEL = @selector(Swiizling_pushViewController:animated:);
//        
//        Method originalMethod = class_getInstanceMethod(selfClass, originalSEL);
//        Method swizzlingMethod = class_getInstanceMethod(selfClass, swizzlingSEL);
//        
//        BOOL success = class_addMethod(selfClass, originalSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
//        if (success) {
//            class_replaceMethod(selfClass, swizzlingSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzlingMethod);
//        }
//        
//    });
//
//    
//}
//
//- (void)Swiizling_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    [self Swiizling_pushViewController:viewController animated:animated];
//    viewController.hidesBottomBarWhenPushed = YES;
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
////     [super pushViewController:viewController animated:animated];
//}
//
////- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
////    viewController.hidesBottomBarWhenPushed = YES;
////    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
////    [super pushViewController:viewController animated:animated];
////}
////
//- (void)back {
//    [self popViewControllerAnimated:YES];
//}

@end
