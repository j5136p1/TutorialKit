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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (TutorialKit.isTutorialModeActive) {
        [TutorialKit advanceTutorialSequenceWithName:[TutorialKit getActiveTutorialName] andContinue:YES];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (TutorialKit.isTutorialModeActive)
        [TutorialKit reEnableUserInteractionForDeactivatedViews];
    
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
            
            if (!TutorialKit.isAutoContinueStep){
                [[(TutorialKitView*)[TutorialKit currentTutorialView] nextButton] setHidden:NO];
                [TutorialKit setIsAutoContinueStep:NO];
            }else{
                [TutorialKit dismissCurrentTutorialView];
                [TutorialKit advanceTutorialSequenceWithName:[TutorialKit getActiveTutorialName] andContinue:YES];
            }
        }
        
    }
    
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (([TutorialKit currentTutorialView] && [[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKHighlightView] &&
         ([touch.view isKindOfClass:[[[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKHighlightView] class]] &&  touch.view.tag == [[[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKHighlightView] tag]))){
        
        if (!TutorialKit.isAutoContinueStep && [[(TutorialKitView*)[TutorialKit currentTutorialView] nextButton] isHidden] && [[[(TutorialKitView*)[TutorialKit currentTutorialView] values] objectForKey:TKStepType] intValue] != TKStepTypeSwipe){
            [[(TutorialKitView*)[TutorialKit currentTutorialView] nextButton] setHidden:NO];
            [TutorialKit setIsAutoContinueStep:NO];
            _handleGesture = NO;
        }else
            _handleGesture = YES;
        
    }else
        _handleGesture = NO;
    
    return _handleGesture;
}
@end
