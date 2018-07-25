# A2ATextField

[![CI Status](https://img.shields.io/travis/Ferrick90/A2ATextField.svg?style=flat)](https://travis-ci.org/Ferrick90/A2ATextField)
[![Version](https://img.shields.io/cocoapods/v/A2ATextField.svg?style=flat)](https://cocoapods.org/pods/A2ATextField)
[![License](https://img.shields.io/cocoapods/l/A2ATextField.svg?style=flat)](https://cocoapods.org/pods/A2ATextField)
[![Platform](https://img.shields.io/cocoapods/p/A2ATextField.svg?style=flat)](https://cocoapods.org/pods/A2ATextField)

UITextField class to float the Placeholder and validate the text while editing.

## Features
- [x] Floating effect in placeholder
- [x] Change border style to bottom line
- [x] Change placeholder active and inactive text color
- [x] Mandatory option
- [x] Change mandatory error message
- [x] Validate the text while editing

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

A2ATextField is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'A2ATextField'
```

## How to use
####  Set placeholder
```
self.textField.placeholder = @"Name*";
```

#### Change border style to bottom line
Default value is NO
```
self.textField.bottomBorderOnly = YES;
```

#### Change the placeholder active color
```
self.textField.placeholderActiveColor = [UIColor greenColor];
```

#### Change the placeholder inactive color
```
self.textField.placeholderInactiveColor = [UIColor greenColor];
```

#### Set mandatory
Default is NO
```
self.textField.isMandatory = YES;
```

#### Change mandatory error message
Default is Error
```
self.textField.mandatoryText = @"Please input a valid name";
```

## Author

Ferrick90, ferrick1990@hotmail.com

## License

A2ATextField is available under the MIT license. See the LICENSE file for more info.
