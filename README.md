# SMTKeyboardManager

SMTkeyboardManager handles automatic scrolling of textfields that hides beneath the keyboard

## Version
1.0.0

### Cocoapods - Podfile
```
pod 'SMTKeyboardManager'
```

### Integration
Set all texfields to a subclass of 
```objc
SMTTextFieldHandler
```

##### Keyboard Monitoring
Inside AppDelegate 
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

SMTKeyboardManager * keyboardManager = [SMTKeyboardManager sharedManager];
[keyboardManager startKeyboardMonitoring];
return YES;
}
```

##### Delegate Methods
```objc
#pragma mark - SMTKeyboardManagerDelegate
#pragma mark -
-(void)SMTKeyboardManagerKeyboardWillShow{
NSLog(@"Hi I was called in delegate controller. Keyboard will show");
}
-(void)SMTKeyboardManagerKeyboardWillHide{
NSLog(@"Hi I was called in delegate controller. Keyboard will hide");
}
```

##### Properties
```objc
//Set YES to allow tap outside to dismiss keyboard
BOOL supportDismissTap
```

### IMPORTANT
Pre-requisite:
* Textfields must be inside a scrollview.
* View hierarchy should be Controller View -> ScrollView -> TextField

### Lets build together!
Fork, implement, pull request. 

### Copyright
Copyright (c) 2015 [Steffi Tan](http://iamsteffi.com)  
See MIT-LICENSE for further details.

