//
//  SUPTransitionController.m
//  
//
//  Created by Oisin Prendiville on 9/23/13.
//
//

#import "SUPTransitionController.h"

@implementation SUPTransitionController

- (id)initWithOperation:(SUPTransitionOperation)operation
{
    if (self = [super init]) {
        _operation = operation;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.00f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toView.transform = CGAffineTransformIdentity;
    toView.frame = finalFrame;
    
    UIView *darkOverlay = [[UIView alloc] initWithFrame:finalFrame];
    darkOverlay.backgroundColor = [UIColor blackColor];
    CGFloat finalOverlayAlpha;
    CGFloat finalFromViewAlpha = 1.0f;
    CGFloat finalToViewAlpha = 1.0f;
    
    CGAffineTransform finalFromTransform;
    
    if (self.operation == SUPTransitionOperationShowAbove)
    {
        darkOverlay.alpha = 0.0f;
        finalOverlayAlpha = 1.0f;
        [[transitionContext containerView] addSubview:darkOverlay];
        
        toView.transform = CGAffineTransformMakeTranslation(0.0f, finalFrame.size.height);
        [[transitionContext containerView] addSubview:toView];
        
        finalFromTransform = CGAffineTransformMakeTranslation(0.0f, finalFrame.size.height);
    }
    else
    {
        toView.transform = CGAffineTransformMakeTranslation(0.0f, finalFrame.size.height);
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        
        darkOverlay.alpha = 1.0f;
        finalOverlayAlpha = 0.0f;
        [[transitionContext containerView] insertSubview:darkOverlay belowSubview:fromView];
        
        finalFromTransform = CGAffineTransformMakeTranslation(0.0f, finalFrame.size.height);
    }
    
    void (^animationBlock)(void) = ^{
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = finalFromTransform;
        toView.alpha = finalToViewAlpha;
        fromView.alpha = finalFromViewAlpha;
        darkOverlay.alpha = finalOverlayAlpha;
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished){
        [darkOverlay removeFromSuperview];
        [fromView removeFromSuperview];
        [transitionContext completeTransition:YES];
    };
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:animationBlock
                     completion:completionBlock];
    
}

@end
