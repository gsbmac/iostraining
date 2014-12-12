//
//  MBBPostViewController.m
//  MacBulletinBoard
//
//  Created by Mac on 12/10/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "MBBPostViewController.h"
#import "Comment.h"

@interface MBBPostViewController () {
    NSMutableArray *com_users;
    NSMutableArray *com_posts;
    NSMutableArray *comments;
}
@end

@implementation MBBPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self initializeContents];
}

- (NSArray*)getAllPost {
    // with predicate
     
     AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Comment"];
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     //NSString *username = [defaults objectForKey:@"user"];
     NSString *title = [defaults objectForKey:@"title"];
    
     // Create Predicate
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"title", title];
     [fetchRequest setPredicate:predicate];
     
     // Execute Fetch Request
     NSError *fetchError = nil;
     NSArray *result = [ad.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    
     return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeContents {
    self.postView = (MBBPostView*)[self getCustomXibUsingXibName:@"PostView"];
    self.postView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    
    // Set delegates
    self.postView.delegate = self;
    self.postView.commentTable.delegate = self;
    self.postView.commentTable.dataSource = self;
    self.postView.commentField.text = @"Comment here";
    
    // Init nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults objectForKey:@"title"];
    NSString *post = [defaults objectForKey:@"post"];
    NSString *user = [defaults objectForKey:@"user"];
    
    self.postView.titleLabel.text = title;
    self.postView.postLabel.text = post;
    self.postView.userLabel.text = [NSString stringWithFormat:@"%@ %@", @"Posted by: ", user];
    
    if ([user isEqualToString:@"mac"]) {
        self.postView.profilePicture.image = [UIImage imageNamed:@"icon"];
    }
    else {
        self.postView.profilePicture.image = [UIImage imageNamed:@"user"];
    }
    
    [self.view addSubview:self.postView];
}

- (void) addCommentButtonPressed {
    // get textfield value
    
    if ([self.postView.commentField.text isEqualToString:@"Comment here"]) {
        NSString *msg = @"Please insert a comment!";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else {
    
        NSString *comment = self.postView.commentField.text;
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *title = [defaults objectForKey:@"title"];
        NSString *username = [defaults objectForKey:@"username"];
     
        AppDelegate *ad = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     
        NSEntityDescription *entityComment = [NSEntityDescription entityForName:@"Comment" inManagedObjectContext:ad.managedObjectContext];
        NSManagedObject *newComment = [[NSManagedObject alloc] initWithEntity:entityComment insertIntoManagedObjectContext:ad.managedObjectContext];
     
        [newComment setValue:comment forKey:@"comment_text"];
        [newComment setValue:username forKey:@"user"];
        [newComment setValue:title forKey:@"title"];
     
        NSError *error = nil;
     
        if (![newComment.managedObjectContext save:&error]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error, error.localizedDescription);
        }
    
        self.postView.commentField.text = @"";
        [self.postView.commentTable reloadData];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.postView.commentField.text = @"";
    [self.postView.commentField reloadInputViews];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSMutableArray *persistentTitles = [[defaults arrayForKey:@"titles"] mutableCopy];
    //return persistentTitles.count;
    return [self getAllPost].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // check which tableView is currently using this delegate method
    if (tableView == self.postView.commentTable) {
        
        MBBCommentTableViewCell *postCell = (MBBCommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        
        if (postCell == nil) {
            postCell = [[[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:nil options:nil] objectAtIndex:0];
        }
        
        Comment *comment = [[self getAllPost] objectAtIndex:indexPath.row];
        
        NSString *uname = [NSString stringWithFormat:@"%@%@ %@", comment.user, @":", comment.comment_text];
        postCell.commentLabel.text = uname;
        
        return postCell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
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
