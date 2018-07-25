//
//  A2ATextField.m
//  A2ATextField
//
//  Created by Ferrick Chan on 23/07/2018.
//

#import "A2ATextField.h"


@interface A2ATextField () {
	id<A2ATextFieldDelegate> delegate;
	CALayer *bottomLayer;
	UILabel *placeholderLabel;
	UILabel *bottomLabel;
	NSLayoutConstraint *placeholderLabelLeftConstraint;
	NSLayoutConstraint *placeholderLabelTopConstraint;
	NSLayoutConstraint *bottomLabelTopConstraint;
	UIColor *bottomBorderColor;
	UIColor *errorColor;
	UIColor *placeholderTextActiveColor;
	UIColor *placeholderTextInactiveColor;
	BOOL error;
	BOOL bottomBorder;
}
@end

@implementation A2ATextField

@synthesize delegate = _delegate;
@synthesize isMandatory = _isMandatory;
@synthesize mandatoryText = _mandatoryText;

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self setupView];
	}
	
	return self;
}

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupView];
	}
	return self;
}

- (void) setupView {
	
	errorColor = [UIColor colorWithRed:225.0/255.0 green:51.0/255.0 blue:40.0/255.0 alpha:1.0];
	bottomBorderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:0.4];
	
	placeholderTextActiveColor = [UIColor colorWithRed:38/255.0 green:108/255.0 blue:194/255.0 alpha:1.0];
	placeholderTextInactiveColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
	
	placeholderLabel = [[UILabel alloc] init];
	placeholderLabel.text = @"";
	placeholderLabel.font = [UIFont systemFontOfSize:14.0];
	placeholderLabel.textColor = placeholderTextInactiveColor;
	placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview: placeholderLabel];
	
	bottomLabel = [[UILabel alloc] init];
	bottomLabel.text = @"Please input a valid name";
	bottomLabel.font = [UIFont systemFontOfSize:11.0];
	bottomLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
	bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
	bottomLabel.hidden = YES;
	[self addSubview: bottomLabel];
	
	[self initLayer];
	
	// placeholderLabel Constraints
	placeholderLabelTopConstraint = [NSLayoutConstraint constraintWithItem:placeholderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
	
	[self addConstraint:placeholderLabelTopConstraint];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view]-0-|" options:0 metrics:nil views:@{@"view": placeholderLabel}]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-0-|" options:0 metrics:nil views:@{@"view": placeholderLabel}]];
	
	placeholderLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:placeholderLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:6.0];
	
	[self addConstraint:placeholderLabelLeftConstraint];
	
	// bottomLabel Constraints
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view": bottomLabel}]];
	
	bottomLabelTopConstraint = [NSLayoutConstraint constraintWithItem:bottomLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3.0];
	
	[self addConstraint: bottomLabelTopConstraint];
	
	// textField method
	[self addTarget:self action:@selector(textFieldEdittingDidBeginInternal:) forControlEvents:UIControlEventEditingDidBegin];
	[self addTarget:self action:@selector(textFieldEdittingDidChangeInternal:) forControlEvents:UIControlEventEditingChanged];
	[self addTarget:self action:@selector(textFieldEdittingDidEndInternal:) forControlEvents:UIControlEventEditingDidEnd];
	
}

#pragma mark - Access Method

- (void) setFont:(UIFont *)font {
	[super setFont:font];
	placeholderLabel.font = font;
}

- (void) setPlaceholder:(NSString *)placeholder {
	[super setPlaceholder:nil];
	placeholderLabel.text = placeholder;
}

- (void) setPlaceholderActiveColor:(UIColor *)placeholderActiveColor {
	placeholderTextActiveColor = placeholderActiveColor;
}

- (void) setPlaceholderInactiveColor:(UIColor *)placeholderInactiveColor {
	placeholderTextInactiveColor = placeholderInactiveColor;
	placeholderLabel.textColor = placeholderInactiveColor;
}

- (void) setBottomLabelFont:(UIFont *)bottomLabelFont {
	bottomLabel.font = bottomLabelFont;
}

- (void) setBottomBorderOnly:(BOOL)bottomBorderOnly {
	bottomBorder = bottomBorderOnly;
	
	if (bottomBorderOnly == YES) {
		self.borderStyle = UITextBorderStyleNone;
		
		bottomLayer = [CALayer layer];
		bottomLayer.borderColor = bottomBorderColor.CGColor;
		bottomLayer.borderWidth = 1.0;
		bottomLayer.frame = CGRectMake(0, self.frame.size.height - 6, self.frame.size.width, 1.0);
		[self.layer addSublayer: bottomLayer];
		
		placeholderLabelLeftConstraint.constant = 0;
		bottomLabelTopConstraint.constant = 11.0;
	} else {
		[self initLayer];
		
		placeholderLabelLeftConstraint.constant = 6.0;
		bottomLabelTopConstraint.constant = 3.0;
	}
}

#pragma mark - Init BorderLayer

- (void) initLayer
{
	switch ( self.borderStyle )
	{
		case UITextBorderStyleRoundedRect:
			self.layer.borderWidth = 1.0f;
			self.layer.cornerRadius = 6.0f;
			self.layer.borderColor = [UIColor clearColor].CGColor;
			break;
		case UITextBorderStyleLine:
			self.layer.borderWidth = 1.0f;
			self.layer.cornerRadius = 0.0f;
			self.layer.borderColor = [UIColor clearColor].CGColor;
			break;
		case UITextBorderStyleBezel:
			self.layer.borderWidth = 2.0f;
			self.layer.cornerRadius = 0.0f;
			self.layer.borderColor = [UIColor clearColor].CGColor;
			break;
		case UITextBorderStyleNone:
			self.layer.borderWidth = 0.0f;
			break;
		default:
			break;
	}
}

#pragma mark - Get Method

- (void) errorMessage:(NSString *)errorText {

	error = YES;
	
	void (^errorBlock)(void) = ^{
		self->bottomLabel.hidden = NO;
		self->bottomLabel.text = errorText;
		self->bottomLabel.textColor = self->errorColor;
		
		if (self->bottomBorder == YES) {
			self->bottomLayer.borderColor = self->errorColor.CGColor;
		} else {
			self.layer.borderColor = self->errorColor.CGColor;
		}
	};
	
	[UIView transitionWithView:self
					  duration:0.3f
					   options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
					animations:errorBlock
					completion:nil];
}

#pragma mark - TextField Target Method

- (IBAction) textFieldEdittingDidBeginInternal:(UITextField *)sender
{
	[self runDidTextBeginAnimation];
}

- (IBAction) textFieldEdittingDidEndInternal:(UITextField *)sender
{
	if (self.isMandatory == YES) {
		[self validationMandotry];
	} else {
		[self runDidTextEndAnimation];
	}
}

- (IBAction) textFieldEdittingDidChangeInternal:(UITextField *)sender
{
	if (sender.text.length > 0) {
		if (sender.text.length == 1) {
			[self runDidBeginAnimation];
		}
	} else {
		[self runDidEndAnimation];
	}
	
	if (error == YES) {
		[self removeError];
	}
}

#pragma mark - Validation Method

- (void) validationMandotry {
	if (self.text.length == 0) {
		if (self.mandatoryText.length == 0) {
			[self errorMessage: @"Error"];
		} else {
			[self errorMessage: self.mandatoryText];
		}
	} else {
		[self runDidTextEndAnimation];
	}
}


#pragma mark - Remove Error Highlight Method

- (void) removeError {
	
	error = NO;
	
	void (^removeErrorBlock)(void) = ^{
		self->bottomLabel.hidden = YES;
		self->bottomLabel.text = @"";
		self->bottomLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
		
		if (self->bottomBorder == YES) {
			self->bottomLayer.borderColor = self->bottomBorderColor.CGColor;
		} else {
			self.layer.borderColor = [UIColor clearColor].CGColor;
		}
	};
	
	[UIView transitionWithView:self
					  duration:0.3f
					   options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
					animations:removeErrorBlock
					completion:nil];
}

#pragma mark - Animation

- (void) runDidBeginAnimation {
	[UIView animateWithDuration:0.3 animations:^{
		self->placeholderLabel.textColor = self->placeholderTextActiveColor;
		
		if (self->bottomBorder == YES) {
			self->placeholderLabelTopConstraint.constant = -(self.font.pointSize + 25);
		} else {
			self->placeholderLabelLeftConstraint.constant = 0;
			self->placeholderLabelTopConstraint.constant = -(self.font.pointSize + 33);
		}
		
		[self layoutIfNeeded];
	}];
	
}

- (void) runDidEndAnimation {
	[UIView animateWithDuration:0.3 animations:^{
		self->placeholderLabel.textColor = self->placeholderTextInactiveColor;
		
		if (self->bottomBorder == YES) {
			self->placeholderLabelTopConstraint.constant = 0;
		} else {
			self->placeholderLabelLeftConstraint.constant = 6;
			self->placeholderLabelTopConstraint.constant = 0;
		}
		
		[self layoutIfNeeded];
	}];
}

- (void) runDidTextBeginAnimation {
	if (error == NO) {
		if (self.text.length > 0) {
			
			NSLog(@"123");
			void (^hideBlock)(void) = ^{
				self->placeholderLabel.textColor = self->placeholderTextActiveColor;
				self->bottomLabel.hidden = YES;
				
				if (self->bottomBorder == YES) {
					self->bottomLayer.borderColor = self->placeholderTextActiveColor.CGColor;
				} else {
					self.layer.borderColor = self->placeholderTextActiveColor.CGColor;
				}
			};
			
			[UIView transitionWithView:self
							  duration:0.3f
							   options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
							animations:hideBlock
							completion:nil];
		} else {
			void (^hideBlock)(void) = ^{
				self->bottomLabel.hidden = YES;
				
				if (self->bottomBorder == YES) {
					self->bottomLayer.borderColor = self->placeholderTextActiveColor.CGColor;
				} else {
					self.layer.borderColor = self->placeholderTextActiveColor.CGColor;
				}
			};
			
			[UIView transitionWithView:self
							  duration:0.3f
							   options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
							animations:hideBlock
							completion:nil];
		}
	} else {
		void (^hideBlock)(void) = ^{
			self->bottomLabel.hidden = YES;
			
			if (self->bottomBorder == YES) {
				self->bottomLayer.borderColor = self->placeholderTextActiveColor.CGColor;
			} else {
				self.layer.borderColor = self->placeholderTextActiveColor.CGColor;
			}
		};
		
		[UIView transitionWithView:self
						  duration:0.3f
						   options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
						animations:hideBlock
						completion:nil];
	}
}

- (void) runDidTextEndAnimation {
	
	void (^hideBlock)(void) = ^{
		self->placeholderLabel.textColor = self->placeholderTextInactiveColor;
		
		if (self->bottomBorder == YES) {
			self->bottomLayer.borderColor = self->bottomBorderColor.CGColor;
		} else {
			self.layer.borderColor = [UIColor clearColor].CGColor;
		}
	};
	
	[UIView transitionWithView:self
					  duration:0.3f
					   options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve
					animations:hideBlock
					completion:nil];
	
	if (self.delegate != nil){
		if ([self.delegate respondsToSelector:@selector(validationBlock:)]) {
			[self.delegate validationBlock:self];
		}
	}
	
}

@end
