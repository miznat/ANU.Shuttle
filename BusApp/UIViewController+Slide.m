//
//  UIViewController+Slide.m
//  Campus
//
//  Created by Кирилл on 23.05.14.
//  Copyright (c) 2014 Dve Bukvy. All rights reserved.
//

#import "UIViewController+Slide.h"
#import "ECSlidingViewController.h"

@implementation UIViewController (Slide)

- (void)menuButtonTapped
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionCentered) {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }else{
        [self.slidingViewController resetTopViewAnimated:YES];
    }
}

- (ECSlidingViewController *)slidingViewController
{
    UIViewController *viewController = self.parentViewController ? self.parentViewController : self.presentingViewController;
    while (! (viewController == nil || [viewController isKindOfClass:[ECSlidingViewController class]])) {
        viewController = viewController.parentViewController ?: viewController.presentingViewController;
    }
    return (ECSlidingViewController *)viewController;
}


@end
