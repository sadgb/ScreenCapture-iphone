//
//  MainViewController.m
//  ScreenCapture
//
//  Created by Aliksandr Andrashuk on 01.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [m_urlTextField release];
    m_urlTextField = nil;
    [m_webView release];
    m_webView = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)dealloc {
    [m_urlTextField release];
    [m_webView release];
    [super dealloc];
}
- (IBAction)captureButtonTouched:(id)sender
{
    static int screenNum = 1;
    
    UIScrollView* webScrollView = nil;
    UIView* browerWebView = nil;
    
    
    for (UIView* v in m_webView.subviews) {
        if ( [v class] == NSClassFromString(@"_UIWebViewScrollView") )
        {            
            webScrollView = (UIScrollView *) [v retain];
            for (UIView* vv in v.subviews) {
                
                if ( [vv class] == NSClassFromString(@"UIWebBrowserView") )
                {
                    
                    browerWebView = [vv retain];
                }
            }
        }
    }
    
    
   
    UIGraphicsBeginImageContext(browerWebView.bounds.size);
    [browerWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* data = UIImagePNGRepresentation(viewImage);
    [data writeToFile:[NSString stringWithFormat:@"%@/Documents/Screen_%d.png",NSHomeDirectory(),screenNum++] atomically:YES];

    
    [browerWebView release];
    [webScrollView release];
}

- (IBAction)loadButtonTouched:(id)sender
{
    [m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:m_urlTextField.text]]];
    [m_urlTextField resignFirstResponder];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
@end
