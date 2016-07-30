//
//  SearchBar.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/22.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar ()<UITextFieldDelegate>

/** 输入框 */
@property (nonatomic, weak) UITextField *textField;
/** 取消按钮 */
@property (nonatomic, weak) UIButton *cancel;

@end

@implementation SearchBar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self bindOperation];
    }
    return self;
}

- (void)bindOperation {
    [[self.cancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_delegate && [_delegate respondsToSelector:@selector(seachBarDidCancel:)]) {
            [_delegate seachBarDidCancel:self];
        }
    }];
}

- (void)setupUI {
    CGFloat margin = 10.0;
    
    [self.cancel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-5);
        make.right.equalTo(-margin);
        make.width.equalTo(40);
    }];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancel);
        make.left.equalTo(margin);
        make.height.equalTo(kSearchBarHeight*0.8);
        make.right.equalTo(self.cancel.mas_left);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(searchBar:searchKey:)]) {
        [_delegate searchBar:self searchKey:textField.text];
    }
    textField.text = @"";
    return YES;
}

- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.textField becomeFirstResponder];;
}
- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    return [self.textField resignFirstResponder];
}

#pragma mark - lazy load
- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [UITextField new];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"f_search"]];
        textField.layer.cornerRadius = 3;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 0.5;
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搜索关键词" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
        textField.delegate = self;
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}
- (UIButton *)cancel {
    if (!_cancel) {
        UIButton *cancel = [UIButton new];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:cancel];
        _cancel = cancel;
    }
    return _cancel;
}

@end
