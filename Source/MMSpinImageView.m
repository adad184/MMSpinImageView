//
//  HMspinImageView.m
//  museum
//
//  Created by Ralph Li on 12/25/13.
//  Copyright (c) 2013 hnmuseum. All rights reserved.
//

#import "MMSpinImageView.h"

@interface MMSpinImageView()
<
MMSpinImageViewDelegate,
MMSpinImageViewDatasource,
UIGestureRecognizerDelegate
>

@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign) CGPoint   touchPoint;
@property (nonatomic, assign) NSInteger touchIndex;

@end

@implementation MMSpinImageView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.imageView];
        
        _panDistance = 20;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPan:)];
        panGesture.maximumNumberOfTouches = 1;
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [self reloadData];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if ( self.dataSource )
    {
        _currentIndex = currentIndex;
        self.imageView.image = (currentIndex>=self.imageCount)?nil:[self.dataSource spinImageView:self imageAtIndex:currentIndex];
    }
    else
    {
        _currentIndex = 0;
    }
    
}

- (UIImage *)currentImage
{
    if ( self.dataSource )
    {
        return [self.dataSource spinImageView:self imageAtIndex:self.currentIndex];
    }
    
    return nil;
}

- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    self.dataSource = self;
    
    [self reloadData];
}

#pragma mark data

- (void)reloadData
{
    if ( self.dataSource )
    {
        self.imageCount = [self.dataSource numberOfViewsInspinImageView:self];
        self.currentIndex = 0;
    }
    
}

- (void)loadDataFromZip:(NSString *)path
{
    if ( !path )
    {
        return;
    }
    
    __weak __typeof(&*self)weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        ZZArchive* oldArchive = [ZZArchive archiveWithContentsOfURL:[NSURL fileURLWithPath:path]];
        
        if ( oldArchive.entries.count == 0 )
        {
            if ( [weakSelf.delegate respondsToSelector:@selector(spinImageViewFailedLoadData:)] )
            {
                [weakSelf.delegate spinImageViewFailedLoadData:weakSelf];
            }
            
            return;
        }
        
        if ( [weakSelf.delegate respondsToSelector:@selector(spinImageViewBeginLoadData:)] )
        {
            [weakSelf.delegate spinImageViewBeginLoadData:weakSelf];
        }
        
        NSMutableArray *array = [NSMutableArray array];
        
        for ( ZZArchiveEntry *entry in oldArchive.entries )
        {
            //avoid the damn __MACOS problem on mac
            if ( [entry.fileName rangeOfString:@"/"].location != NSNotFound )
            {
                continue;
            }
            
            NSData *data = [entry newData];
            
            UIImage * image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
            
            [array addObject:image];
        }
        
        dispatch_async (dispatch_get_main_queue (), ^{
            
            if ( !weakSelf )
            {
                return;
            }
            
            weakSelf.dataSource = weakSelf;
            weakSelf.imagesArray = array;
            
            if ( [weakSelf.delegate respondsToSelector:@selector(spinImageViewEndLoadData:)] )
            {
                [weakSelf.delegate spinImageViewEndLoadData:weakSelf];
            }
        });
        
    });
    
}

#pragma mark dataSource

- (UIImage *)spinImageView:(MMSpinImageView *)view imageAtIndex:(NSInteger)index
{
    return self.imagesArray[index];
}

- (NSInteger)numberOfViewsInspinImageView:(MMSpinImageView *)spinImageView
{
    return self.imagesArray.count;
}

#pragma mark gesture

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] )
    {
        return self.imageCount > 1;
    }
    
    if ( [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] )
    {
        return self.imageCount > 0;
    }
    return NO;
}

- (void)actionPan:(UIPanGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.touchIndex = self.currentIndex;
            self.touchPoint = [gesture locationInView:self];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint pt = [gesture locationInView:self];
            
            double offset = pt.x - self.touchPoint.x;
            
            NSInteger index = (int)(((offset+self.panDistance/2.0f) + (1000*self.panDistance) )/ self.panDistance) - 1000 + self.touchIndex;
            
            if ( index != self.currentIndex )
            {   
                self.currentIndex = (index + self.imageCount*1000) % self.imageCount;
            }
            
            break;
        }
            
        default:
            break;
    }
}

- (void)actionTap:(UIPanGestureRecognizer*)gesture
{
    if ( [self.delegate respondsToSelector:@selector(spinImageView:didSelectAtIndex:)] )
    {
        [self.delegate spinImageView:self didSelectAtIndex:self.currentIndex];
    }
}

@end
