//
//  PhotoCollectionViewCell.h
//  FBSDKDemo
//
//  Created by Ravin Kohli on 06/04/16.
//  Copyright © 2016 Ravin Kohli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel* label;
@property (nonatomic) NSArray *photos;
@property (nonatomic) UIImageView *imageView;


@end
