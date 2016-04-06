//
//  SMTKeyboardManger.h
//  SMTKeyboardManager
//
//  Created by Steffi Tan on 30/03/2016.
//  Copyright © 2016 Steffi Tan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SMTKeyboardManagerDelegate;

@interface SMTKeyboardManager : NSObject

+(nonnull SMTKeyboardManager *)sharedManager;
/**
 *  Holds the controller that uses the SMTKeyboardManager
 */
@property(strong,nonatomic,nonnull)id currentController;
/**
 *  Holds the current active textfield when the keyboard shows.
 *  Gets evaluated whether its colliding with the keyboard.
 */
@property(strong,nonatomic,nullable)UIView * activeView;
/**
 *  Holds the scrollview where the currentTextField is placed.
 *  SMTKeyboardManager requires the textfield to be placed inside a scrollview.
 */
@property(strong,nonatomic,nonnull)UIScrollView * scrollView;
/**
 *  Holds the delegated class/controller.
 *  Set if you want to make custom actions on keyboardWillBeHidden or keyBoardWillShow apart
 *  from what SMTKeyboardManager is doing.
 */
@property(weak,nonatomic,nullable)id<SMTKeyboardManagerDelegate> delegate;
/**
 *  Create keyboard KVO observer
 *  Recommended to be called on AppDelegate
 */
-(void)startKeyboardMonitoring;

/**
 *  Remove created Keyboard KVO observer
 */
-(void)endKeyboardMonitoring;

/**
 *  Enable/Disable tap to dismiss keyboard support.
 */
@property(nonatomic)BOOL supportDismissTap;
@end
#pragma mark - SMTKeyboardManagerDelegate

/**
 *  SMTKeyboardManagerDelegate
 */
@protocol SMTKeyboardManagerDelegate <NSObject>

@optional
-(void)SMTKeyboardManagerKeyboardWillShow;
-(void)SMTKeyboardManagerKeyboardWillHide;

@end