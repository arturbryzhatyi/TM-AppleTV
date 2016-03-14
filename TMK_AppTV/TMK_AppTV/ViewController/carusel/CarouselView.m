//
//  CaruselView.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "CarouselView.h"
#import "UIView+Constraint.h"
#import <UIImageView+AFNetworking.h>
#import "Event.h"

#define kItemWidth 850.f
#define kTime4Scroll 3

@interface CarouselView ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (assign, getter=isRealod) BOOL reload;
@end

@implementation CarouselView

- (void)setObjects:(NSArray *)objects
{
    if ([objects count] == 0)
        return;
    
    self.reload = YES;

    if ([objects count] > 20)
        objects = [objects subarrayWithRange:NSMakeRange(0, 20)];
    
    CGFloat x = 0;

    NSArray *subViews = self.scrollView.subviews;
    for (UIView *view in subViews)
    {
        [view removeFromSuperview];
    }
    
    [self.scrollView setContentSize:CGSizeZero];
    
    for (id obj in objects)
    {
        if ([obj isKindOfClass:[Event class]])
        {
            Event *event = obj;
            
            CarouselItem *item = [[CarouselItem alloc] initWithFrame:CGRectMake(x, 0, kItemWidth, 350)];
            [item.titleLabel setText:event.name];
            [item.imageView setImageWithURL:event.imageURL];
            [self.scrollView addSubview:item];
            
            CGFloat pointY = self.scrollView.center.y;
            
            [item setCenter:CGPointMake(item.center.x, pointY)];
            
            x += item.bounds.size.width + 20;
        }
    }
    
    [self.scrollView setContentSize:CGSizeMake(x, 1)];
    self.reload = NO;
    [self startTimerScroll];
}

- (void)startTimerScroll
{
    if ([self isRealod])
    {
        return;
    }
    
    CGFloat s = self.scrollView.contentOffset.x;
    if (s >= self.scrollView.contentSize.width - (kItemWidth*3))
    {
        s = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(s + kItemWidth + 20, 0) animated:YES];
    
    [self performSelector:@selector(startTimerScroll) withObject:nil afterDelay:kTime4Scroll];
}

@end


@implementation CarouselItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.f;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setClipsToBounds:YES];
        [self addSubview:_imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setBackgroundColor:[UIColor colorWithRed:0.396 green:0.396 blue:0.396 alpha:.6f]];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
        [self addSubview:_titleLabel];
        
        [self.imageView addConstraintFill];
        [self.titleLabel addConstraintFromLeft:0 toRight:0];
        [self.titleLabel addConstraintFromBottom:0];
        [self.titleLabel addConstraintHeight:40];
    }
    return self;
}

@end
