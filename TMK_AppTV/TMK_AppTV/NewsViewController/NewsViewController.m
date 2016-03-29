//
//  NewsViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "NewsViewController.h"
#import "Core.h"
#import "NewsItem.h"
#import "NewsViewCell.h"

@interface NewsViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *romashka;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@implementation NewsViewController

- (void)loadView
{
    [super loadView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [[Core sharedInstance] rssAtomSuccess:^(id object) {
            
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *dict in object)
            {
                NewsItem *item = [[NewsItem alloc] initWithDict:dict];
                if (item)
                {
                    [mArray addObject:item];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([mArray count] > 0)
                {
                        self.objects = [NSArray arrayWithArray:mArray];
                        // reload UI
                        [self.collectionView reloadData];
                }
                
                [self.romashka stopAnimating];
            });
        }];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Collection View datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.objects count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCell" forIndexPath:indexPath];
    
    [self configureCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(NewsViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NewsItem *n = self.objects[indexPath.row];
    
    [cell.titleLabel setText:n.newsTitle];
//    [cell.descriptionLabel setText:n.newsDescroption];
    [cell.dateLabel setText:n.newsPubDate];
    [cell.sourceLabel setText:n.newsSource];
    
    NSError *err = nil;
    NSMutableAttributedString *mAttStr =
    [[NSMutableAttributedString alloc] initWithData:[n.newsDescroption dataUsingEncoding:NSUTF8StringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:&err];
    
    NSLog(@"%@", mAttStr);
//    [cell.descriptionLabel setAttributedText:mAttStr];
    
    [cell.descriptionLabel setText:mAttStr.string];
    
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"MM/dd/yyyy"];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width / 2) - 105;
    CGFloat height = [UIScreen mainScreen].bounds.size.height / 3;
    return CGSizeMake(width, height);
}

@end
