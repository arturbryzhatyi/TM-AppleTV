//
//  DetailViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "DetailViewController.h"
#import "Core.h"
#import <UIImageView+AFNetworking.h>

@interface DetailViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *backgrounImageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *decsriptionLabel;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureController];
}

- (void)configureController
{
    if ([self.eventID length] > 0)
    {
        NSSet *fetchObject = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", self.eventID]];
        if ([fetchObject count] == 1)
        {
            Event *event = (Event *)[fetchObject anyObject];
            [self.titleLabel setText:event.name];
            [self.imageView setImageWithURL:[event imageURL]];
            [self.backgrounImageView setImage:self.imageView.image];
        }
        else
        {
            NSLog(@"Event not alone!");
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
