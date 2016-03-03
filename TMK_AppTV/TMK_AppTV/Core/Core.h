//
//  Core.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Core : NSObject

+ (instancetype)sharedInstance;

- (void)searchKey:(NSString *)keyword success:(void (^)(id object))successBlock;

@end
