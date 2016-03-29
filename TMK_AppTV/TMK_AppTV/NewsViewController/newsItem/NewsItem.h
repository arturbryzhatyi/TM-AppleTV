//
//  NewsItem.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSString *newsDescroption;
@property (nonatomic, strong) NSString *newsLink;
@property (nonatomic, strong) NSString *newsPubDate;
@property (nonatomic, strong) NSString *newsSource;
@property (nonatomic, strong) NSString *newsCategory;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
