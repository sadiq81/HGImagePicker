//
// Created by Privat on 19/03/15.
// Copyright (c) 2015 Eazy It. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

#import "HGImagePickerView.h"
#import "Photos/Photos.h"
#import "HGPictureCollectionViewCell.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "HGImagePickerButton.h"

@interface HGImagePickerView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *pictures;
@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property(nonatomic, strong) UIButton *firstAction;
@property(nonatomic, strong) UIButton *secondAction;
@property(nonatomic, strong) UIButton *thirdAction;

@property(strong) PHCachingImageManager *imageManager;
@property(strong) PHFetchResult *assetsFetchResult;
@end

@implementation HGImagePickerView {
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self setupViews];
        [self setupCollectionView];

    }

    return self;
}

- (void)setupViews {

    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumInteritemSpacing = 0.0f;
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

    self.pictures = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    [self addSubview:self.pictures];

    self.firstAction = [[HGImagePickerButton alloc] initWithTitle:NSLocalizedString(@"HGImagePickerView.button.photoLibrary", nil)];
    [self addSubview:self.firstAction];

    self.secondAction = [[HGImagePickerButton alloc] initWithTitle:NSLocalizedString(@"HGImagePickerView.button.takePicture", nil)];
    [self addSubview:self.secondAction];

    self.thirdAction = [[HGImagePickerButton alloc] initWithTitle:NSLocalizedString(@"HGImagePickerView.button.cancel", nil)];
    [self addSubview:self.thirdAction];

}

- (void)setupCollectionView {

    [self.pictures registerClass:[HGPictureCollectionViewCell class] forCellWithReuseIdentifier:@"HGPictureCollectionViewCell"];
    self.pictures.delegate = self;
    self.pictures.dataSource = self;
    self.pictures.allowsMultipleSelection = true;

    self.pictures.backgroundColor = [UIColor whiteColor];
    self.pictures.bounces = YES;
    [self.pictures setShowsHorizontalScrollIndicator:NO];
    [self.pictures setShowsVerticalScrollIndicator:NO];

    self.imageManager = (PHCachingImageManager *) [PHCachingImageManager defaultManager];

    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.assetsFetchResult= [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:fetchOptions];

    @weakify(self)
    [[RACObserve(self, selectedItems) ignore:nil] subscribeNext:^(NSArray *selectedItems) {
        @strongify(self)

        NSString *title = @"";
        if ([selectedItems count] == 1) {
            title = NSLocalizedString(@"HGImagePickerView.button.approve", nil);
            self.secondAction.enabled = false;
        } else if ([selectedItems count] > 1) {
            title = [NSString stringWithFormat:NSLocalizedString(@"HGImagePickerView.button.approve.multiple", nil), [selectedItems count]];
            self.secondAction.enabled = false;
        } else {
            title = NSLocalizedString(@"HGImagePickerView.button.photoLibrary", nil);
            self.secondAction.enabled = true;
        }
        [self.firstAction setTitle:title forState:UIControlStateNormal];

    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetsFetchResult.count > 20 ? 20 : self.assetsFetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HGPictureCollectionViewCell *cell = [self.pictures dequeueReusableCellWithReuseIdentifier:@"HGPictureCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.image = [self imageForIndexPath:indexPath];
    [cell setChosen:cell.isSelected animated:false];
    return cell;
}

- (void)clearSelected {
    for (NSIndexPath *indexPath in [self.pictures indexPathsForSelectedItems]) {
        [self.pictures deselectItemAtIndexPath:indexPath animated:NO];
    }
    for (NSIndexPath *indexPath in [self.pictures indexPathsForVisibleItems]) {
        HGPictureCollectionViewCell *cell = (HGPictureCollectionViewCell *) [self.pictures cellForItemAtIndexPath:indexPath];
        [cell setChosen:false animated:false];
    }

    self.selectedItems = [NSArray new];
}

- (UIImage *)imageForIndexPath:(NSIndexPath *)path {

    __block UIImage *image;
    PHAsset *asset = self.assetsFetchResult[path.item];
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.synchronous = YES;
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage *result, NSDictionary *info) {
        image = result;
    }];

    return image;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    UIImage *image = [self imageForIndexPath:indexPath];
    float widthToHeightRatio = image.size.width / image.size.height;
    float width = 100 * widthToHeightRatio;
    return CGSizeMake(width, 100);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (!self.maxReached) {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
        HGPictureCollectionViewCell *cell = (HGPictureCollectionViewCell *) [self.pictures cellForItemAtIndexPath:indexPath];
        [cell setChosen:true animated:true];

        self.selectedItems = [[collectionView indexPathsForSelectedItems] linq_select:^id(NSIndexPath *indexPath) {
            return [self imageForIndexPath:indexPath];
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    HGPictureCollectionViewCell *cell = (HGPictureCollectionViewCell *) [self.pictures cellForItemAtIndexPath:indexPath];
    [cell setChosen:false animated:true];

    self.selectedItems = [[collectionView indexPathsForSelectedItems] linq_select:^id(NSIndexPath *indexPath) {
        return [self imageForIndexPath:indexPath];
    }];
}


- (void)updateConstraints {

    [self.pictures mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
        make.height.equalTo(@100);
    }];

    [self.firstAction mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictures.mas_bottom).offset(4);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
        make.height.equalTo(@44);
    }];

    [self.secondAction mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstAction.mas_bottom).offset(4);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
        make.height.equalTo(@44);
    }];

    [self.thirdAction mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondAction.mas_bottom).offset(4);
        make.left.equalTo(self).offset(4);
        make.right.equalTo(self).offset(-4);
        make.height.equalTo(@44);
        make.bottom.equalTo(self).offset(-4);
    }];

    [super updateConstraints];
}


@end