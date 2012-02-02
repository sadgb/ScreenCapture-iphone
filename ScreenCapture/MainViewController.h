//
//  MainViewController.h
//  ScreenCapture
//
//  Created by Aliksandr Andrashuk on 01.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController<UIWebViewDelegate>
{

    IBOutlet UIWebView *m_webView;
    IBOutlet UITextField *m_urlTextField;
}

- (IBAction)captureButtonTouched:(id)sender;
- (IBAction)loadButtonTouched:(id)sender;



@end
