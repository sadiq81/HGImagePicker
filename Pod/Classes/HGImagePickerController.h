//
// Created by Privat on 13/03/15.
// Copyright (c) 2015 Eazy It. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HGImagePickerController;

@protocol HGImagePickerControllerDelegate

- (void)HGImagePickerControllerDidCancel:(HGImagePickerController *)controller;

- (void)HGImagePickerControllerDidConfirm:(HGImagePickerController *)controller pictures:(NSArray *)pictures;

@end

@interface HGImagePickerController : UIViewController

@property(nonatomic, strong, readonly) id <HGImagePickerControllerDelegate> delegate;
@property(nonatomic) NSUInteger maximumPictures;

- (instancetype)initWithDelegate:(id <HGImagePickerControllerDelegate>)delegate;

+ (instancetype)controllerWithDelegate:(id <HGImagePickerControllerDelegate>)delegate;


@end