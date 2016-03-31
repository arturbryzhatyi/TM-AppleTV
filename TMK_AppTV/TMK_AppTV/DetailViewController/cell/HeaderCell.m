//
//  HeaderCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/21/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "HeaderCell.h"
#import <UIImageView+AFNetworking.h>
#import "Segment.h"
#import "Genre.h"
#import "Core.h"

@interface HeaderCell()

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIStackView *buttonsView;
@property (weak, nonatomic) IBOutlet UILabel *leftHeaderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@property (nonatomic, weak) IBOutlet UIButton *liveButton;

@end

@implementation HeaderCell

+ (CGFloat)defHeight
{
    return 450;
}

- (UIView *)preferredFocusedView
{
    return self.buttonsView;
}

- (BOOL)canBecomeFocused
{
    return NO;
}

- (void)setEventWithID:(NSString *)eventID
{
    NSParameterAssert(eventID);
    Event *event = nil;
    
    NSSet *fetchObject = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", eventID]];
    if ([fetchObject count] == 1)
    {
         event = (Event *)[fetchObject anyObject];
    }
    
    NSParameterAssert(event);
    
    [self.liveButton setHidden:![[event.segment.name lowercaseString] isEqualToString:@"music"]];
    
    [self.posterImageView setImageWithURL:[event imageURL]];
    [self.titleLabel setText:event.name];
    
    if ([CoreDataManager isZZTOP:event.name])
    {
        [self.descriptionLabel setText:@"ZZ Top is an American rock band that formed in 1969 in Houston, Texas. The band comprises guitarist and lead vocalist Billy Gibbons (the band's leader, main lyricist, and musical arranger), bassist and co-lead vocalist Dusty Hill, and drummer Frank Beard."];
    }
    else if ([event.descript length] > 0)
    {
        [self.descriptionLabel setText:event.descript];
    }
    
    NSInteger count = arc4random() % 100000 + 23;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.subTitleLabel setText:[NSString stringWithFormat:@"❤️ %@  %@  %@  2h 30m",
                                 [formatter stringFromNumber:[NSNumber numberWithInteger:count]],
                                 (event.segment.name.length > 0) ? event.segment.name : @"",
                                 (event.genre.length > 0) ? event.genre : @""]];
    
    [self setEventLocation:event.venue andDate:event.localDateTime];
//    [self loadQRWithURL:event.eventURL];
}

- (void)setEventLocation:(Venue *)loc andDate:(NSDate *)date
{
    NSParameterAssert(loc);
    
//    NSString *locationString = [NSString stringWithFormat:@"City:\n%@\nState:\n%@\nCountry:\n%@\nVenue name:\n%@", loc.cityName, loc.stateName, loc.countryName, loc.name];
    
    NSMutableAttributedString *attString = [self.leftHeaderLabel.attributedText mutableCopy];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    
    [attString replaceCharactersInRange:NSMakeRange(24, 3) withString:[formatter stringFromDate:date]];
    [attString replaceCharactersInRange:NSMakeRange(19, 3) withString:loc.name];
    [attString replaceCharactersInRange:NSMakeRange(8, 3) withString:[NSString stringWithFormat:@"%@\n%@\n%@",
                                                                      loc.cityName,
                                                                      loc.stateName,
                                                                      loc.countryName]];
    
    [self.leftHeaderLabel setAttributedText:attString];
}

- (void)loadQRWithURL:(NSString *)url
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSString *stringUrl = [url copy];
        
        stringUrl = [NSString stringWithFormat:@"https://api.qrserver.com/v1/create-qr-code/?data=%@&size=200x200", stringUrl];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringUrl]];
        
        if (data)
        {
            dispatch_async(dispatch_get_main_queue(), ^{

                UIImage *img = [UIImage imageWithData:data];
                [self.qrCodeImageView setImage:img];
            });
        }
    });
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
