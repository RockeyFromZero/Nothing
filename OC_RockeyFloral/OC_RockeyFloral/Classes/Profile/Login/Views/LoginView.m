//
//  LoginView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "LoginView.h"
#import "LoginInputView.h"

@interface LoginView ()

@property (nonatomic, weak) UIImageView *topImgView;

@property (nonatomic, weak) LoginInputView *localView;
@property (nonatomic, weak) LoginInputView *phoneView;
@property (nonatomic, weak) LoginInputView *verifyView;
@property (nonatomic, weak) LoginInputView *passwordView;

@property (nonatomic, weak) UIButton *registBtn;
@property (nonatomic, weak) UIButton *forgetBtn;

@property (nonatomic, weak) UIButton *loginBtn;

@end

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, loginType) ignore:@0] subscribeNext:^(NSNumber *x) {
        LoginType type = x.integerValue;
        self.localView.loginType = type;
        
        if (LoginType_login == type) {
            [self.passwordView updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.phoneView.mas_bottom).offset(15);
            }];
            [self.verifyView removeFromSuperview];
        } else {
            [self.loginBtn updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.passwordView.mas_bottom).offset(15);
            }];
            
            NSString *title = LoginType_regist == type ? @"注册" : @"完成";
            [self.loginBtn setTitle:title forState:UIControlStateNormal];
            
            [self.registBtn removeFromSuperview];
            [self.forgetBtn removeFromSuperview];
            [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [self.verifyView cancelTimer];
            }];
        }
    }];
    
    [[self.registBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_delegate && [_delegate respondsToSelector:@selector(loginViewDidSelected:)]) {
            [_delegate loginViewDidSelected:LoginType_regist];
        }
    }];
    [[self.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_delegate && [_delegate respondsToSelector:@selector(loginViewDidSelected:)]) {
            [_delegate loginViewDidSelected:LoginType_forgetPwd];
        }
    }];
}

- (void)setupUI {
    CGFloat verticalMargin = 15.0;
    
    [self.topImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(85, 85));
    }];
    [self.localView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImgView.mas_bottom).offset(25);
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(kScreenWidth-100, 35));
    }];
    [self.phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.localView.mas_bottom).offset(verticalMargin);
        make.centerX.equalTo(self);
        make.size.equalTo(self.localView);
    }];
    [self.verifyView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(verticalMargin);
        make.centerX.equalTo(self);
        make.size.equalTo(self.localView);
    }];
    [self.passwordView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyView.mas_bottom).offset(verticalMargin);
        make.centerX.equalTo(self);
        make.size.equalTo(self.localView);
    }];
    
    [self.registBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordView);
        make.top.equalTo(self.passwordView.mas_bottom).offset(10);
    }];
    [self.forgetBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordView);
        make.top.equalTo(self.registBtn);
    }];
    
    [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.localView);
        make.height.equalTo(36);
        make.top.equalTo(self.registBtn.mas_bottom).offset(10);
    }];
}

#pragma mark - Other
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - lazy load
- (UIImageView *)topImgView {
    if (!_topImgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LOGO_85x85_"]];
        [self addSubview:imgView];
        _topImgView = imgView;
    }
    return _topImgView;
}

- (LoginInputView *)localView {
    if (!_localView) {
        LoginInputView *view = [[LoginInputView alloc] init];
        view.inputType = LoginInputType_local;
        [self addSubview:view];
        _localView = view;
    }
    return _localView;
}
- (LoginInputView *)phoneView {
    if (!_phoneView) {
        LoginInputView *view = [[LoginInputView alloc] init];
        view.inputType = LoginInputType_phone;
        [self addSubview:view];
        _phoneView = view;
    }
    return _phoneView;
}
- (LoginInputView *)verifyView {
    if (!_verifyView) {
        LoginInputView *view = [[LoginInputView alloc] init];
        view.inputType = LoginInputType_verify;
        [self addSubview:view];
        _verifyView = view;
    }
    return _verifyView;
}
- (LoginInputView *)passwordView {
    if (!_passwordView) {
        LoginInputView *view = [[LoginInputView alloc] init];
        view.inputType = LoginInputType_password;
        [self addSubview:view];
        _passwordView = view;
    }
    return _passwordView;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        UIButton *button = [UIButton new];
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:button];
        _registBtn = button;
    }
    return _registBtn;
}
- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        UIButton *button = [UIButton new];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"忘记密码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor],NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)}];
        [button setAttributedTitle:title forState:UIControlStateNormal];
        [self addSubview:button];
        _forgetBtn = button;
    }
    return _forgetBtn;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        UIButton *button = [UIButton new];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 2;
        button.layer.borderColor = [UIColor gray:241].CGColor;
        button.layer.borderWidth = .6;
        [self addSubview:button];
        _loginBtn = button;
    }
    return _loginBtn;
}

@end
