//
//  ViewController.m
//  NoWeightBouncingScrollView
//
//  Created by KumGa on 2016/02/10.
//  Copyright © 2016年 KumGa. All rights reserved.
//

#import "ViewController.h"
#import "KGNoWeightBouncingHelper.h"

@interface ViewController ()

@end

@implementation ViewController {
    KGNoWeightBouncingHelper *_helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _helper = [[KGNoWeightBouncingHelper alloc]init];
    _helper.noBounceOffset = 300;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"refresh"];
    self.refreshControl = refreshControl;
}

- (void)refresh:(id)sender{
    [self.refreshControl beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma - mark UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_helper notifyWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_helper notifyDidScroll:scrollView];
}

@end
