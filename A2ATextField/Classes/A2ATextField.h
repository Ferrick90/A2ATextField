//
//  A2ATextField.h
//  A2ATextField
//
//  Created by Ferrick Chan on 23/07/2018.
//

#import <UIKit/UIKit.h>

@class A2ATextField;

typedef NS_ENUM(NSInteger, A2ATextFieldStyle)
{
	A2ATextFieldStyleEmail,         //Default email validation
	A2ATextFieldStyleNone,          //Default style
};

typedef BOOL (^A2AValidationBlock)(A2ATextField *textField);

@interface A2ATextField: UITextField

@property (nonatomic, strong) IBInspectable UIColor *placeholderActiveColor;
@property (nonatomic, strong) IBInspectable UIColor *placeholderInactiveColor;
@property (nonatomic, strong) UIFont *bottomLabelFont;
@property (nonatomic, assign) IBInspectable BOOL bottomBorderOnly;
@property (nonatomic, assign) IBInspectable BOOL isMandatory;
@property (nonatomic, copy) IBInspectable NSString *errorText;
@property (nonatomic, assign) A2ATextFieldStyle style;

- (void) error;
- (void) error: (NSString *) message;
- (void) setValidationBlock: (A2AValidationBlock) block;
- (BOOL) validationSuccess;

@end


