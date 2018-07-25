//
//  A2AViewController.m
//  A2ATextField
//
//  Created by Ferrick90 on 07/23/2018.
//  Copyright (c) 2018 Ferrick90. All rights reserved.
//

#import "A2AViewController.h"
#import "A2ATextField.h"

@interface A2AViewController ()

@end

@implementation A2AViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	//self.userTextField.font = [UIFont systemFontOfSize:20.0];
	self.userTextField.placeholder = @"Name*";
	self.userTextField.delegate = self;
	//self.userTextField.placeholderActiveColor = [UIColor greenColor];
	
	// custom right button
//	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//	[button setTitle:@"Show View" forState:UIControlStateNormal];
//	[button setImage:[UIImage imageNamed:@"view"] forState:UIControlStateNormal];
//	button.frame = CGRectMake(0, 0, 30, self.userTextField.frame.size.height);
//	self.userTextField.rightView = button;
//	self.userTextField.rightViewMode = UITextFieldViewModeAlways;
	
	NSLog(@"result : %@", self.userTextField.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(id)sender {
	
	[self.view endEditing:YES];
	
	if (self.userTextField.text.length == 0) {
		[self.userTextField errorMessage:@"Please input a valid name"];
	}
}

- (void) validationBlock:(UITextField *)textField {
	NSLog(@"validation result : %@", textField.text);
}


@end
