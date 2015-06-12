//
// Created by Privat on 26/03/15.
// Copyright (c) 2015 Eazy It. All rights reserved.
//

#import "HGImagePickerButton.h"


@implementation HGImagePickerButton {

}

- (instancetype)initWithTitle:(NSString *)title {
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        [self setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:0.5] forState: UIControlStateHighlighted];
        [self setTitleColor:[UIColor lightGrayColor] forState: UIControlStateDisabled];
        [self setTitle:title forState:UIControlStateNormal];

        self.backgroundColor = [UIColor whiteColor];


    }
    return self;
}


@end