//
//  MallsCategoryHeader.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsCategoryHeader.h"
#import "TitleBtn.h"


@interface MallsCategoryHeader ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) TitleBtn *button;

@end

@implementation MallsCategoryHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        [self bindModel];
        
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [self addGestureRecognizer:tap];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            if (_delegate && [_delegate respondsToSelector:@selector(mallsCategoryHeader:didSelectAtSection:)]) {
                [_delegate mallsCategoryHeader:self didSelectAtSection:self.tag];
            }
        }];
    }
    return self;
}
- (void)setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.button makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.equalTo(44);
        make.width.equalTo(self.contentView);
    }];
}
- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(MallsCategoryHeaderModel *model) {
        if (model.isShowChild) {
            [self.button setImage:[UIImage imageNamed:@"hp_arrow_up"] forState:UIControlStateNormal];
        } else {
            [self.button setImage:[UIImage imageNamed:@"hp_arrow_down"] forState:UIControlStateNormal];
        }
        [self.button setTitle:model.title forState:UIControlStateNormal];
    }];
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_delegate && [_delegate respondsToSelector:@selector(mallsCategoryHeader:didSelectAtSection:)]) {
            [_delegate mallsCategoryHeader:self didSelectAtSection:self.tag];
        }
    }];
}

#pragma mark - lazy load
- (TitleBtn *)button {
    if (!_button) {
        TitleBtn *button = [[TitleBtn alloc] init];
        [self.contentView addSubview:button];
        _button = button;
    }
    return _button;
}

@end
