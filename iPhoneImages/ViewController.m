//
//  ViewController.m
//  iPhoneImages
//
//  Created by Thomas Alexanian on 2016-11-21.
//  Copyright © 2016 Thomas Alexanian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (weak, nonatomic) IBOutlet UIButton *randomizeButton;
@property (nonatomic) NSURLSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://i.imgur.com/bktnImE.png"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration];
    
    [self createAndExecuteDownloadTask:url];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonTapped:(id)sender {
    int photoNo = arc4random_uniform(3);
    NSString *selectedPhoto;
    switch (photoNo) {
        case 0:
            selectedPhoto = @"http://i.imgur.com/bktnImE.png";
            break;
        case 1:
            selectedPhoto = @"http://i.imgur.com/zdwdenZ.png";
            break;
        case 2:
            selectedPhoto = @"http://i.imgur.com/y9MIaCS.png";
            break;
    }
    
    
    [self createAndExecuteDownloadTask:[NSURL URLWithString:selectedPhoto]];
}

-(void)createAndExecuteDownloadTask:(NSURL*)url{
   
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.iPhoneImageView.image = image;
        }];
    }];
    
    [downloadTask resume];
}


@end
