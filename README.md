# MRJCitySelect

[![CI Status](http://img.shields.io/travis/mrjlovetian@gmail.com/MRJCitySelect.svg?style=flat)](https://travis-ci.org/mrjlovetian@gmail.com/MRJCitySelect)
[![Version](https://img.shields.io/cocoapods/v/MRJCitySelect.svg?style=flat)](http://cocoapods.org/pods/MRJCitySelect)
[![License](https://img.shields.io/cocoapods/l/MRJCitySelect.svg?style=flat)](http://cocoapods.org/pods/MRJCitySelect)
[![Platform](https://img.shields.io/cocoapods/p/MRJCitySelect.svg?style=flat)](http://cocoapods.org/pods/MRJCitySelect)

## Example

### 效果图
![](main.png)

![](ysearch.png)

![](search.png)

### 如何使用

```
CitySelectViewController *vc = [[CitySelectViewController alloc] init];
        vc.navTitle = @"城市选择";
        vc.cityBlock = ^(CityModelManger *city) {
            MRJLog(@"选择的城市是%@", city.regionName);
        };
```

## Requirements

## Installation

MRJCitySelect is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MRJCitySelect'
```

## Author

mrjlovetian@gmail.com, mrjlovetian@gmail.com

## License

MRJCitySelect is available under the MIT license. See the LICENSE file for more info.


