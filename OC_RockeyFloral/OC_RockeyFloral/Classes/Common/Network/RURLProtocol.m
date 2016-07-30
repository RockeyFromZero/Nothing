//
//  RURLProtocol.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/7/1.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "RURLProtocol.h"


static NSString *const kURLProtocolCategory = @"kURLProtocolCategory";

@interface RURLProtocol () <NSURLSessionDataDelegate, NSURLSessionDelegate>

@property (nonatomic, strong) NSURLRequest *currentRequest;

@end

@implementation RURLProtocol

/** 需要处理 的请求 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return NO;
    
    if ([request.URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame ||
        [request.URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
        
        if ([request.URL.path containsString:@"servlet/SysCategoryServlet"]) {
            
            /** 防止重复请求 */
            if (![NSURLProtocol propertyForKey:kURLProtocolCategory inRequest:request]) {
                return YES;
            }
        }
        
    }
    
    return NO;
}

/** 主要判断两个request是否相同，如果相同的话可以使用缓存数据，通常只需要调用父类的实现 */
//+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
//{
//    return [super requestIsCacheEquivalent:a toRequest:b];
//}
/** 实现对 request 的修改 */
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

/** 请求 开始 ，需要对 进行的请求进行 标识 */
- (void)startLoading
{
    [NSURLProtocol setProperty:@YES forKey:kURLProtocolCategory inRequest:self.request];
//    BOOL bo = [NSURLProtocol propertyForKey:kURLProtocolCategory inRequest:self.request];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://m.htxq.net/servlet/SysCategoryServlet?action=getList"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }];
    [task resume];
}
/** 取消标识 */
- (void)stopLoading
{
//    [NSURLProtocol removePropertyForKey:kURLProtocolCategory inRequest:[self.request mutableCopy]];
}


@end
