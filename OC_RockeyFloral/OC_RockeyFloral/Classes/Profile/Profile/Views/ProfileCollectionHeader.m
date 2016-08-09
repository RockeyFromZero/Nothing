//
//  ProfileCollectionHeader.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/8/9.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ProfileCollectionHeader.h"

@interface ProfileCollectionHeader ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation ProfileCollectionHeader
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *lable = [UILabel new];
        lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lable];
        _titleLabel = lable;
        [lable makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        
        [[RACObserve(self, title) ignore:@""] subscribeNext:^(id x) {
            _titleLabel.text = x;
        }];
    }
    return self;
}


@end
