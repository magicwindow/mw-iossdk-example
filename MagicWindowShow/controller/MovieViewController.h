//
//  MovieViewController.h
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/21/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
- (IBAction)shareButtonClicked:(id)sender;

@end
