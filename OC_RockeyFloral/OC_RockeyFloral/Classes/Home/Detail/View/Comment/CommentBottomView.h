//
//  CommentBottomView.h
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/19.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentBottomView;

@protocol CommentBottomDelegate <NSObject>

@required
/** 键盘变化 */
- (void)CommentBottomDelegate:(CommentBottomView *)bottomView 
     keyboardFrameWillChange:(NSDictionary *)userInfo;
/** 发送 */
- (void)CommentBottomDelegate:(CommentBottomView *)bottomView send:(id)sendInfo;

@end

@interface CommentBottomView : UIView

@property (nonatomic, weak) id<CommentBottomDelegate> delegate;

- (void)endEditing;

@end
