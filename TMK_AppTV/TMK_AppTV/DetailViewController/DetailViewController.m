//
//  DetailViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "DetailViewController.h"
#import "Core.h"
#import "HeaderCell.h"
#import "FlickerCell.h"
#import "DescriptionCell.h"
#import <UIImageView+AFNetworking.h>

typedef NS_ENUM(NSUInteger, DetailEnumCell) {
    
    DetailHeaderCell,
//    DetailDescriprionCell,
    DetailFlickerCell,
//    DateilYoutubeCell,
    Detail_COUNT
};


@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UIImageView *backgrounImageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSParameterAssert(self.eventID);
    
    Event *event = nil;
    NSSet *fetchObject = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", self.eventID]];
    if ([fetchObject count] == 1)
    {
        event = (Event *)[fetchObject anyObject];
        
        [self.backgrounImageView setImageWithURL:[event imageURL]];
    }
}

- (UIView *)preferredFocusedView
{
    return self.tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Detail_COUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return [HeaderCell defHeight];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    UITableViewCell *cell = nil;
    
    switch (indexPath.row)
    {
        case DetailHeaderCell:
        {
            identifier = @"headerCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [(HeaderCell *)cell setEventWithID:self.eventID];
        }
            break;
/*        
        case DetailDescriprionCell:
        {
            identifier = @"descriptionCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.backgroundColor = [UIColor lightGrayColor];
        }
            break;
*/
        case DetailFlickerCell:
        {
            identifier = @"flickerCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [(FlickerCell *)cell setEventWithID:self.eventID];
        }
            break;
        default:
            abort();
            break;
    }
    
    return cell;
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
