//
//  AppDelegate.m
//  TutorialKitExample
//
//  Created by Alex on 4/30/14.
//  Copyright (c) 2014 TutorialKit. All rights reserved.
//

#import "AppDelegate.h"
#import "ExampleViewController.h"
#import "TutorialKit.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ExampleViewController alloc] init];
    
    NSValue *msgPointTop = [NSValue valueWithCGPoint:
                         CGPointMake(0.5,0.20)];
    NSValue *msgPointBottom = [NSValue valueWithCGPoint:
                         CGPointMake(0.5,0.842)];

    NSValue *swipeStart = [NSValue valueWithCGPoint:
                           CGPointMake(0.75,0.8)];
    NSValue *swipeEnd = [NSValue valueWithCGPoint:
                           CGPointMake(0.25,0.8)];
    // set up a simple 3 step tutorial
    NSArray *steps = @[
                       // Step 0
                       @{
                           TKHighlightViewTag: @(1001),
                           TKMessage: @"First, press this button.",
                           TKDescription: @"First step description",
                           TKUseInfoDialog: @YES,
                           TKMessageRelativePoint: msgPointBottom,
                           TKStepType:[NSNumber numberWithInt:TKStepTypeButton]
                           },
                       // Step 1
                       @{
                           TKHighlightViewTag: @(1002),
                           TKSwipeGestureRelativeStartPoint: swipeStart,
                           TKSwipeGestureRelativeEndPoint: swipeEnd,
                           TKMessage: @"Next, swipe left.",
                           TKDescription: @"Second step description",
                           TKUseInfoDialog: @YES,
                           TKMessageRelativePoint: msgPointTop,
                           TKStepType:[NSNumber numberWithInt:TKStepTypeSwipe],
                           TKSwipeGestureDirection: [NSNumber numberWithUnsignedInteger:UISwipeGestureRecognizerDirectionLeft]
                           },
                       // Step 2
                       @{
                           TKMessage: @"That's it! Yer all done!",
                           TKDescription: @"Third step description",
                           TKButtonTitle: @"Done",
                           TKUseInfoDialog: @YES,
                           TKMessageRelativePoint: msgPointBottom,
                           TKStepType:[NSNumber numberWithInt:TKStepTypeNonAction],
                           TKCompleteCallback: ^{ NSLog(@"ALL DONE."); }
                           },
                       ];
    
    [TutorialKit addTutorialSequence:steps name:@"example"];
    
    // insert an extra step
    NSArray *moreSteps = @[
                           @{
                               TKHighlightViewTag: @(1001),
                               TKMessage: @"Please press this button again.",
                               TKDescription: @"Second One step description",
                               TKUseInfoDialog: @YES,
                               TKMessageRelativePoint: msgPointBottom,
                               TKStepType:[NSNumber numberWithInt:TKStepTypeButton]
                               },
                           ];
    [TutorialKit insertTutorialSequence:moreSteps name:@"example" beforeStep:2];
    
    // some optional defaults
    [TutorialKit setDefaultBlurAmount:0.5];
    [TutorialKit setDefaultMessageColor:[UIColor whiteColor]];
    [TutorialKit setDefaultTintColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
