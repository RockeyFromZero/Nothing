//
//  TopMenuView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TopMenuView.h"

@interface TopMenuView ()
/**  */
@property (nonatomic, copy) void (^topType)(TopType);

/** 专栏 */
@property (nonatomic, weak) UIButton *articalBtn;
/** 作者 */
@property (nonatomic, weak) UIButton *authorBtn;
/** under line（来回滑动的线） */
@property (nonatomic, weak) UIView *underLine;
/** bottom line(底部分割线) */
@property (nonatomic, weak) UIView *bottomLine;


@end

@implementation TopMenuView
+ (instancetype)topMenu:(void (^)(TopType))topType {
    return [[self alloc] initWithBlock:topType];
}
- (instancetype)initWithBlock:(void (^)(TopType))topType {
    if (self = [super init]) {
        _topType = topType;
        [self setupUI];
        
        [[RACObserve(self, titles) ignore:nil] subscribeNext:^(NSArray *titles) {
            
            [self.articalBtn setTitle:titles[0] forState:UIControlStateNormal];
            [self.authorBtn setTitle:titles[1] forState:UIControlStateNormal];
        }];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self.articalBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.height.equalTo(self);
    }];
    [self.authorBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.articalBtn.mas_right);
        make.size.equalTo(self.articalBtn);
        make.right.centerY.equalTo(self);
    }];
    
    CGFloat width = [@"专栏" boundingRectWithSize:CGSizeMake(kScreenWidth/2.0, 2) 
                                        options:NSStringDrawingUsesFontLeading 
                                     attributes:@{NSFontAttributeName:self.articalBtn.titleLabel.font} 
                                        context:nil].size.width;
    CGFloat undelOri = (kScreenWidth/2.0-width)/2;
    [self.underLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(undelOri);
        make.size.equalTo(CGSizeMake(width, 2));
        make.bottom.equalTo(self);
    }];
    [self.bottomLine makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-0.6);
        make.left.right.equalTo(self);
        make.height.equalTo(0.6);
    }];
}

#pragma mark - lazy load
- (void)button:(UIButton *)button title:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"CODE BOLD" size:13];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        /** 如果点击 选中的按钮 直接返回 */
        if ((button.tag == TopType_artical && self.underLine.center.x<kScreenWidth/2) ||
            (button.tag == TopType_author && self.underLine.center.x>kScreenWidth/2)) {
            return ;
        }
        
        if (_topType) _topType(button.tag);
        CGFloat left = button.frame.origin.x + button.titleLabel.frame.origin.x;
        [self.underLine updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(left);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            [self layoutIfNeeded];
        }];
    }];
}
- (UIButton *)articalBtn {
    if (!_articalBtn) {
        UIButton *button = [UIButton new];
        [self button:button title:@"专栏"];
        button.tag = TopType_artical;
        [self addSubview:button];
        _articalBtn = button;
    }
    return _articalBtn;
}
- (UIButton *)authorBtn {
    if (!_authorBtn) {
        UIButton *button = [UIButton new];
        [self button:button title:@"作者"];
        button.tag = TopType_author;
        [self addSubview:button];
        _authorBtn = button;
    }
    return _authorBtn;
}
- (UIView *)underLine {
    if (!_underLine) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        _underLine = view;
    }
    return _underLine;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        _bottomLine = view;
    }
    return _bottomLine;
}

@end
