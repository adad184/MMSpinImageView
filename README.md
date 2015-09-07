MMSpinImageView
===============
[![CocoaPods](https://img.shields.io/cocoapods/v/MMSpinImageView.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/p/MMSpinImageView.svg)]()
[![CocoaPods](https://img.shields.io/cocoapods/l/MMSpinImageView.svg)]()

**MMSpinImageView** is UIView to display 360 degree spin photography.

![demo](https://github.com/adad184/MMSpinImageView/blob/master/Image/demo.gif?raw=true)


Usage
===============

There's 3 ways to use **MMSpinImageView**.

you can use datasource to provide your images.


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
	

or you can directly set the images array.

    
    @property (nonatomic, strong)   NSArray  *imagesArray;

and maybe you want to load images from zip file.( this feather depends on [zipzap](https://github.com/pixelglow/zipzap), you can remove relative methods if you don't need this)

    - (void)loadDataFromZip:(NSString*)path;
    
    
    
    
    
