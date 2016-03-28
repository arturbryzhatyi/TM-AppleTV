//
//  ITunesCell.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/22/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "TableViewCell.h"

@interface ITunesCell : TableViewCell

+ (CGFloat)defHeight;

- (void)setITunesTerm:(NSString *)value;

@end


@interface ItemITunes : NSObject
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *thumbURL;
@property (nonatomic, strong, readonly) NSString *previewAudioURL;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end