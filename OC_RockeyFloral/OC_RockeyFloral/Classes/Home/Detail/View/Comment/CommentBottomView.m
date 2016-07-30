//
//  CommentBottomView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "CommentBottomView.h"

@interface CommentBottomView ()

/** top line */
@property (nonatomic, weak) UIImageView *topLine;
/** 输入框 */
@property (nonatomic, weak) UITextField *textField;
/** send 按钮 */
@property (nonatomic, weak) UIButton *sendBtn;
/** bottom line */
@property (nonatomic, weak) UIImageView *bottomLine;

@end

@implementation CommentBottomView
- (instancetype)init {
    if (self = [super init]) {

        [self addKeyboardNotification];
        [self setupUI];
    }
    return self;
}

- (void)addKeyboardNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification *notification) {
        CGRect rect = ((NSValue *)notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"]).CGRectValue;
        if (rect.origin.y == kScreenHeight) {
            /** 隐藏键盘 */
        }
        if (_delegate && [_delegate respondsToSelector:@selector(CommentBottomDelegate:keyboardFrameWillChange:)]) {
            [_delegate CommentBottomDelegate:self keyboardFrameWillChange:notification.userInfo];
        }
    }];
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self.topLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(0.6);
    }];
    [self.sendBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(40);
    }];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(30);
        make.left.equalTo(10);
        make.right.equalTo(self.sendBtn.mas_left).offset(-10);
    }];
    [self.bottomLine makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.equalTo(0.6);
    }];
}

#pragma mark - all kinds of operations
- (void)endEditing {
    [self.textField resignFirstResponder];
    [self textFieldPlacholder:self.textField];
}

#pragma mark - lazy load
- (UIImageView *)topLine {
    if (!_topLine) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self addSubview:imgView];
        _topLine = imgView;
    }
    return _topLine;
}

- (void)textFieldPlacholder:(UITextField *)textField {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"评论"];
    [attr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                          NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, attr.length)];
    textField.attributedPlaceholder = attr;
}
- (UITextField *)textField {
    if (!_textField) {
        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectZero leftWidth:10];
        textfield.background = [UIImage imageNamed:@"s_bg_3rd_292x43"];
        textfield.font = [UIFont systemFontOfSize:12];
        [self textFieldPlacholder:textfield];
        [self addSubview:textfield];
        _textField = textfield;
    }
    return _textField;
}
- (UIButton *)sendBtn {
    if (!_sendBtn) {
        UIButton *button = [UIButton new];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:button];
        _sendBtn = button;
        
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self endEditing];
            if (_delegate && [_delegate respondsToSelector:@selector(CommentBottomDelegate:send:)]) {
                [_delegate CommentBottomDelegate:self send:@"send"];
            }
        }];
    }
    return _sendBtn;
}
- (UIImageView *)bottomLine {
    if (!_bottomLine) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self addSubview:imgView];
        _bottomLine = imgView;
    }
    return _bottomLine;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
@end
