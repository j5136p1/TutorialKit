//
//  CommonViewController.m
//  TutorialKitExample
//
//  Created by Mirko Olsiewicz on 07.03.15.
//  Copyright (c) 2015 TutorialKit. All rights reserved.
//

#import "CommonViewController.h"
#import "TutorialKit.h"
#import "TutorialKitView.h"

@interface CommonViewController (){
    BOOL _handleGesture;
}
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHorizontalRecognizer:)];
    [swipeLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeftRecognizer];

    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHorizontalRecognizer:)];
    [swipeRightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRightRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapRecognizer:(UITapGestureRecognizer*) tapGesture{
    // Nothing
}

-(void)swipeHorizontalRecognizer:(UISwipeGestureRecognizer*) swipeGesture{
    
    if (_handleGesture) {
        
        if ([[[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKStepType] intValue] == TKStepTypeSwipe &&
            [[[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKSwipeGestureDirection] unsignedIntegerValue] == swipeGesture.direction) {
            [TutorialKit dismissCurrentTutorialView];
            [TutorialKit advanceTutorialSequenceWithName:[(TutorialKitView*)[TutorialKit currentTutorialView] sequenceName] andContinue:YES];
        }
        
    }
    
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (([TutorialKit currentTutorialView] && [[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKHighlightView] && touch.view == [[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKHighlightView]))
        _handleGesture = YES;
    else
        _handleGesture = NO;
    
    return _handleGesture;
}
@end
