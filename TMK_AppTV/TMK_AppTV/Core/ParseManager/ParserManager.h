//
//  ParserManager.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/3/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IfStringValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSString class]] && !([p isEqualToString:@""]))

#define IfArrayValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSArray class]] && !([p count] == 0))

#define IfDictionaryValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSDictionary class]] && !([p count] == 0))

#define IfNumberValueNotNull(p) if (p != nil && p != [NSNull class] && [p isKindOfClass:[NSNumber class]])


@interface ParserManager : NSObject

+ (void)parseEventJSON:(NSDictionary *)dict success:(void(^)(id objects))success;

@end
