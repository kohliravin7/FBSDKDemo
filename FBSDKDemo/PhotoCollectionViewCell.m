//
//  PhotoCollectionViewCell.m
//  FBSDKDemo
//
//  Created by Ravin Kohli on 06/04/16.
//  Copyright © 2016 Ravin Kohli. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 20.0, frame.size.width, frame.size.height-20)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont boldSystemFontOfSize:35.0];
        self.label.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.label];;
    }
    return self;
}

- (void) setPhotos:(NSArray *)photos{
    
}
@end
