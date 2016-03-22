//
//  HTTPClient.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HTTPClient : AFHTTPSessionManager

- (instancetype)initDefaultHttpClient;

- (void)searchWithKeyword:(NSString *)keyword success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)downlodImage:(NSString *)stringUrl success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
