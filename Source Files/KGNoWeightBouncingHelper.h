//
//  KGNoWeightBouncingHelper.h
//  NoWeightBouncingScrollView
//
//  Created by KumGa on 2016/02/10.
//  Copyright © 2016年 KumGa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGNoWeightBouncingHelper : UIView

// set > 0.
@property (nonatomic) CGFloat noBounceOffset;

// call it from delegate.
- (void)notifyWillBeginDragging:(UIScrollView *)scrollView;

// call it from delegate.
- (void)notifyDidScroll:(UIScrollView *)scrollView;
@end
