//
//  KGNoWeightBouncingHelper.m
//  NoWeightBouncingScrollView
//
//  Created by KumGa on 2016/02/10.
//  Copyright © 2016年 KumGa. All rights reserved.
//

#import "KGNoWeightBouncingHelper.h"

@implementation KGNoWeightBouncingHelper {
    BOOL _adjusting;
    CGPoint _startOffset;
    UIEdgeInsets _startInset;
}

- (void)notifyWillBeginDragging:(UIScrollView *)scrollView {
    _startOffset = scrollView.contentOffset;
    _startInset = scrollView.contentInset;
}


- (void)notifyDidScroll:(UIScrollView *)scrollView {
    if (_adjusting) {
        return;
    }
    CGFloat bounceDistance = scrollView.contentOffset.y + _startInset.top;
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    if (bounceDistance < 0 && pan.state == UIGestureRecognizerStateChanged) {
        
        CGFloat offsetD = scrollView.contentOffset.y - _startOffset.y;
        CGFloat gestureD = - [pan translationInView:scrollView].y;
        CGFloat add = gestureD - offsetD;
        
        // bounce
        CGFloat panFromEdge = [pan translationInView:scrollView].y - _startOffset.y+_startInset.top;
        if (panFromEdge - _noBounceOffset > 0) {
            CGFloat bounce = (panFromEdge - _noBounceOffset) / 2;
            add += bounce;
        }
        
        _adjusting = YES;
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x,
                                               scrollView.contentOffset.y+add);
        _adjusting = NO;
    }
}

@end
