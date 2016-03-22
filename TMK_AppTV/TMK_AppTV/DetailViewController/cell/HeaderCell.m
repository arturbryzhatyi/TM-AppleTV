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
    
    [self.posterImageView setImageWithURL:[event imageURL]];
    [self.titleLabel setText:event.name];
    
    NSInteger count = arc4random() % 100000 + 23;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.subTitleLabel setText:[NSString stringWithFormat:@"❤️%@  Category: %@  Genre: %@",
                                 [formatter stringFromNumber:[NSNumber numberWithInteger:count]],
                                 event.segment.name,
                                 [event genre]]];
    
    [self setEventLocation:event.venue];
}

- (void)setEventLocation:(Venue *)loc
{
    NSParameterAssert(loc);
    
    NSString *locationString = [NSString stringWithFormat:@"City: %@\n\nState: %@\n\nCountry: %@", loc.cityName, loc.stateName, loc.countryName];
    
    [self.leftHeaderLabel setText:locationString];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
