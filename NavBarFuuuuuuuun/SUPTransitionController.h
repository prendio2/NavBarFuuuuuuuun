//
//  SUPTransitionController.h
//  
//
//  Created by Oisin Prendiville on 9/23/13.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SUPTransitionOperation) {
    SUPTransitionOperationShowAbove,
    SUPTransitionOperationShowBelow
};

@interface SUPTransitionController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) SUPTransitionOperation operation;
- (id)initWithOperation:(SUPTransitionOperation)operation;

@end
