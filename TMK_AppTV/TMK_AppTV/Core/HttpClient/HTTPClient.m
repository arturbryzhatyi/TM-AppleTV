//
//  HTTPClient.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "HTTPClient.h"
#import <AFImageDownloader.h>
//#import <AFNetworkActivityIndicatorManager.h>

NSString * const devKey = @"7elxdku9GGG5k8j0Xm8KWdANDgecHMV0";
//NSString * const apiVersion = @"v2";
NSString * const baseURL = @"https://app.ticketmaster.com/discovery/v2";

NSString * const postalCode = @"90069";

NSString * const latlong = @"34.061128,-118.312686";
NSString * const radius = @"10000";

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
                            @"size": @100,
                            @"apikey": devKey,
//                            @"postalCode": postalCode
                            @"latlong": latlong,
                            @"radius": radius
                            };
    
    [self GET:@"events.json" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"URL: %@", task.response.URL);
//        NSLog(@"Success: %@", responseObject);
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

- (void)downlodImage:(NSString *)stringUrl success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    AFImageDownloader *imgDownloader = [AFImageDownloader defaultInstance];
    
    if (imgDownloader.sessionManager == nil)
    {
        [imgDownloader setSessionManager:self];
    }
//    [imgDownloader setDownloadPrioritizaton:AFImageDownloadPrioritizationLIFO];
    
    [imgDownloader downloadImageForURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:stringUrl]] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        
       if (success)
       {
           success(responseObject);
       }
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
        NSLog(@"ERROR: %@", error.localizedDescription);
        if (failure)
        {
            failure(error);
        }
    }];
}

@end