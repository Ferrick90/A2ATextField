//
//  A2AViewController.m
//  A2ATextField
//
//  Created by Ferrick90 on 07/23/2018.
//  Copyright (c) 2018 Ferrick90. All rights reserved.
//

#import "A2AViewController.h"
#import "A2ATextField.h"

@interface A2AViewController () {
	UIButton *nameSuccessButton;
	UIButton *eyeButton;
	UIButton *emailSuccessButton;
}

@end

@implementation A2AViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// userTextField
	//self.userTextField.font = [UIFont systemFontOfSize:20.0];
	//self.userTextField.placeholder = @"Name*";
	//self.userTextField.bottomBorderOnly = YES;
	//self.userTextField.placeholderInactiveColor = [UIColor greenColor];
	//self.userTextField.isMandatory = YES;
	//self.userTextField.mandatoryText = @"Please input a valid name";
	
	// userTextField custom right button
	nameSuccessButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[nameSuccessButton setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
	nameSuccessButton.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
	nameSuccessButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
	nameSuccessButton.hidden = YES;
	self.userTextField.rightView = nameSuccessButton;
	self.userTextField.rightViewMode = UITextFieldViewModeAlways;
	
	// userTextField validation
	[self.userTextField setValidationBlock:^(A2ATextField *textField) {
		if (textField.text.length > 0) {
			self->nameSuccessButton.hidden = NO;
			return YES;
		}
		
		self->nameSuccessButton.hidden = YES;
		[self.userTextField error];
		
		return NO;
	}];
	
	// passTextField custom right button
	eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[eyeButton setImage:[UIImage imageNamed:@"view"] forState:UIControlStateNormal];
	eyeButton.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
	[eyeButton addTarget:self action:@selector(eyeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	self.passTextField.rightView = eyeButton;
	self.passTextField.rightViewMode = UITextFieldViewModeAlways;
	
	// passTextField validation
	[self.passTextField setValidationBlock:^(A2ATextField *textField) {
		if (textField.text.length < 8) {
			[self.passTextField error];
			return NO;
		}
		
		return YES;
	}];
	
	// emailTextField custom right button
	emailSuccessButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[emailSuccessButton setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
	emailSuccessButton.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
	emailSuccessButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
	emailSuccessButton.hidden = YES;
	self.emailTextField.rightView = emailSuccessButton;
	self.emailTextField.rightViewMode = UITextFieldViewModeAlways;
	
	// emailTextField
	self.emailTextField.style = A2ATextFieldStyleEmail;
	
	self.successLabel.hidden = YES;
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)eyeButtonAction:(id)sender {
	if (self.passTextField.isSecureTextEntry) {
		self.passTextField.secureTextEntry = NO;
		[eyeButton setImage:[UIImage imageNamed:@"hide"] forState:UIControlStateNormal];
	} else {
		self.passTextField.secureTextEntry = YES;
		[eyeButton setImage:[UIImage imageNamed:@"view"] forState:UIControlStateNormal];
	}
}

- (IBAction)submitAction:(id)sender {
	
	[self.view endEditing:YES];
	
	BOOL status = YES;
	
	if (!self.userTextField.validationSuccess) {
		status = NO;
	}
	
	if (!self.passTextField.validationSuccess) {
		status = NO;
	}
	
	if (!self.emailTextField.validationSuccess) {
		status = NO;
	}
	
	// do somethings like call api or etc.
	if (status == YES) {
		self.successLabel.hidden = NO;
	} else {
		self.successLabel.hidden = YES;
	}	
}

@end
