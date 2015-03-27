//
//  CommonViewController.m
//  TutorialKitExample
//
//  Created by Mirko Olsiewicz on 07.03.15.
//  Copyright (c) 2015 TutorialKit. All rights reserved.
//

#import "TutorialKitBaseViewController.h"
#import "TutorialKit.h"
#import "TutorialKitView.h"

@interface TutorialKitBaseViewController (){
    BOOL _handleGesture;
}
@end

@implementation TutorialKitBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (TutorialKit.isTutorialModeActive) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
        tapRecognizer.delegate = self;
        [self.view addGestureRecognizer:tapRecognizer];
        
        UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHorizontalRecognizer:)];
        [swipeLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.view addGestureRecognizer:swipeLeftRecognizer];
        
        UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHorizontalRecognizer:)];
        [swipeRightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:swipeRightRecognizer];
        [TutorialKit advanceTutorialSequenceWithName:[TutorialKit getActiveTutorialName] andContinue:YES];
    }

    if (TutorialKit.isTutorialModeActive)
        [TutorialKit reEnableUserInteractionForDeactivatedViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(NSInteger)getTagForNextTutorialHighlightView{
    NSArray *steps = [TutorialKit getStepsForCurrentTutorial];
    
    NSInteger tag = 0;
    
    if (steps && [steps count] > 0 && [steps count] >= [TutorialKit currentStepForTutorialWithName:[TutorialKit getActiveTutorialName]]) {
        tag = [[(NSDictionary*)[steps objectAtIndex:[TutorialKit currentStepForTutorialWithName:[TutorialKit getActiveTutorialName]]] objectForKey:TKHighlightViewTag] integerValue];
    }
    
    return tag;
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
