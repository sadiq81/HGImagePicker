//
// Created by Privat on 19/03/15.
// Copyright (c) 2015 Eazy It. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HGImagePickerView : UIView

@property(nonatomic, strong, readonly) UICollectionView *pictures;
@property(nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong, readonly) UIButton *firstAction;
@property(nonatomic, strong, readonly) UIButton *secondAction;
@property(nonatomic, strong, readonly) UIButton *thirdAction;

@property(nonatomic) BOOL maxReached;

@property(nonatomic, strong) NSArray *selectedItems;

- (void)clearSelected;

@end