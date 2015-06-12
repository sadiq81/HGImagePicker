//
// Created by Privat on 21/03/15.
// Copyright (c) 2015 Eazy It. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "HGPictureCollectionViewCell.h"
#import "Masonry/Masonry.h"

@interface HGPictureCollectionViewCell ()
@property(strong, nonatomic) AsyncImageView *imageView;
@property(strong, nonatomic) UIImageView *status;
@end

@implementation HGPictureCollectionViewCell {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self setNeedsUpdateConstraints];
    }

    return self;
}

- (void)setupViews {
    self.imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.imageView];

    self.status = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.status.tintColor = [UIColor lightGrayColor];
    self.status.image = [UIImage imageNamed:@"HGPictureCollectionViewCell.Selected"];
    self.status.image = [self.status.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self addSubview:self.status];
}


- (void)updateConstraints {

    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.top.equalTo(self).offset(2);
        make.right.equalTo(self).offset(-2);
        make.bottom.equalTo(self).offset(-2);
    }];

    [self.status mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-2 - 5);
        make.right.equalTo(self).offset(-2 - 5);
        make.width.equalTo(@(22));
        make.height.equalTo(@(22));
    }];

    [super updateConstraints];
}

- (void)setChosen:(BOOL)chosen animated:(BOOL)animated {

    if (chosen) {
        self.status.image = [UIImage imageNamed:@"HGPictureCollectionViewCell.Selected"];
        self.status.image = [self.status.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    } else {
        self.status.image = nil;
    }
}

@end