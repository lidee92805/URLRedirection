//
//  ViewController.m
//  URLRedirection
//
//  Created by lidehua on 15/6/9.
//  Copyright (c) 2015年 李德华. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)btnClick:(UIButton *)sender {
    [_textField resignFirstResponder];
    NSString * netString = _textField.text;
    if (![_textField.text hasPrefix:@"http"]) {
        netString = [@"http://" stringByAppendingString:netString];
    }
    NSURL * url = [NSURL URLWithString:netString];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
