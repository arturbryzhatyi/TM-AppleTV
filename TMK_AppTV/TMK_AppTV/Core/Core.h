//
//  Core.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"

@interface Core : NSObject
@property (nonatomic, strong, readonly) DatabaseManager *databaseManager;

+ (instancetype)sharedInstance;

- (void)searchKey:(NSString *)keyword success:(void (^)(id object))successBlock;

- (void)downloadImage:(NSString *)stringURL success:(void (^)(id object))successBlock;

- (void)rssAtomSuccess:(void (^)(id object))successBlock;

@end
