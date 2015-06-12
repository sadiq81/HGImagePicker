//
// Created by Privat on 21/03/15.
// Copyright (c) 2015 Eazy It. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AsyncImageView/AsyncImageView.h>


@interface HGPictureCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic, readonly) AsyncImageView *imageView;
@property(strong, nonatomic, readonly) UIImageView *status;

-(void) setChosen:(BOOL) chosen animated:(BOOL) animated;

@end