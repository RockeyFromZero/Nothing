//
//  LoginController.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "LoginController.h"
#import "CountryController.h"

#import "LoginView.h"

@interface LoginController ()<LoginViewDelegate>

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) LoginView *loginView;

@end

@implementation LoginController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    self.loginView.loginType = self.loginType;
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kToLocalController object:nil] subscribeNext:^(NSNotification *x) {
        if ([x.object isEqual:@(self.loginType)]) {
            CountryController *controller = [CountryController new];
            controller.loginType = self.loginType;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }];
}

- (void)setupNavigation {
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [[leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn setImage:[[UIImage imageNamed:@"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [[rightBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)setupUI {
    [self setupNavigation];
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    [self.loginView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kNavigationBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - lazy load
- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBack"]];
        [self.view addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
- (LoginView *)loginView {
    if (!_loginView) {
        LoginView *view = [[LoginView alloc] init];
        view.delegate = self;
        [self.view addSubview:view];
        _loginView = view;
    }
    return _loginView;
}

#pragma mark - LoginViewDelegate
- (void)loginViewDidSelected:(LoginType)loginType {
    LoginController *controller = [LoginController new];
    controller.loginType = loginType;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
