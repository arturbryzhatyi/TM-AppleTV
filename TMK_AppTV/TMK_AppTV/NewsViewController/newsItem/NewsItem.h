//
//  NewsItem.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSString *newsDescroption;
@property (nonatomic, strong) NSString *newsLink;
@property (nonatomic, strong) NSString *newsPubDate;
@property (nonatomic, strong) NSDate *datePub;
@property (nonatomic, strong) NSString *newsSource;
@property (nonatomic, strong) NSString *newsCategory;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithDict:(NSDictionary *)dict;

- (NSString *)formattedStringDate;
@end
