//
//  SMRCVSliderStyle1LayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle1LayoutController.h"
#import "SMRCVSliderStyle1Layout.h"

@interface SMRCVSliderStyle1LayoutController ()

@end

@implementation SMRCVSliderStyle1LayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionViewHeight = 300;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView.collectionViewLayout resetPageIndexForLoopable:self.dataSource.count];
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [collectionView.collectionViewLayout itemsCountForLoopable:self.dataSource.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.collectionView.collectionViewLayout resetPageIndexForLoopableIfNeeded:self.dataSource.count];
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderStyle1Layout *layout = [[SMRCVSliderStyle1Layout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(340, 260);
    layout.visibleItemsCount = 3;
    layout.spacing = 20;
    layout.minScale = 0.7;
    layout.itemOffset = CGPointMake(-20, 0);
    return layout;
}

@end
