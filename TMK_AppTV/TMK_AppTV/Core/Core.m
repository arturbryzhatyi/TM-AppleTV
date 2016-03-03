//
//  Core.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "Core.h"
#import "HTTPClient.h"


@interface Core()
@property (nonatomic, strong) HTTPClient *httpclient;
@end

@implementation Core

+ (instancetype)sharedInstance
{
    static Core *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[Core alloc] init];
    });
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.httpclient = [[HTTPClient alloc] initDefaultHttpClient];
    }
    return self;
}

#pragma mark - API
- (void)searchKey:(NSString *)keyword success:(void (^)(id object))successBlock
{
    [self.httpclient searchWithKeyword:keyword success:^(id responseObject) {
        
        if (successBlock)
        {
            successBlock(responseObject);
        }
        
    } failure:^(NSError *error) {
        
        if (successBlock)
        {
            successBlock(error);
        }
    }];
    
}
@end
