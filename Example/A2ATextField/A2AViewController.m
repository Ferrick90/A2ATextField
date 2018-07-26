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
	self.userTextField.delegate = self;
	
	// userTextField custom right button
	nameSuccessButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[nameSuccessButton setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
	nameSuccessButton.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
	nameSuccessButton.hidden = YES;
	self.userTextField.rightView = nameSuccessButton;
	self.userTextField.rightViewMode = UITextFieldViewModeAlways;
	
	// passTextField
	self.passTextField.delegate = self;
	
	// passTextField custom right button
	eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[eyeButton setImage:[UIImage imageNamed:@"view"] forState:UIControlStateNormal];
	eyeButton.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
	[eyeButton addTarget:self action:@selector(eyeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	self.passTextField.rightView = eyeButton;
	self.passTextField.rightViewMode = UITextFieldViewModeAlways;
	
	// emailTextField
	self.emailTextField.delegate = self;
	
	// emailTextField custom right button
	emailSuccessButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[emailSuccessButton setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
	emailSuccessButton.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
	emailSuccessButton.hidden = YES;
	self.emailTextField.rightView = emailSuccessButton;
	self.emailTextField.rightViewMode = UITextFieldViewModeAlways;
	
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
	
	if (self.userTextField.text.length == 0) {
		[self.userTextField errorMessage:@"Please input a valid name"];
	}
	
	if (self.passTextField.text.length == 0) {
		[self.passTextField errorMessage:@"Please input a valid password"];
	}
	
	if (self.emailTextField.text.length == 0) {
		[self.emailTextField errorMessage:@"Please input a valid email"];
	}
}

- (void) validationBlock:(UITextField *)textField {
	
	if (textField.tag == 1) {
		if (textField.text.length > 0) {
			nameSuccessButton.hidden = NO;
		} else {
			nameSuccessButton.hidden = YES;
			[self.userTextField errorMessage:@"Please input a valid name"];
		}
	} else if (textField.tag == 2) {
		if (textField.text.length < 6) {
			[self.passTextField errorMessage:@"Passwords must be at least 8 characters in length"];
		}
	} else if (textField.tag == 3) {
		if ([self validateEmailWithString: textField.text]) {
			emailSuccessButton.hidden = NO;
		} else {
			emailSuccessButton.hidden = YES;
			[self.emailTextField errorMessage:@"Invalid email format"];
		}
	}
	
	//NSLog(@"validation result : %@", textField.text);
}

- (BOOL) validateEmailWithString:(NSString*)checkString {
	BOOL stricterFilter = NO;
	NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
	NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:checkString];
}


@end
