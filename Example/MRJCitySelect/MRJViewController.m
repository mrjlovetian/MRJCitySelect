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
    CitySelectViewController *vc = [[CitySelectViewController alloc] init];
    vc.navTitle = @"选择城市";
    vc.cityBlock = ^(CityModelManger *city) {
        NSLog(@"选中的城市是%@", city.regionName);
    };
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
