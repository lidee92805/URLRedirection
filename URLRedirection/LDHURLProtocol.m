//
//  LDHURLProtocol.m
//  URLRedirection
//
//  Created by lidehua on 15/6/9.
//  Copyright (c) 2015年 李德华. All rights reserved.
//

#import "LDHURLProtocol.h"
@interface LDHURLProtocol()<NSURLConnectionDataDelegate>
@property (strong, nonatomic) NSURLConnection * connection;
@end
@implementation LDHURLProtocol
+(void)load {
    [NSURLProtocol registerClass:self];
}
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"%@",request.URL);
    if ([NSURLProtocol propertyForKey:@"LDHURLProtocolKey" inRequest:request]) {
        return NO;
    }
    return [[[NSUserDefaults standardUserDefaults] valueForKey:@"changeNetMode"] boolValue];
}
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    NSMutableURLRequest * mutableRequest = [request mutableCopy];
    NSURLComponents * URLComponents = [NSURLComponents componentsWithString:[[mutableRequest URL] absoluteString]];
    if ([URLComponents.host isEqualToString:@"www.baidu.com"]) {
        URLComponents.host = @"www.163.com";
    }
    
    [NSURLProtocol setProperty:@YES forKey:@"LDHURLProtocolKey" inRequest:mutableRequest];
    
    mutableRequest.URL = [URLComponents URL];
    
    return mutableRequest;
//    return request;
}
- (void)startLoading {    
//    _connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
        _connection = [NSURLConnection connectionWithRequest:[[self class] canonicalRequestForRequest:self.request] delegate:self];
}
- (void)stopLoading {
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.client URLProtocol:self didLoadData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.client URLProtocolDidFinishLoading:self];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.client URLProtocol:self didFailWithError:error];
}
@end
