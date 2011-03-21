/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
}


-(void)hideActivityIndicator{
	UIActivityIndicatorView *actInd = (UIActivityIndicatorView *)[self viewWithTag:999];
	[actInd stopAnimating];
}

-(void)showActivityIndicator{
	
	UIActivityIndicatorView *actInd = (UIActivityIndicatorView*)[self viewWithTag:999] ;
	
	if (actInd == nil) {
		actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		actInd.tag = 999;
		actInd.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
		actInd.hidesWhenStopped = YES;
		[self addSubview:actInd];
		[actInd release];
		
	}
	[actInd startAnimating];
	
}


@end
