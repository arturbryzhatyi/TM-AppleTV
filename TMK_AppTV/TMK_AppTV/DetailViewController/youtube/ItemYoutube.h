//
//  ItemYoutube.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/24/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemYoutube : NSObject
@property (nonatomic, strong, readonly) NSString *videoID;
@property (nonatomic, strong, readonly) NSString *videoEtag;
@property (nonatomic, strong, readonly) NSString *videoTitle;
@property (nonatomic, strong, readonly) NSString *videoDescription;
@property (nonatomic, strong, readonly) NSString *videoThumbURL;
@property (nonatomic, assign, readonly, getter=isLive) BOOL live;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
