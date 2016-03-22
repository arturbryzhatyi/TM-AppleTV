//
//  CarouselView.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView

- (void)setObjects:(NSArray *)objects;

- (void)resumeCarousel;
- (void)stopCarousel;

@end

@interface CarouselItem : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end