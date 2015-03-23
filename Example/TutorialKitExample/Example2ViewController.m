//
//  Example2ViewController.m
//  TutorialKitExample
//
//  Created by Mirko Olsiewicz on 20.03.15.
//  Copyright (c) 2015 TutorialKit. All rights reserved.
//

#import "Example2ViewController.h"
#import "TutorialKit.h"

@interface Example2ViewController ()
@property (nonatomic, weak) UIButton *nextButton;
@property (nonatomic, weak) UITextField *textField;
@end

@implementation Example2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // a reset button
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200.f, 60.f);
    [btn setTitle:@"NEXT STEP" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateHighlighted];
    btn.backgroundColor = [UIColor colorWithRed:0.8 green:0.3 blue:0.3 alpha:1.0];
    btn.layer.cornerRadius = 15.f;
    btn.tag = 1003;
    [btn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.nextButton = btn;
    
    UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 21)];
    [txt setBackgroundColor:[UIColor whiteColor]];
    
    [txt setPlaceholder:@"Type Text"];
    txt.tag = 1004;
    [self.view addSubview:txt];
    self.textField = txt;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
    CGPoint center = self.view.center;
    if(orientation == UIInterfaceOrientationLandscapeLeft ||
       orientation == UIInterfaceOrientationLandscapeRight) {
        center.x = self.view.center.y;
        center.y = self.view.center.x;
    }
    
    self.nextButton.center = CGPointMake(center.x, center.y * 0.5);
    
    self.textField.center = CGPointMake(center.x, self.nextButton.center.y + 80);
}

- (void)nextStep:(id)sender
{
    // Auto continue to the next step when the current step is over
    // The default is to not to continue automatically.
    //[TutorialKit advanceTutorialSequenceWithName:@"example" andContinue:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)repeatingBackground
{
    // a simple repeating background yo
    UIGraphicsBeginImageContext(CGSizeMake(32,32));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [UIColor.grayColor setStroke];
    CGContextStrokeEllipseInRect(ctx, CGRectMake(2,2,28,28));
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
