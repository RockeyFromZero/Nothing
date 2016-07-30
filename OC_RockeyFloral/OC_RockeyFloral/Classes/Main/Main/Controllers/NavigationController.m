//
//  NavigationController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/27.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back:(UIBarButtonItem *)item {
    [self popViewControllerAnimated:YES];
}

@end
