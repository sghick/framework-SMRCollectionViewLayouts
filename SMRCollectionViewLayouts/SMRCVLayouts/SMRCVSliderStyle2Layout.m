//
//  SMRCVSliderStyle2Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle2Layout.h"
#import "UICollectionViewLayout+SMR.h"

@implementation SMRCVSliderStyle2Layout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.scaleRate = 1.4;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    CGSize size = [super collectionViewContentSize];
    CGFloat width =
    self.itemSize.width*self.itemsCount +
    self.minimumInteritemSpacing*(self.itemsCount - 1) +
    (self.collectionViewSize.width - self.itemSize.width);
    return CGSizeMake(width, size.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [self attributesInSection:0];
    return arr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 在原有布局属性的基础上，进行微调
    UICollectionViewLayoutAttributes *attrs =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    CGFloat scaleRate = self.scaleRate;
    CGFloat contentMargin = self.p_contentMargin;
    CGSize collectionViewSize = self.collectionViewSize;
    CGPoint contentOffset = self.contentOffset;
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = contentOffset.x + collectionViewSize.width*0.5 - contentMargin;
    CGFloat centerY = collectionViewSize.height*0.5;
    // cell的中心点x 和 collectionView最中心点的x值 的间距
    CGFloat delta = fabs(attrs.center.x - centerX);
    // 根据间距值 计算 cell的缩放比例
    CGFloat scale = delta / collectionViewSize.width*scaleRate;
    //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
    scale = fabs(cos(scale * M_PI/4));
    // 设置缩放比例
    attrs.transform = CGAffineTransformMakeScale(1, scale);
    // 设置中心位置
    attrs.center = CGPointMake(contentMargin + attrs.center.x, centerY);
    return attrs;
}

#pragma mark - Privates

- (CGFloat)p_contentMargin {
    return (self.collectionViewSize.width - self.itemSize.width)/2;
}

//- (NSInteger)currentPage {
//    if (self.collectionViewSize.width == 0 || self.collectionViewSize.height == 0) {
//        return 0;
//    }
//
//    int index = 0;
//    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//        index = (self.contentOffset.x + self.itemSize.width * 0.5) / self.itemSize.width;
//    } else {
//        index = (self.contentOffset.y + self.itemSize.height * 0.5) / self.itemSize.height;
//    }
//    return MAX(0, index);
//}

@end
