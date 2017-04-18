# HXTool

[![CI Status](http://img.shields.io/travis/Insofan/HXTool.svg?style=flat)](https://travis-ci.org/Insofan/HXTool)
[![Version](https://img.shields.io/cocoapods/v/HXTool.svg?style=flat)](http://cocoapods.org/pods/HXTool)
[![License](https://img.shields.io/cocoapods/l/HXTool.svg?style=flat)](http://cocoapods.org/pods/HXTool)
[![Platform](https://img.shields.io/cocoapods/p/HXTool.svg?style=flat)](http://cocoapods.org/pods/HXTool)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HXTool is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HXTool"
```

## Usage

1.UIColor with hex string

```
self.view.backgroundColor = [UIColor colorWithRGBString:@"4EBDFB"];
```

or with RGB number

```
self.view.backgroundColor = [UIColor colorWithRGBNumber:78 green:189 blue:151];
```

2.UIButton

```
UIButton *button = [UIButton buttonWithTitle:@"button" fontSize:12 normalColor:[UIColor blueColor] selectedColor:[UIColor whiteColor]];
```

3.Screen frame

```
1.Screen Width and Screen Height
view.frame = CGRectMake(100, 300, [UIScreen screenWidth]/2, [UIScreen screenHeight]/6);
```

## Author

Insofan, insofan3156@gmail.com

## License

HXTool is available under the MIT license. See the LICENSE file for more info.
