//
//  TitleBtn.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/27.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "TitleBtn.h"

@interface TitleBtn ()

@end

@implementation TitleBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"hp_arrow_down"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self sizeToFit];
        
        [self bingModel];
        [self clickAction];
    }
    return self;
}

- (void)clickAction {
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.selected = !self.selected;
    }];
}

- (void)bingModel {
    
    [RACObserve(self, topTitle) subscribeNext:^(id x) {
        [self setTitle:x forState:UIControlStateNormal];
    }];
    
    [RACObserve(self, selected) subscribeNext:^(id x) {
        NSString *imgName = [x isEqual:@1]?@"hp_arrow_up":@"hp_arrow_down";
        [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectGetMinX(self.imageView.frame) <= CGRectGetMinX(self.titleLabel.frame)) {
        
        CGRect titleFrame = self.titleLabel.frame, imgViewFrame = self.imageView.frame;
        
        titleFrame.origin.x = imgViewFrame.origin.x;
        self.titleLabel.frame = titleFrame;
        
        imgViewFrame.origin.x = CGRectGetMaxX(titleFrame)+10;
        self.imageView.frame = imgViewFrame;
    }
    
}

@end
