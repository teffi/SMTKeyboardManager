//
//  ViewController.m
//  SMTKeyboardManager
//
//  Created by Steffi Tan on 30/03/2016.
//  Copyright © 2016 Steffi Tan. All rights reserved.
//

#import "ViewController.h"
#import "SMTKeyboardManager.h"


@interface ViewController ()<SMTKeyboardManagerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Call SMTKeyboardManagerDelegate for handling keyboard manager outside its class
#pragma mark - SMTKeyboardManagerDelegate
#pragma mark -
-(void)SMTKeyboardManagerKeyboardWillShow{
    NSLog(@"Hi I was called in delegate controller. Keyboard will show");
}
-(void)SMTKeyboardManagerKeyboardWillHide{
    NSLog(@"Hi I was called in delegate controller. Keyboard will hide");
}
@end
