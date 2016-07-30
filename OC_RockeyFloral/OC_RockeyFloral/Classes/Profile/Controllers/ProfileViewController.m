//
//  ProfileViewController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ProfileViewController.h"
#import <SDWebImage/UIImage+GIF.h>

@interface ProfileViewController ()

@property (nonatomic, weak) TitleBtn *titleBtn;

@end

@implementation ProfileViewController
- (TitleBtn *)titleBtn {
    if (!_titleBtn) {
        TitleBtn *titleBtn = [[TitleBtn alloc] init];
        titleBtn.topTitle = NSLocalizedString(@"Profile_title", @"");
        _titleBtn = titleBtn;
    }
    return _titleBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleBtn;

    
    UIImage *gitImg = [UIImage sd_animatedGIFNamed:@"gif_wifi"];
    UIImageView *gifView = [[UIImageView alloc] initWithImage:gitImg];
    gifView.layer.borderColor = [UIColor redColor].CGColor;
    gifView.layer.borderWidth = .6;
    [self.view addSubview:gifView];
//    [gifView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(100);
//        make.top.equalTo(100);
//        make.size.equalTo(CGSizeMake(100, 100));
//    }];
}

@end
