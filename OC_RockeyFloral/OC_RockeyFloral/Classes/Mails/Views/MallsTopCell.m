//
//  MallsTopCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/23.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "MallsTopCell.h"
#import "TopMenuView.h"

@interface MallsTopCell () 

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) TopMenuView *topMenuView;

@end

@implementation MallsTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
    [[RACObserve(self, model) ignore:nil] subscribeNext:^(ADS *model) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.fnImageUrl] placeholderImage:[UIImage imageNamed:@"placehodler"] options:SDWebImageLowPriority];
    }];
}

- (void)createUI {
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(224);
    }];
    [self.topMenuView makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(40);
        make.bottom.left.right.equalTo(self.contentView);
    }];
}

#pragma mark - lazy load
- (UIImageView *)imgView {
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placehodler"]];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
- (TopMenuView *)topMenuView {
    if (!_topMenuView) {
        TopMenuView *view = [TopMenuView topMenu:^(TopType type) {
            [_delegate mallsTopCellDidSelectAtIndex:type];
        }];
        view.titles = @[NSLocalizedString(@"ADS_first", @""),NSLocalizedString(@"ADS_second", @"")];
        [self.contentView addSubview:view];
        _topMenuView = view;
    }
    return _topMenuView;
}


@end
