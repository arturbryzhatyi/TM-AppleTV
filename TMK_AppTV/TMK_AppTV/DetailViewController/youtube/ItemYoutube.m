//
//  ItemYoutube.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/24/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ItemYoutube.h"
#import "ParserManager.h"

@implementation ItemYoutube

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    NSParameterAssert(dict);
    if (dict == nil || [dict count] == 0)
        return nil;
    
    self = [super init];
    if (self)
    {
        id value = [dict valueForKeyPath:@"id.videoId"];
        IfStringValueNotNull(value)
        {
            _videoID = value;
        }
        
        value = [dict valueForKeyPath:@"etag"];
        IfStringValueNotNull(value)
        {
            _videoEtag = value;
        }
        
        value = [dict valueForKeyPath:@"snippet.description"];
        IfStringValueNotNull(value)
        {
            _videoDescription = value;
        }
        
        value = [dict valueForKeyPath:@"snippet.liveBroadcastContent"];
        IfNumberValueNotNull(value)
        {
            _live = [(NSNumber *)value boolValue];
        }
        
        value = [dict valueForKeyPath:@"snippet.thumbnails.high.url"];
        IfNumberValueNotNull(value)
        {
            _videoThumbURL = value;
        }
        else
        {
            value = [dict valueForKeyPath:@"snippet.thumbnails.default.url"];
            IfStringValueNotNull(value)
            {
                _videoThumbURL = value;
            }
        }
        
        value = [dict valueForKeyPath:@"snippet.title"];
        IfNumberValueNotNull(value)
        {
            _videoTitle = value;
        }
    }
    return self;
}

@end
