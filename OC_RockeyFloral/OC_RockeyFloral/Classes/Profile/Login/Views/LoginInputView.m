//
//  LoginInputView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/8.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "LoginInputView.h"
#import "TitleBtn.h"

@interface LoginInputView ()

@property (nonatomic, weak) UIImageView *iconImgView;
@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) TitleBtn *localBtn;
@property (nonatomic, weak) UIButton *verifyBtn;

@property (nonatomic, weak) UIImageView *underLine;

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic) BOOL isTimerSet;

@end

@implementation LoginInputView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, inputType) ignore:@0] subscribeNext:^(NSNumber *x) {
        LoginInputType inputType = x.integerValue;
        
        UIImage *img = nil;
        NSString *placeHolder = @"";
        if (LoginInputType_local == inputType) {
            self.verifyBtn.hidden = true;
            
            img = [UIImage imageNamed:@"local"];
            placeHolder = @"国家地区/Location";
            
            [[self.localBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kToLocalController object:@(self.loginType)];
            }];
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kLocalDidSelected object:nil] subscribeNext:^(NSNotification *x) {
                if ([x.object isEqual:@(self.loginType)]) {
                    [self.localBtn setTitle:x.userInfo[@"key"] forState:UIControlStateNormal];
                }
            }];
        } else if (LoginInputType_phone == inputType) {
            self.localBtn.hidden = true;
            self.verifyBtn.hidden = true;
            
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            
            img = [UIImage imageNamed:@"phone"];
            placeHolder = @"手机号/Phone Number";
        } else if (LoginInputType_verify == inputType) {
            self.localBtn.hidden = true;
            
            img = [UIImage imageNamed:@"safe"];
            placeHolder = @"验证码/Code";
        } else if (LoginInputType_password == inputType) {
            self.localBtn.hidden = true;
            self.verifyBtn.hidden = true;
            
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            self.textField.secureTextEntry = true;
          
            img = [UIImage imageNamed:@"pwd"];
            placeHolder = @"密码/Password";
        }
        
        self.iconImgView.image = img;
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    }];
    
    
}

- (void)setupUI {

    [self.iconImgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(19, 20));
    }];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImgView.mas_right).offset(10);
        make.right.centerY.equalTo(self);
    }];
    [self.localBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(self);
    }];
    [self.verifyBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(80, 25));
    }];
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(-1);
    }];
}

#pragma mark - lazy load
- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        _iconImgView = imgView;
    }
    return _iconImgView;
}
- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}
- (TitleBtn *)localBtn {
    if (!_localBtn) {
        TitleBtn *button = [TitleBtn new];
        [button setImage:[UIImage imageNamed:@"goto"] forState:UIControlStateNormal];
        [button setTitle:@"中国+86" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:button];
        _localBtn = button;
    }
    return _localBtn;
}
- (UIButton *)verifyBtn {
    if (!_verifyBtn) {
        UIButton *button = [UIButton new];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.borderWidth = .6;
        button.layer.cornerRadius = 2;
        [self addSubview:button];
        _verifyBtn = button;
        
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self timerBegin];
        }];
    }
    return _verifyBtn;
}
- (UIImageView *)underLine {
    if (!_underLine) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self addSubview:imgView];
        _underLine = imgView;
    }
    return _underLine;
}

#pragma mark - 计时器
- (void)cancelTimer {
    if (self.isTimerSet) {
        dispatch_cancel(self.timer);
        _isTimerSet = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.verifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.verifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        });
    }
}

- (void)timerBegin {

    __block NSTimeInterval seconds = 6;
    dispatch_queue_t timerQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, timerQueue);
    _timer = timer;
    
    dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (seconds <= 0) {
            [self cancelTimer];
        } else {
            if (!_isTimerSet) {
                _isTimerSet = YES;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.verifyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                    self.verifyBtn.titleLabel.font = [UIFont systemFontOfSize:11];
                });
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSString *title = [NSString stringWithFormat:@"%ld后重新获取",(long)seconds];
                [self.verifyBtn setTitle:title forState:UIControlStateNormal];
            });
            seconds--;
        }
    });
    dispatch_resume(timer);
}


@end





