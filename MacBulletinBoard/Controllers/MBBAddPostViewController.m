//
//  MBBAddPostViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBAddPostViewController.h"

@interface MBBAddPostViewController () {
    UITextField *activeField;
}
@end

@implementation MBBAddPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    self.addPostView = (MBBAddPostView*)[self getCustomXibUsingXibName:@"AddPostView"];
    self.addPostView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    // set delegates
    self.addPostView.delegate = self;
    self.addPostView.titleInput.delegate = self;
    self.addPostView.postInput.delegate = self;

    self.navigationItem.hidesBackButton = YES; // hides the back button
    [self.view addSubview:self.addPostView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard {
    [self.addPostView.titleInput resignFirstResponder];
    [self.addPostView.postInput resignFirstResponder];
}

- (void)addPostButtonPressed{
    
    // get textfield value
    
    NSString *title = self.addPostView.titleInput.text;
    NSString *body = self.addPostView.postInput.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
    
    AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSEntityDescription *entityPost = [NSEntityDescription entityForName:@"Post" inManagedObjectContext:ad.managedObjectContext];
    NSManagedObject *newPost = [[NSManagedObject alloc] initWithEntity:entityPost insertIntoManagedObjectContext:ad.managedObjectContext];
    
    [newPost setValue:title forKey:@"title"];
    [newPost setValue:body forKey:@"body"];
    [newPost setValue:username forKey:@"user"];
    
    NSError *error = nil;
    
    if (![newPost.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    // =============================================================================
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    //[self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self];
    
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user = [defaults objectForKey:@"username"];
    NSMutableArray *persistenTitles = [[defaults arrayForKey:@"titles"] mutableCopy];
    NSMutableArray *persistentPosts = [[defaults arrayForKey:@"posts"] mutableCopy];
    NSMutableArray *persistentUsers = [[defaults arrayForKey:@"users"] mutableCopy];
    
    NSString *inputTitle = self.addPostView.titleInput.text;
    NSString *inputPost = self.addPostView.postInput.text;
    
    
    // Init arrays
    [persistenTitles addObject:inputTitle];
    [persistentPosts addObject:inputPost];
    [persistentUsers addObject:user];
    
    // Store arrays to NSUserDefaults
    [defaults setObject:persistenTitles forKey:@"titles"];
    [defaults setObject:persistentPosts forKey:@"posts"];
    [defaults setObject:persistentUsers forKey:@"users"];*/
    
    //[self.homeView.postTableView reloadData];
    
    // =============================================================================
}

- (void)cancelButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
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
    self.addPostView.addPostScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + kbSize.height);
    
    // Scroll to visible active field
    [self.addPostView.addPostScrollView scrollRectToVisible:visibleActiveFieldRect animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    // Reset the content size of the scroll view
    self.addPostView.addPostScrollView.contentSize = CGSizeMake(0.0, 0.0);
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
