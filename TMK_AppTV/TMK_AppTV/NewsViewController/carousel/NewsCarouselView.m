//
//  NewsCarouselView.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 4/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "NewsCarouselView.h"
#import "NewsItem.h"

#define kScreenItemsCount   1
#define kSpaseBetweenItem   20
#define kScreenItemX        50

@class NewsCarouselItem;

@interface CarouselView ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) NSTimer *timer;
@end


@interface NewsCarouselView ()
@property (nonatomic, strong) NSMutableArray *objArray;
@end

@implementation NewsCarouselView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.objArray = [NSMutableArray new];
    
    self.itemWidth = ([UIScreen mainScreen].bounds.size.width / kScreenItemsCount) - kSpaseBetweenItem * 5;
    self.itemHeight = self.scrollView.bounds.size.height;
}

- (void)setObjects:(NSArray *)objects
{
    for (NewsItem *item in objects)
    {
        [self searchImageForItem:item];
    }
}


- (void)searchImageForItem:(NewsItem *)item
{
    NSError *err = nil;
    NSMutableAttributedString *mAttStr =
    [[NSMutableAttributedString alloc] initWithData:[item.newsDescroption dataUsingEncoding:NSUTF8StringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:&err];
    __block NewsItem *bItem = item;
    [mAttStr enumerateAttribute:NSAttachmentAttributeName
                        inRange:NSMakeRange(0, mAttStr.length)
                        options:0
                     usingBlock:^(id value, NSRange range, BOOL *stop)
     {
         NSTextAttachment* attachment = (NSTextAttachment*)value;
         NSFileWrapper* attachmentWrapper = attachment.fileWrapper;
         
         UIImage *img = [UIImage imageWithData:attachmentWrapper.regularFileContents];
         
         if (img)
         {
             [bItem setImage:img];
             [self addItemWithImage:bItem];
         }
         
         (*stop) = YES;
     }];
}

- (void)addItemWithImage:(NewsItem *)item
{
    [self.objArray addObject:item];
    
    NSArray *subViews = self.scrollView.subviews;
    for (UIView *view in subViews)
    {
        [view removeFromSuperview];
    }
    
    [self.scrollView setContentSize:CGSizeZero];
    
    CGFloat x = kScreenItemX;
    
    for (NewsItem *obj in self.objArray)
    {
        if ([obj isKindOfClass:[NewsItem class]])
        {
            NewsCarouselItem *item = [[NewsCarouselItem alloc] initFromXibWithFrame:CGRectMake(x, 0, self.itemWidth, self.itemHeight)];
            [item.titleLabel setText:[obj.newsTitle uppercaseString]];
            [item.imageView setImage:obj.image];
            [item.dateTimeLabel setText:[obj formattedStringDate]];
            
            [self.scrollView addSubview:item];
            
            CGFloat pointY = self.scrollView.center.y;
            
            [item setCenter:CGPointMake(item.center.x, pointY)];
            
            x += item.bounds.size.width + kSpaseBetweenItem;
        }
    }
    
    [self.scrollView setContentSize:CGSizeMake(x, 1)];
    [self resumeCarousel];
}

- (void)startTimerScroll
{
    CGFloat s = self.scrollView.contentOffset.x;
    if (s >= self.scrollView.contentSize.width - (self.itemWidth * 4))
    {
        s = 0;
        [self.scrollView setContentOffset:CGPointMake(s + self.itemWidth + kSpaseBetweenItem, 0) animated:NO];
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(s + self.itemWidth + kSpaseBetweenItem , 0) animated:YES];
    }
}

@end

@implementation NewsCarouselItem

- (instancetype)initFromXibWithFrame:(CGRect)frame
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"NewsCarouselItem" owner:self options:nil] firstObject];
    if (self)
    {
        [self setFrame:frame];
        self.layer.cornerRadius = 8.f;
    }
    return self;
}

@end
