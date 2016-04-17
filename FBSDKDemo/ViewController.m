//
//  ViewController.m
//  FBSDKDemo
//
//  Created by Ravin Kohli on 27/02/16.
//  Copyright © 2016 Ravin Kohli. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKProfile.h>

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UIButton *myLoginButton;
@property (nonatomic) FBSDKProfile *profile;

@end

@implementation ViewController

@synthesize segmentControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add a custom login button to your app
    if (!self.profile) {
    self.myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.myLoginButton.backgroundColor=[UIColor blueColor];
    self.myLoginButton.frame=CGRectMake(0,0,180,40);
    self.myLoginButton.center = self.view.center;
    [self.myLoginButton setTitle: @"Login" forState: UIControlStateNormal];
    // Handle clicks on the button
    [self.myLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Add the button to the view
    [self.view addSubview:self.myLoginButton];
}
}
-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             
         } else {
             NSLog(@"Logged in");
             self.profile = [FBSDKProfile currentProfile];
             NSLog(@"%@",self.profile);
             [self.myLoginButton removeFromSuperview];
             [self loginButtonDidClick];
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/382057938566656/feed" parameters:[NSDictionary dictionaryWithObjects:@[[FBSDKAccessToken currentAccessToken]] forKeys:@[@"access_token"]]]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                         // NSLog(@"fetched user:%@", result);
                          self.postArray = [result objectForKey:@"data"];
                        //  [self loadDCESpeaksUp];

                      }
                  }];
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:@"/382057938566656/photos"
                                               parameters:[NSDictionary dictionaryWithObjects:@[@"data,paging",[FBSDKAccessToken currentAccessToken]] forKeys:@[@"fields",@"access_token"]]
                                               HTTPMethod:@"GET"];
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result,
                                                       NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", [result class]);
                         
                         NSDictionary *photoDictionary = (NSDictionary *)result;
                         NSLog(@"%@",photoDictionary);
                         self.photoArray = [photoDictionary objectForKey:@"data"];
                         //NSLog(@"%@",self.photoArray[0]);
                         NSLog(@"id");
                         //NSLog(@"%@",self.photoArray);
//                         for(NSDictionary *id in self.photoArray){
//                             
//                             NSLog(@"id %@",[id objectForKey:@"id"]);
//                             [self.photosArray addObject:[id objectForKey:@"id"]];
//                             
//                         }
//                         NSLog(@"%@ photos",self.photosArray);
//                         FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                                       initWithGraphPath:[NSString stringWithFormat:@"/%@",[[self.photoArray objectAtIndex:1]objectForKey:@"id"]]
//                                                       parameters:[NSDictionary dictionaryWithObjects:@[@"created_time,images,name,picture",[FBSDKAccessToken currentAccessToken]]forKeys:@[@"fields",@"access_token"]]
//                                                       HTTPMethod:@"GET"];
//                         [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                                               id result,
//                                                               NSError *error) {
//                             // Handle the result
//                             NSLog(@"%@",result);
//                         }];
                     }
                 }];

             }
             CGRect myFrame = CGRectMake(30.0f, 30.0f, 300.0f, 40.0f);
             NSArray *mySegments = [[NSArray alloc] initWithObjects: @"Photos",
                                    @"Text", nil];
             self.segmentControl = [[UISegmentedControl alloc] initWithItems:mySegments];
             self.segmentControl.frame = myFrame;
             [self.segmentControl setSelectedSegmentIndex:0];
             [self.segmentControl addTarget:self action:@selector(whichColor:) forControlEvents:UIControlEventValueChanged];
             
             //add the control to the view
             [self.view addSubview:self.segmentControl];
         }
     }];
}
- (void) whichColor:(UISegmentedControl *)paramSender{
    
    //check if its the same control that triggered the change event
    if ([paramSender isEqual:self.segmentControl]){
        
        //get index position for the selected control
        NSInteger selectedIndex = [paramSender selectedSegmentIndex];
        
        //get the Text for the segmented control that was selected
        NSString *myChoice = [paramSender titleForSegmentAtIndex:selectedIndex];
        //let log this info to the console
        NSLog(@"Segment at position %li with %@ text is selected",
              (long)selectedIndex, myChoice);
    }
}

-(void)loginButtonDidClick{
    [[NSNotificationCenter defaultCenter] addObserverForName:FBSDKProfileDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //do whatever you want
            }];
    for (int i=0; i<13020349; i++) {
    //
    }
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(30.0f, 100.0f,self.view.frame.size.width-50, self.view.frame.size.height-100) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if(segmentControl.selectedSegmentIndex ==0){
    NSLog(@"id");
   // NSLog(@"%@ bafafasfasf",[self.photoArray description]);
        NSLog(@"ijghafsfgnd");

        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:[NSString stringWithFormat:@"/%@",[[self.photoArray objectAtIndex:indexPath.row]objectForKey:@"id"]]
                                      parameters:[NSDictionary dictionaryWithObjects:@[@"created_time,images,name,picture",[FBSDKAccessToken currentAccessToken]]forKeys:@[@"fields",@"access_token"]]
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            // Handle the result
            NSLog(@"zoozoozoozozoooozo");
            NSString *photoString = [(NSDictionary *)result objectForKey:@"picture"];
            NSURL *photoURL = [NSURL URLWithString:photoString];
            NSData *photoData = [NSData dataWithContentsOfURL:photoURL];
            self.photo = [UIImage imageWithData:photoData];
            NSLog(@"%@",photoData);

            UIImageView *photoView = [[UIImageView alloc] initWithImage:self.photo];
            cell.backgroundView = [[UIImageView alloc] initWithImage:self.photo];
            [self.view addSubview:photoView];
            cell.backgroundColor = [UIColor colorWithPatternImage:self.photo];
            NSLog(@"%@",error);
        }];
        return cell;
    }
    return nil;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.photoArray.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return self.photo.size;
}
//-(void)loadDCESpeaksUp{
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:[NSString stringWithFormat:@"/%@/posts",[self.postArray objectForKey:@"id"]] parameters:[NSDictionary dictionaryWithObjects:@[@"posts",[FBSDKAccessToken currentAccessToken]] forKeys:@[@"fields",@"access_token"]]]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
//             }
//         }];
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
