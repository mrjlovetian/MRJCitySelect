//
//  MRJViewController.m
//  MRJCitySelect
//
//  Created by mrjlovetian@gmail.com on 03/02/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJViewController.h"
#import "CitySelectViewController.h"

@interface MRJViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MRJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)click {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
    return;
//    CitySelectViewController *vc = [[CitySelectViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
//    vc.cityBlock = ^(CityModelManger *city) {
//        NSLog(@"-=-=-=-=-%@", city.regionName);
//    };
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    UIImage *image = [info objectForKey:_isEdit?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage];
//    if (image) {
//        [picker dismissViewControllerAnimated:YES completion:^{
//            UIImage *newImage = [self imageWithImage:image];
//            if (self.type == CameraToolDefault) {
//                if (self.CompleteChooseCallback) {
//                    self.CompleteChooseCallback(newImage);
//                }
//            }
//            else if (self.type == CameraToolCustomize) {
//                if (self.photosCompleteChooseCallback) {
//                    self.photosCompleteChooseCallback(@[newImage]);
//                }
//            }
//
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        }];
//    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
