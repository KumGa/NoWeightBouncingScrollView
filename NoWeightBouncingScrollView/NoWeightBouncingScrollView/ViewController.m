//
//  ViewController.m
//  NoWeightBouncingScrollView
//
//  Created by KumGa on 2016/02/10.
//  Copyright © 2016年 KumGa. All rights reserved.
//

#import "ViewController.h"
#import "KGNoWeightBouncingHelper.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;
@end

@implementation ViewController {
    KGNoWeightBouncingHelper *_helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _helper = [[KGNoWeightBouncingHelper alloc]init];
    _helper.noBounceOffset = 300;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                        action:@selector(refresh:)
              forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"refresh"];
    [self.collectionView addSubview:self.refreshControl];
    self.refreshControl.layer.zPosition = -1;
}

- (void)refresh:(id)sender{
    [self.refreshControl beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 500;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
}

#pragma - mark UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_helper notifyWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_enableSwitch.isOn) {
        [_helper notifyDidScroll:scrollView];
    }
}

@end
