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

There are some string localization resources and some image resources you need to have in your project

Example of english string localization:
"HGImagePickerView.button.approve" = "Add 1 picture";
"HGImagePickerView.button.approve.multiple" = "Add %lu pictures";
"HGImagePickerView.button.photoLibrary" = "Photo library";
"HGImagePickerView.button.takePicture" = "Take picture";
"HGImagePickerView.button.cancel" = "Regret";

"HGImagePickerController.button.confirm" = "Approve";
"HGImagePickerController.button.cancel" = "Regret";
"HGImagePickerController.label.no.pictures" = "You have not added any pictures, press the camera to add pictures";
"HGImagePickerController.label.max.pictures" = "You can choose a maximum of %i picture(s)";

List of image resources:
HGImagePickerController.UIBarButtonImage.Camera
HGImagePickerController.UIBarButtonImage.Trash
HGPictureCollectionViewCell.Selected

See the example project for image examples, note that the images included in the sample is Copyright protected so you need to find you own images.

<h3>Display HGImagePickerController</h3>
```Objective-C
HGImagePickerController *imagePickerController = [HGImagePickerController controllerWithDelegate:self];
imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
[self presentViewController:imagePickerController animated:true completion:nil];
```

<h3>Delegate callback when the user confirms the choice of images</h3>
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
<h3>Delegate callback when the user cancels</h3>
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
