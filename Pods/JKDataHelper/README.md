# JKDataHelper

[![CI Status](http://img.shields.io/travis/HHL110120/JKDataHelper.svg?style=flat)](https://travis-ci.org/HHL110120/JKDataHelper)
[![Version](https://img.shields.io/cocoapods/v/JKDataHelper.svg?style=flat)](http://cocoapods.org/pods/JKDataHelper)
[![License](https://img.shields.io/cocoapods/l/JKDataHelper.svg?style=flat)](http://cocoapods.org/pods/JKDataHelper)
[![Platform](https://img.shields.io/cocoapods/p/JKDataHelper.svg?style=flat)](http://cocoapods.org/pods/JKDataHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements


## Description

this is a tool always to help  the developers to avoid bugs by the unstable APIs. it always help you to avoid bugs when you use the functions:
```
NSArray:

NSArray *array = @[obect1,object2];

id object = [array objectAtIndex:i];

//****************************************
NSMutableArray:
[mutableArray addObject:object];

[mutableArray insertObject:object atIndex:i];

[mutableArray removeObjectAtIndex:i];

[mutableArray replaceObjectAtIndex:i withObject:object];

//*************************************************
NSDictionary:

NSDictionary *dic = @{object1:key1,object2:key2};

NSDictionary *dic = [NSDictionary dictionaryWithObject:object forKey:key];

NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:object1,key1,object2,key2,nil];

NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

NSDictionary *dic = [NSDictionary initWithObjects:objects forKeys:keys count:count];


```

## Installation

JKDataHelper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JKDataHelper"
```

## Author

xindizhiyin2014, 929097264@qq.com

## License

JKDataHelper is available under the MIT license. See the LICENSE file for more info.
