//
//  UITableView+Extention.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/4.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "UITableView+Extention.h"

@implementation UITableView(Extention)

- (BOOL)responseNext {
    return ((NSNumber *)objc_getAssociatedObject(self, @selector(responseNext))).boolValue;
}
- (void)setResponseNext:(BOOL)responseNext {
    objc_setAssociatedObject(self, @selector(responseNext), @(responseNext), OBJC_ASSOCIATION_ASSIGN);
}


+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL originalSEL = @selector(touchesBegan:withEvent:);
        SEL swizzlingSEL = @selector(Swizzling_touchesBegan:withEvent:);
        
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

- (void)Swizzling_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self Swizzling_touchesBegan:touches withEvent:event];
    if ([@1 isEqual:objc_getAssociatedObject(self, @selector(responseNext))]) {
        [super touchesBegan:touches withEvent:event];
    }
}

@end
