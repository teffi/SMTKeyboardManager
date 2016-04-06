//
//  SMTTextFieldHandler.m
//  SMTKeyboardManager
//
//  Created by Steffi Tan on 30/03/2016.
//  Copyright © 2016 Steffi Tan. All rights reserved.
//

#import "SMTTextFieldHandler.h"
#import "SMTKeyboardManager.h"

@interface SMTTextFieldHandler()<UITextFieldDelegate>{
    SMTKeyboardManager * keyboardManager;
}
@end

@implementation SMTTextFieldHandler

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        keyboardManager = [SMTKeyboardManager sharedManager];
        self.delegate = self;
    }
    return self;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //Get superview controller
    
    /**
     *  [textField.superview.superview nextResponder]
     *  Returns the controller handling textField.
     *  View hierarchy: textField -> scrollview -> ViewController
     */
    
    [keyboardManager setCurrentController:[textField.superview.superview nextResponder]];
    keyboardManager.delegate = (id)[textField.superview.superview nextResponder];
    keyboardManager.activeView = textField;
    keyboardManager.scrollView = (id)textField.superview;
}

@end