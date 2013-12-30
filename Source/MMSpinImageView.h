//
//  HMspinImageView.h
//  museum
//
//  Created by Ralph Li on 12/25/13.
//  Copyright (c) 2013 hnmuseum. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMSpinImageView;

@protocol MMSpinImageViewDelegate <NSObject>

@optional

- (void)spinImageView:(MMSpinImageView*)view didSelectAtIndex:(NSInteger)index;
- (void)spinImageViewBeginLoadData:(MMSpinImageView*)view;
- (void)spinImageViewEndLoadData:(MMSpinImageView*)view;
- (void)spinImageViewFailedLoadData:(MMSpinImageView*)view;

@end

@protocol MMSpinImageViewDatasource <NSObject>

- (UIImage *)spinImageView:(MMSpinImageView *)view imageAtIndex:(NSInteger)index;

@optional
- (NSInteger)numberOfViewsInspinImageView:(MMSpinImageView *)spinImageView;

@end


@interface MMSpinImageView : UIView

@property (nonatomic, weak) id<MMSpinImageViewDelegate> delegate;
@property (nonatomic, weak) id<MMSpinImageViewDatasource> dataSource;

@property (nonatomic, readonly) UIImageView *imageView;

@property (nonatomic, strong)   NSArray  *imagesArray;
@property (nonatomic, readonly) UIImage  *currentImage;
@property (nonatomic, assign)   NSInteger currentIndex;
@property (nonatomic, assign)   double panDistance;

- (void)reloadData;
- (void)loadDataFromZip:(NSString*)path;

@end
