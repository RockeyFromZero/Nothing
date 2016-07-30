//
//  DetailWebCell.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/15.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "DetailWebCell.h"


@interface DetailWebCell ()<UIWebViewDelegate>

@property (nonatomic, assign) CGFloat minHeight;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation DetailWebCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self setupUI];
        [self bindModel];
    }
    return self;
}

- (void)bindModel {
   
    [[RACObserve(self, artical) ignore:nil] subscribeNext:^(Artical *artical) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:artical.pageUrl]]];
    }];
}
- (void)setupUI {
  [self.webView makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(0);
  }];
}

#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = request.URL.absoluteString;
    NSArray *components = [urlStr componentsSeparatedByString:@"::"];
    if (components.count >= 1) {
        if ([components[0] isEqual:@"imageclick"]) {
            NSLog(@"image click, components is %@", components);
            return false;
        }
    }
    return true;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    /** 加载 js */
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image" withExtension:@"js"];
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:string];

    /** 给图片绑定点击事件 */
    [webView stringByEvaluatingJavaScriptFromString:@"setImageClick()"];

    /** 重定 Cell 高度 */
    
    if (webView.scrollView.contentSize.height > _minHeight) {
        
        _minHeight = webView.scrollView.contentSize.height;
        if (_delegate && [_delegate respondsToSelector:@selector(DetailWebCellGetHeight:)]) {
            [_delegate DetailWebCellGetHeight:webView.scrollView.contentSize.height];
        }
    }
}

#pragma lazy load
- (UIWebView *)webView {
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.scrollView.scrollEnabled = NO;
        webView.delegate = self;
        [self.contentView addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

@end
