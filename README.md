# SMTKeyboardManager

SMTkeyboardManager handles automatic scrolling of textfields that hides beneath the keyboard

## Version
1.1.0

####Changelog v1.1.0
* Added UITextView support.
* Updated scrolling calculations that will work for both UITextField and UITextView

### Cocoapods - Podfile
```
pod 'SMTKeyboardManager'
```

### Integration
Set all texfields to a subclass of 
```objc
SMTTextFieldHandler
```
Set all TextView to a subclass of 
```objc
SMTTextViewHandler
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
* Textfields/TextView must be inside a scrollview.
* View hierarchy should be Controller View -> ScrollView -> TextField



### Lets build together!
Fork, implement, pull request. 

### Copyright
Copyright (c) 2015 [Steffi](steffi.dev)  
See MIT-LICENSE for further details.

