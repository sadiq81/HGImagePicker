//
//  HGViewController.h
//  HGImagePicker
//
//  Created by Tommy Sadiq Hinrichsen on 06/12/2015.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

@import UIKit;

#import <HGImagePicker/HGImagePickerController.h>

@class KASlideShow;


@interface HGViewController : UIViewController <HGImagePickerControllerDelegate>

@property(weak, nonatomic) IBOutlet KASlideShow *slideShow;

- (IBAction)pickImages:(id)sender;

@end
