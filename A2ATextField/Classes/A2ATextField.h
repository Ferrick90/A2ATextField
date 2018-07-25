//
//  A2ATextField.h
//  A2ATextField
//
//  Created by Ferrick Chan on 23/07/2018.
//

#import <UIKit/UIKit.h>

@class A2ATextField;

@protocol A2ATextFieldDelegate <UITextFieldDelegate>
@optional
- (void)validationBlock:(UITextField *)textField;
@end

@interface A2ATextField: UITextField

@property (nonatomic, assign) id<A2ATextFieldDelegate> delegate;
@property (nonatomic, strong) IBInspectable UIColor *placeholderActiveColor;
@property (nonatomic, strong) IBInspectable UIColor *placeholderInactiveColor;
@property (nonatomic, assign) IBInspectable BOOL bottomBorderOnly;
@property (nonatomic, assign) IBInspectable BOOL isMandatory;
@property (nonatomic, copy) IBInspectable NSString *mandatoryText;

@property (nonatomic, strong) UIFont *bottomLabelFont;

- (void) errorMessage: (NSString *) errorText;

@end


