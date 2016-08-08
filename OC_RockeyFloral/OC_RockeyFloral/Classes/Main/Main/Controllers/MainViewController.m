//
//  MainViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "NavigationController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TitleBtn.h"

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MallsViewController.h"
#import "ProfileViewController.h"

#import "LoginTool.h"
#import "LoginController.h"

@interface MainViewController()<UITabBarControllerDelegate>

@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak id weakSelf = self;
    self.delegate = weakSelf;
    
    [self setup];
}

- (void)setup {
    
    [self addChildViewController:[[HomeViewController alloc] init] title:NSLocalizedString(@"tab_theme", nil)];
    [self addChildViewController:[[MallsViewController alloc] init] title:NSLocalizedString(@"tab_malls", nil)];
    [self addChildViewController:[[ProfileViewController alloc] init] title:NSLocalizedString(@"tab_profile", nil)];
    /** text color */
    self.tabBar.tintColor = [UIColor brownColor];
    /** background color */
//    self.tabBar.barTintColor = [UIColor blackColor];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title {
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    nav.tabBarItem.title = title;
    
    NSString *imgName = [NSString stringWithFormat:@"tb_%lu",self.childViewControllers.count-1];
    nav.tabBarItem.image = [UIImage imageNamed:imgName];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imgName stringByAppendingString:@"_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-1) {
        if (![[LoginTool shareInstance] isLogin]) {
            LoginController *controller = [[LoginController alloc] init];
            controller.loginType = LoginType_login;
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:controller];
            [nav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [nav.navigationBar setShadowImage:[UIImage new]];
            [self presentViewController:nav animated:YES completion:nil];
        }
        return [[LoginTool shareInstance] isLogin];
    }
    return YES;
}


@end
