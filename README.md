MMSpinImageView
===============

**MMSpinImageView** is UIView to display 360 degree spin photography with simple 

![demo](https://github.com/adad184/MMSpinImageView/blob/master/Image/demo.gif?raw=true)


Usage
===============

There's 3 ways to use **MMSpinImageView**.

you can use datasource to provide your images.


	@protocol HMSpinImageViewDelegate <NSObject>
	
	@optional
	
	- (void)spinImageView:(MMSpinImageView*)view didSelectAtIndex:(NSInteger)index;
	- (void)spinImageViewBeginLoadData:(MMSpinImageView*)view;
	- (void)spinImageViewEndLoadData:(MMSpinImageView*)view;
	- (void)spinImageViewFailedLoadData:(MMSpinImageView*)view;
	
	@end
	
	@protocol HMSpinImageViewDatasource <NSObject>
	
	- (UIImage *)spinImageView:(MMSpinImageView *)view imageAtIndex:(NSInteger)index;
	
	@optional
	- (NSInteger)numberOfViewsInspinImageView:(MMSpinImageView *)spinImageView;
	
	@end
	

or you can directly set the images array.

    
    @property (nonatomic, strong)   NSArray  *imagesArray;

and maybe you want to load images from zip file.

    - (void)loadDataFromZip:(NSString*)path;
    
    
    
    
    