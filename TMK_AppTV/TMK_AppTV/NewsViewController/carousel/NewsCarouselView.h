//
//  NewsCarouselView.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 4/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "CarouselView.h"

@interface NewsCarouselView : CarouselView

@end


@interface NewsCarouselItem : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
- (instancetype)initFromXibWithFrame:(CGRect)frame;
@end