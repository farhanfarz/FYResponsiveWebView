//
//  ViewController.m
//  FYResponsiveWebView
//
//  Created by Farhan Yousuf on 28/06/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *localURL = [[NSBundle mainBundle] pathForResource:@"index_inline" ofType:@"html"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:localURL encoding:NSUTF8StringEncoding error:&error];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:localURL]];
    [_webView loadHTMLString:content baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *URL = [request URL];
    NSLog(@"%@",[URL absoluteString]);
    if ([[URL scheme] isEqualToString:@"applewebdata"]) {
        NSString *urlString = [[request URL] absoluteString];
        NSArray *urlParts = [urlString componentsSeparatedByString:@":"];
        //check to see if we just got the scheme
        if ([urlParts count] > 1) {
            NSArray *parameters = [[urlParts objectAtIndex:1] componentsSeparatedByString:@"#"];
            NSString *variableName = [parameters objectAtIndex:1];
            
            NSString *message = [NSString stringWithFormat:@"Button Clicked = %@",variableName];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Great!" message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
//            [self.webView stringByEvaluatingJavaScriptFromString:@"alert('.cal_events li a');"];

        }
    }
    
    return YES;
}

@end
