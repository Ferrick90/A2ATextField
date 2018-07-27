//
//  A2AViewController.h
//  A2ATextField
//
//  Created by Ferrick90 on 07/23/2018.
//  Copyright (c) 2018 Ferrick90. All rights reserved.
//

@import UIKit;
#import "A2ATextField.h"

@interface A2AViewController : UIViewController

@property (weak, nonatomic) IBOutlet A2ATextField *userTextField;
@property (weak, nonatomic) IBOutlet A2ATextField *passTextField;
@property (weak, nonatomic) IBOutlet A2ATextField *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
