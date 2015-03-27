//
//  CommonViewController.h
//  TutorialKitExample
//
//  Created by Mirko Olsiewicz on 07.03.15.
//  Copyright (c) 2015 TutorialKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialKitBaseViewController : UIViewController<UIGestureRecognizerDelegate>

+(NSInteger)getTagForNextTutorialHighlightView;

@end
