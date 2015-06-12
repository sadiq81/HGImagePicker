# HGImagePicker

[![Version](https://img.shields.io/cocoapods/v/HGImagePicker.svg?style=flat)](http://cocoapods.org/pods/HGImagePicker)
[![License](https://img.shields.io/cocoapods/l/HGImagePicker.svg?style=flat)](http://cocoapods.org/pods/HGImagePicker)
[![Platform](https://img.shields.io/cocoapods/p/HGImagePicker.svg?style=flat)](http://cocoapods.org/pods/HGImagePicker)

Ever wonted an image picker that allows you to easily add images from the Camera roll, Camera and Photo library
then you need not look any further.


HGImagepicker combines a list of recent pictures with CTAssetsPickerController and Apples UIImagePickerController
to mimic the same behaviour of the Messages app.

<img src="https://github.com/sadiq81/HGImagePicker/blob/master/Example/Screen1.png" alt="Initial Screen" style="width: 200px;"/>
<img src="https://github.com/sadiq81/HGImagePicker/blob/master/Example/Screen2.png" alt="Image source picker" style="width: 200px;"/>
<img src="https://github.com/sadiq81/HGImagePicker/blob/master/Example/Screen3.png" alt="Photo gallery using CTAssetsPickerController" style="width: 200px;"/>

## Usage

<h1>Display HGImagePickerController</h1>
```Objective-C
HGImagePickerController *imagePickerController = [HGImagePickerController controllerWithDelegate:self];
imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
[self presentViewController:imagePickerController animated:true completion:nil];
```

<h1>Delegate callback when the user confirms the choice of images</h1>
```Objective-C
- (void)HGImagePickerControllerDidConfirm:(HGImagePickerController *)controller pictures:(NSArray *)pictures {
   @weakify(self)
   [controller dismissViewControllerAnimated:true completion:^{
       @strongify(self)
       [self.slideShow setImages:[[NSMutableArray alloc] initWithArray:pictures]];
       [self.slideShow start];
   }];
}
```
<h1>Delegate callback when the user cancels</h1>
```Objective-C
- (void)HGImagePickerControllerDidCancel:(HGImagePickerController *)controller {
   @weakify(self)
   [controller dismissViewControllerAnimated:true completion:^{
       @strongify(self)
       UIAlertController *errorController = [UIAlertController alertControllerWithTitle:@"Cancelled" message:@"User cancelled image picking" preferredStyle:UIAlertControllerStyleAlert];
       [errorController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
       [self presentViewController:errorController animated:true completion:nil];

   }];
}
```

Thanks to the creators of AsyncImageView, CTAssetsPickerController, MSSPopMasonry, ALActionBlocks, LinqToObjectiveC, ReactiveCocoa

## Requirements

## Installation

HGImagePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HGImagePicker"
```

## Author

Tommy Sadiq Hinrichsen, tommy.lynge@gmail.com

## License

HGImagePicker is available under the MIT license. See the LICENSE file for more info.
