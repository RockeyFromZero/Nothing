//
//  DetailFooterView.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "DetailFooterView.h"
#import "NSDate+Extention.h"

@interface DetailFooterView ()

/** 查看 */
@property (nonatomic, weak) UIButton *seeBtn;
/** 点赞 */
@property (nonatomic, weak) UIButton *praiseBtn;
/** 评论 */
@property (nonatomic, weak) UIButton *commentBtn;
/** 时间线 */
@property (nonatomic, weak) UIButton *timeLine;
/** TopLine */
@property (nonatomic, weak) UIImageView *topLine;

@end

@implementation DetailFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
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
        [self.timeLine setTitle:artical.createDateDesc forState:UIControlStateNormal];
    }];
}

- (void)setupUI {
    CGFloat margin = -5;
    CGFloat width = 50;
    
    [self.topLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(1);
    }];
    [self.timeLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.height.equalTo(self.contentView);
    }];
    [self.commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(margin);
        make.centerY.height.equalTo(self.contentView);
        make.width.equalTo(width);
    }];
    [self.praiseBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentBtn.mas_left).offset(margin);
        make.centerY.height.equalTo(self.contentView);
        make.width.equalTo(width);
    }];
    [self.seeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.praiseBtn.mas_left).offset(margin);
        make.centerY.height.equalTo(self.contentView);
        make.width.equalTo(width);
    }];
}

#pragma mark - Lazy Load
- (UIImageView *)topLine {
    if (!_topLine) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"underLine"]];
        [self.contentView addSubview:imgView];
        _topLine = imgView;
    }
    return _topLine;
}
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
        [[_commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(detailFooterAction:)]) {
                [_delegate detailFooterAction:_artical.ID];
            }
        }];
    }
    return _commentBtn;
}
- (UIButton *)timeLine {
    if (!_timeLine) {
        _timeLine = [self createBtn:@"2345" image:[UIImage imageNamed:@"home_cell_time"]];
    }
    return _timeLine;
}

- (UIButton *)createBtn:(NSString *)title image:(UIImage *)img {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:img forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:13];
    [self.contentView addSubview:button];
    return button;
}


@end
