//
//  HGViewController.m
//  HGImagePicker
//
//  Created by Tommy Sadiq Hinrichsen on 06/12/2015.
//  Copyright (c) 2014 Tommy Sadiq Hinrichsen. All rights reserved.
//

#import <ClusterPrePermissions/ClusterPrePermissions.h>
#import <HGImagePicker/HGImagePickerController.h>
#import "HGViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <KASlideShow/KASlideShow.h>

@interface HGViewController ()

@end

@implementation HGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickImages:(id)sender {
    
    ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
    @weakify(self)
    [permissions showPhotoPermissionsWithTitle:@"Allow access to images" message:@"The system would like to access your pictures" denyButtonTitle:@"Deny" grantButtonTitle:@"Grant" completionHandler:^(BOOL hasPermission, ClusterDialogResult userDialogResult, ClusterDialogResult systemDialogResult) {
        @strongify(self)
        if (hasPermission) {
            HGImagePickerController *imagePickerController = [HGImagePickerController controllerWithDelegate:self];
            imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
            imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:imagePickerController animated:true completion:nil];
        } else {
            UIAlertController *errorController = [UIAlertController alertControllerWithTitle:@"Access denied" message:@"User did not allow access to images" preferredStyle:UIAlertControllerStyleAlert];
            [errorController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:errorController animated:true completion:nil];
        }
    }];
    
    
}

- (void)HGImagePickerControllerDidConfirm:(HGImagePickerController *)controller pictures:(NSArray *)pictures {
    @weakify(self)
    [controller dismissViewControllerAnimated:true completion:^{
        @strongify(self)
        [self.slideShow setImages:[[NSMutableArray alloc] initWithArray:pictures]];
        [self.slideShow start];
    }];
}

- (void)HGImagePickerControllerDidCancel:(HGImagePickerController *)controller {
    @weakify(self)
    [controller dismissViewControllerAnimated:true completion:^{
        @strongify(self)
        UIAlertController *errorController = [UIAlertController alertControllerWithTitle:@"Cancelled" message:@"User cancelled image picking" preferredStyle:UIAlertControllerStyleAlert];
        [errorController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:errorController animated:true completion:nil];

    }];
}

@end
