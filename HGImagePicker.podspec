#
# Be sure to run `pod lib lint HGImagePicker.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HGImagePicker"
  s.version          = "1.0.0"
  s.summary          = "An image picker similar to Apples picker in the messages app."
  s.description      = <<-DESC
                       Ever wonted an image picker that allows you to easily add images from the Camera roll, Camera and Photo library
                       then you need not look any further.

                       HGImagepicker combines a list of recent pictures with CTAssetsPickerController and Apples UIImagePickerController
                       to mimic the same behaviour of the Messages app.

                       ![Initial Screen](https://github.com/sadiq81/HGImagePicker/Example/Screen1.png)
                       ![Image source picker](https://github.com/sadiq81/HGImagePicker/Example/Screen2.png)
                       ![Photo gallery using CTAssetsPickerController](https://github.com/sadiq81/HGImagePicker/Example/Screen3.png)

                       Example:

                       <h1>Display HGImagePickerController<h1>
                       ```Objective-C
                       HGImagePickerController *imagePickerController = [HGImagePickerController controllerWithDelegate:self];
                       imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
                       imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                       [self presentViewController:imagePickerController animated:true completion:nil];
                       ```

                       <h1>Delegate callback when the user confirms the choice of images<h1>
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
                       <h1>Delegate callback when the user cancels<h1>
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

                       DESC
  s.homepage         = "https://github.com/sadiq81/HGImagePicker"
  # s.screenshots     = "https://github.com/sadiq81/HGImagePicker/Example/Screen1.png", "https://github.com/sadiq81/HGImagePicker/Example/Screen2.png","https://github.com/sadiq81/HGImagePicker/Example/Screen3.png"
  s.license          = 'MIT'
  s.author           = { "Tommy Sadiq Hinrichsen" => "tommy.lynge@gmail.com" }
  s.source           = { :git => "https://github.com/sadiq81/HGImagePicker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sadiq81'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HGImagePicker' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'AssetsLibrary'
    s.dependency 'AsyncImageView', '~> 1.5.1'
    s.dependency 'CTAssetsPickerController', '~> 2.9.3'
    s.dependency 'pop', '~> 1.0'
    s.dependency 'MSSPopMasonry','~> 0.0.1'
    s.dependency 'ALActionBlocks', '~> 1.0.3'
    s.dependency 'LinqToObjectiveC', '~> 2.0.0'
    s.dependency 'ReactiveCocoa', '~> 2.4.7'

end
