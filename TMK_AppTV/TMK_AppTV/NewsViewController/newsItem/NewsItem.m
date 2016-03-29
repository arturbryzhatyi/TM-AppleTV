//
//  NewsItem.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "NewsItem.h"
#import "ParserManager.h"

@implementation NewsItem

- (instancetype)initWithDict:(NSDictionary *)dict
{
    IfDictionaryValueNotNull(dict)
    {
        self = [super init];
        if (self)
        {
            id value = dict[@"title"];
            IfStringValueNotNull(value)
            {
                self.newsTitle = value;
            }
            
            value = dict[@"link"];
            IfStringValueNotNull(value)
            {
                self.newsLink = value;
            }
            
            value = dict[@"source"];
            IfStringValueNotNull(value)
            {
                self.newsSource = value;
            }
            
            value = dict[@"description"];
            IfStringValueNotNull(value)
            {
                self.newsDescroption = value;
            }
            
            value = dict[@"category"];
            IfStringValueNotNull(value)
            {
                self.newsCategory = value;
            }
            
            value = dict[@"pubDate"];
            IfStringValueNotNull(value)
            {
                self.newsPubDate = value;
            }
        }
        return self;
    }
    
    return nil;
}

@end
