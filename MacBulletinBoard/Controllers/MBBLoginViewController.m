//
//  MBBLoginViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/9/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBLoginViewController.h"

@interface MBBLoginViewController (){
    UITextField *activeField;
    NSArray *users;
    NSMutableArray *passwords;
    NSString *msg;
}
@end

@implementation MBBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // load xib into view
    self.loginView = (MBBLoginView*)[self getCustomXibUsingXibName:@"LoginView"];
    
    // set delegates
    self.loginView.delegate = self;
    self.loginView.usernameTextField.delegate = self;
    self.loginView.passwordTextField.delegate = self;
    
    self.loginView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self registerForKeyboardNotifications];
    
    users = [[NSArray alloc] initWithObjects:@"mac", @"bey", nil];
    passwords = [[NSMutableArray alloc] initWithObjects:@"mac", @"bey", nil];
    
    // add login view to view
    [self.view addSubview:self.loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EBBLoginView Delegates

- (void)loginButtonPressed{
    //NSLog(@"Login button pressed");
    //[self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self];

    NSString *inputUsername = self.loginView.usernameTextField.text;
    NSString *inputPassword = self.loginView.passwordTextField.text;
    
    // check if text fields are not empty
    if (![inputUsername isEqual:@""] && ![inputPassword isEqual:@""]) {
        // check if username and password match
        if ([users containsObject:inputUsername] && [passwords containsObject:inputPassword]) {
            NSInteger userIndex = [users indexOfObject:inputUsername];
            NSInteger passwordIndex = [passwords indexOfObject:inputPassword];
            
            if (userIndex == passwordIndex){
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:inputUsername forKey:@"username"];
                [self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self];
            }
            else {
                msg = @"Username and password don't match!";
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
        }
        else {
            msg = @"Invalid username or password!";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        msg = @"Please fill out all fields.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - UITextField Delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    activeField = nil;
}

- (bool)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard
- (void)registerForKeyboardNotifications {
    
    // tracks whether the keyboard is shown or not
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    // Get size of displayed keyboard
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Compute visible active field
    CGRect visibleActiveFieldRect = CGRectMake(activeField.frame.origin.x, activeField.frame.origin.y + kbSize.height, activeField.frame.size.width, activeField.frame.size.height+10);
    
    // Adjust scroll view content size
    self.loginView.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + kbSize.height);
    
    // Scroll to visible active field
    [self.loginView.scrollView scrollRectToVisible:visibleActiveFieldRect animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    // Reset the content size of the scroll view
    self.loginView.scrollView.contentSize = CGSizeMake(0.0, 0.0);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
