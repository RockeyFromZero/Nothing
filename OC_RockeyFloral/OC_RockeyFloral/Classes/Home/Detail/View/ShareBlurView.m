//
//  ShareBlurView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/18.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ShareBlurView.h"



@interface ShareBlurView ()

@property (nonatomic, assign) void (^clickAtIndex)(NSInteger);

/** 分享 按钮底部 */
@property (nonatomic, weak) UIView *shareView; 
@property (nonatomic, weak) UIButton *wechat;
@property (nonatomic, weak) UIButton *QQ;
@property (nonatomic, weak) UIButton *wechatFriends;
@property (nonatomic, weak) UIButton *sina;

@end

@implementation ShareBlurView
//static CGFloat orignalY = -50.0;
static CGFloat kDefaultHeadMargin10 = 10;
static CGFloat kDefaultMarin20 = 20.0;
static CGFloat kDefaultShareH = 70.0;
static CGFloat kDefalultImageWH = 66.0;

- (instancetype)initWithEffect:(UIVisualEffect *)effect clickAtIndex:(void (^)(NSInteger))clickAtIndex {
    if (self = [super initWithEffect:effect]) {
        _clickAtIndex = clickAtIndex;
        _shareVM = [[ShareVM alloc] init];
        
        self.alpha = 0;
        
        [self setupUI];
        [self addTapGuesture];
    }
    return self;
}

- (void)addTapGuesture {

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [self endAnimate];
    }];
}

- (void)setupUI {
    
    [self.contentView addSubview:self.shareView];
    
    [self.shareView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kDefaultHeadMargin10);
        make.left.right.equalTo(0);
        make.height.equalTo(kDefaultShareH);
    }];
    
    CGFloat margin = (kScreenWidth - kDefaultMarin20*2 - kDefalultImageWH*4)/3.0;
    [self.wechat makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareView);
        make.left.equalTo(kDefaultMarin20);
        make.size.equalTo(CGSizeMake(kDefalultImageWH, kDefalultImageWH));
    }];
    [self.wechatFriends makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareView);
        make.left.equalTo(self.wechat.mas_right).offset(margin);
        make.size.equalTo(CGSizeMake(kDefalultImageWH, kDefalultImageWH));
    }];
    [self.QQ makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareView);
        make.left.equalTo(self.wechatFriends.mas_right).offset(margin);
        make.size.equalTo(CGSizeMake(kDefalultImageWH, kDefalultImageWH));
    }];
    [self.sina makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareView);
        make.left.equalTo(self.QQ.mas_right).offset(margin);
        make.size.equalTo(CGSizeMake(kDefalultImageWH, kDefalultImageWH));
    }];

}

- (void)startAnimate {
    self.hidden = NO;
    self.shareView.transform = CGAffineTransformMakeTranslation(0, -kDefaultHeadMargin10-kDefaultShareH);
    [UIView animateWithDuration:kAnimateDuring animations:^{
        self.alpha = 0.8;
        self.shareView.transform = CGAffineTransformIdentity;
    }];
}
- (void)endAnimate {
    [UIView animateWithDuration:kAnimateDuring animations:^{
        self.alpha = 0;
        self.shareView.transform = CGAffineTransformMakeTranslation(0, -kDefaultHeadMargin10-kDefaultShareH);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - lazy load
- (UIView *)shareView {
    if (!_shareView) {
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        _shareView = view;
    }
    return _shareView;
}
- (UIButton *)wechat {
    if (!_wechat) {
        UIButton *button = [UIButton new];
        [self buttonWith:button Tag:ShareTag_wechat imgName:@"s_weixin_50x50"];
        [self.shareView addSubview:button];
        _wechat = button;
    }
    return _wechat;
}
- (UIButton *)wechatFriends {
    if (!_wechatFriends) {
        UIButton *button = [UIButton new];
        [self buttonWith:button Tag:ShareTag_wechatFriends imgName:@"s_pengyouquan_50x50"];
        [self.shareView addSubview:button];
        _wechatFriends = button;
    }
    return _wechatFriends;
}
- (UIButton *)QQ {
    if (!_QQ) {
        UIButton *button = [UIButton new];
        [self buttonWith:button Tag:ShareTag_QQ imgName:@"s_qq_50x50"];
        [self.shareView addSubview:button];
        _QQ = button;
    }
    return _QQ;
}
- (UIButton *)sina {
    if (!_sina) {
        UIButton *button = [UIButton new];
        [self buttonWith:button Tag:ShareTag_Sina imgName:@"s_weibo_50x50"];
        [self.shareView addSubview:button];
        _sina = button;
    }
    return _sina;
}
- (void)buttonWith:(UIButton *)button Tag:(ShareTag)tag imgName:(NSString *)imgName {
    button.tag = tag;
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_clickAtIndex) {
            _clickAtIndex(tag);
            [self endAnimate];
        }
    }];
}

@end
