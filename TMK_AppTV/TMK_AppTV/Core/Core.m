//
//  Core.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "Core.h"
#import "HTTPClient.h"
#import <AFImageDownloader.h>
#import "ParserManager.h"


@interface Core()
@property (nonatomic, strong) HTTPClient *httpclient;
@property (nonatomic, strong) ParserManager *parserManager;
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
        self.parserManager = [[ParserManager alloc] init];
        _databaseManager = [[DatabaseManager alloc] init];
        
    }
    return self;
}

#pragma mark - API
- (void)searchKey:(NSString *)keyword success:(void (^)(id object))successBlock
{
    [self.httpclient searchWithKeyword:keyword success:^(id responseObject) {
        
        [self.parserManager parseEventJSON:responseObject success:^(id objects) {
            
            if (successBlock)
            {
                successBlock(objects);
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

                [self.databaseManager removeOldEvents];
            });
            
        }];
        
    } failure:^(NSError *error) {
        
        if (successBlock)
        {
            successBlock(error);
        }
    }];
}

- (void)downloadImage:(NSString *)stringURL success:(void (^)(id object))successBlock
{
    [self.httpclient downlodImage:stringURL success:^(id responseObject) {
        
        if (successBlock)
        {
            successBlock(responseObject);
        }
        
    } failure:^(NSError *error) {
        if (successBlock)
        {
            successBlock(nil);
        }
    }];
}
@end
