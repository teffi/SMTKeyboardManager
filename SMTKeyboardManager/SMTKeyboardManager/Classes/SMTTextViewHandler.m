//
//  SMTTextViewHandler.m
//  SMTKeyboardManager
//
//  Created by Steffi Tan on 06/04/2016.
//  Copyright © 2016 Steffi Tan. All rights reserved.
//

#import "SMTTextViewHandler.h"
#import "SMTKeyboardManager.h"

@interface SMTTextViewHandler()<UITextViewDelegate>{
    SMTKeyboardManager * keyboardManager;
}

@end


@implementation SMTTextViewHandler

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        keyboardManager = [SMTKeyboardManager sharedManager];
        self.delegate = self;
    }
    return self;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    //Get superview controller
    /**
     *  [textView.superview.superview nextResponder]
     *  Returns the controller handling textView.
     *  View hierarchy: Textview -> scrollview -> ViewController
     */
    
    [keyboardManager setCurrentController:[textView.superview.superview nextResponder]];
    keyboardManager.delegate = (id)[textView.superview.superview nextResponder];
    keyboardManager.activeView = textView;
    keyboardManager.scrollView = (id)textView.superview;
}

@end
