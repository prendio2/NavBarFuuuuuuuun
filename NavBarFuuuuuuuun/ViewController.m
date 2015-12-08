//
//  ViewController.m
//  NavBarFuuuuuuuun
//
//  Created by Oisin Prendiville on 07/12/2015.
//  Copyright © 2015 Oisin Prendiville. All rights reserved.
//

#import "ViewController.h"
#import "SUPTransitionController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (IBAction)unwind:(UIStoryboardSegue *)unwindSegue{}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.transitioningDelegate = self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[SUPTransitionController alloc] initWithOperation:SUPTransitionOperationShowAbove];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[SUPTransitionController alloc] initWithOperation:SUPTransitionOperationShowBelow];
}

@end
