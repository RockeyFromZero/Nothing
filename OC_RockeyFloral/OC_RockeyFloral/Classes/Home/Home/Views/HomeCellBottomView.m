//
//  HomeCellBottomView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/30.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "HomeCellBottomView.h"

@interface HomeCellBottomView ()

/** 查看 */
@property (nonatomic, weak) UIButton *seeBtn;
/** 点赞 */
@property (nonatomic, weak) UIButton *praiseBtn;
/** 评论 */
@property (nonatomic, weak) UIButton *commentBtn;

@end

@implementation HomeCellBottomView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self bingModel];
    }
    return self;
}

- (void)bingModel {
    [[RACObserve(self, artical) ignore:nil] subscribeNext:^(Artical *artical) {
        [self.seeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)artical.read] forState:UIControlStateNormal];
        [self.praiseBtn setTitle:[NSString stringWithFormat:@"%ld",(long)artical.favo] forState:UIControlStateNormal];
        [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)artical.fnCommentNum] forState:UIControlStateNormal];
    }];
}

- (void)setupUI {
    [self.commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    [self.praiseBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentBtn.mas_left).offset(-5);
        make.centerY.equalTo(self);
    }];
    [self.seeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.praiseBtn.mas_left).offset(-5);
        make.centerY.equalTo(self);
    }];
}



#pragma mark - Lazy Load
- (UIButton *)seeBtn {
    if (!_seeBtn) {
        _seeBtn = [self createBtn:@"0" image:[UIImage imageNamed:@"home_cell_see"]];
    }
    return _seeBtn;
}
- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [self createBtn:@"1234" image:[UIImage imageNamed:@"home_cell_praise"]];
    }
    return _praiseBtn;
}
- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [self createBtn:@"2345" image:[UIImage imageNamed:@"home_cell_comment"]];
    }
    return _commentBtn;
}

- (UIButton *)createBtn:(NSString *)title image:(UIImage *)img {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:img forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
    [self addSubview:button];
    return button;
}

@end
