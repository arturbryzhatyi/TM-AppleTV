//
//  HTTPClient.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "HTTPClient.h"
//#import <AFNetworkActivityIndicatorManager.h>

NSString * const devKey = @"7elxdku9GGG5k8j0Xm8KWdANDgecHMV0";
//NSString * const apiVersion = @"v2";
NSString * const baseURL = @"https://app.ticketmaster.com/discovery/v2";

@implementation HTTPClient

- (instancetype)initDefaultHttpClient
{
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    return [super initWithBaseURL:[NSURL URLWithString:baseURL] sessionConfiguration:conf];
}

#pragma mark - Search API
- (void)searchWithKeyword:(NSString *)keyword success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSDictionary *param = @{@"keyword": keyword,
                            @"size": @10,
                            @"apikey": devKey};
    
    [self GET:@"events.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"URL: %@", task.response.URL);
//        NSLog(@"Success: %@", responseObject);
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

@end