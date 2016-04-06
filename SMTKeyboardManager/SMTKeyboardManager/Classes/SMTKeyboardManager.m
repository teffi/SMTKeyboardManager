//
//  SMTKeyboardManger.m
//  SMTKeyboardManager
//
//  Created by Steffi Tan on 30/03/2016.
//  Copyright © 2016 Steffi Tan. All rights reserved.
//

#import "SMTKeyboardManager.h"

static CGFloat keyboardHeight;

@interface SMTKeyboardManager()
@property(strong,nonatomic,nonnull)id controller;
@property(strong,nonatomic,nonnull)UIView * controllerView;

@end

@implementation SMTKeyboardManager
+(SMTKeyboardManager *)sharedManager{
    
    static SMTKeyboardManager * _sharedManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _sharedManager = [[self alloc]init];
        
    });
    
    return _sharedManager;
}
-(instancetype)init{
    self = [super init];
    
    if(self){
        
    }
    return self;
}

#pragma mark - Monitoring
#pragma mark -

-(void)startKeyboardMonitoring{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //Support of UITextView
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
}

-(void)endKeyboardMonitoring{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
}

#pragma mark - Observer selectors
#pragma mark -
- (void)keyboardWillShow:(NSNotification *)notification {
    if([self.delegate respondsToSelector:@selector(SMTKeyboardManagerKeyboardWillShow)]){
        [self.delegate SMTKeyboardManagerKeyboardWillShow];
    }

    NSDictionary* info = [notification userInfo];
    
    keyboardHeight = CGRectGetHeight([[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue]);
    
    CGFloat textFieldHeight = CGRectGetHeight(_activeView.frame);
    
    CGPoint textFieldOrigin = _activeView.frame.origin;
    textFieldOrigin.y = CGRectGetMinY(_activeView.frame) + CGRectGetMinY(_scrollView.frame) + textFieldHeight;
    CGRect visibleRect = _controllerView.frame;
    visibleRect.size.height -= keyboardHeight;
    
    //Automatic scroll when field is out of bounds the visible rect.
    if (!CGRectContainsPoint(visibleRect, textFieldOrigin)){
        CGPoint scrollPoint = CGPointMake(0.0, textFieldOrigin.y - visibleRect.size.height  + 10);
        //Don't proceed with offsetting when the calculated scrollpoint is out of bounds
        if(scrollPoint.y <= CGRectGetMinY(_activeView.frame)){
            [_scrollView setContentOffset:scrollPoint animated:YES];
        }
    }
    
    //Support manual scrolling of scrollview.
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height + keyboardHeight)];
    
}


- (void)keyboardWillBeHidden:(NSNotification *)notification {
    if([self.delegate respondsToSelector:@selector(SMTKeyboardManagerKeyboardWillHide)]){
        [self.delegate SMTKeyboardManagerKeyboardWillHide];
    }
    
    [_scrollView setContentOffset:CGPointZero animated:YES];
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height)];
    
    //Set activeview to nil to avoid conflict when the activeView becomes UITextView while willShow is
    //still triggered while holding the previous activeView
    _activeView = nil;
    
    //NSLog(@"SMTKeyboardManager keyboard will hide");
}

//DidShow is ONLY for UITextView class.
//TextView 'willShowKeyboard' observer is trigerred prior to beginEditing where the activeView is assigned
//Therefore we need to catch the observer on DidShow instead of WillShow
- (void)keyboardDidShow:(NSNotification *)notification {
    
    if ([_activeView superclass] == [UITextView class]) {
        //NSLog(@"ITS A TEXTVIEW! notif %@",notification);
        //NSLog(@"active view %@",_activeView);
        [self keyboardWillShow:notification];
    }
}

#pragma mark - Properties
#pragma mark -
-(void)setCurrentController:(id)currentController{
    _controller = (UIViewController *)currentController;
    _controllerView = ((UIViewController *)currentController).view;
    
    [self createDismissTap];
}

-(id)currentController{
    
    return _controller;
}

#pragma mark - Tap to Dismiss Support
#pragma mark -
-(void)createDismissTap{
    //NSLog(@"current controller view %@",_controllerView);
    
    if(_supportDismissTap){
        UITapGestureRecognizer * dissmissTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didDismissTap)];
        
        [_controllerView addGestureRecognizer:dissmissTapGesture];
    }
}
-(void)didDismissTap{
    //NSLog(@"dismiss tap on keyboard manager");
    [_controllerView endEditing:YES];
    [self performSelector:@selector(keyboardWillBeHidden:) withObject:nil];
}

@end

