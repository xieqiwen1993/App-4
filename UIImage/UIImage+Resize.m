// UIImage+Resize.m
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import "UIImage+Alpha.h"

// Private helper methods
@interface UIImage ()
//- (UIImage *)resizedImage:(CGSize)newSize
//                transform:(CGAffineTransform)transform
//           drawTransposed:(BOOL)transpose
//     interpolationQuality:(CGInterpolationQuality)quality;
//- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
@end

@implementation UIImage (Resize)

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
//    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
//    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    return croppedImage;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage* croppedImage = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return croppedImage;
}

- (UIImage *)croppedImage:(CGRect)bounds scale:(CGFloat)scale {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage* croppedImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;

    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    
//	NSLog(@"resizedImageWithContentMode %f,%f",self.size.width,self.size.height);
	
	CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
	if (horizontalRatio > 1.0 && verticalRatio > 1.0) {
		ratio = 1.0;
	}
	else {
		switch (contentMode) {
			case UIViewContentModeScaleAspectFill:
				ratio = MAX(horizontalRatio, verticalRatio);
				break;
				
			case UIViewContentModeScaleAspectFit:
				ratio = MIN(horizontalRatio, verticalRatio);
				break;				
			default:
				[NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %zd", contentMode];
		}
	}

    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    return transform;
}

//- (UIImage *)resizedImageToSize:(CGSize)dstSize
//{
//	CGImageRef imgRef = self.CGImage;
//	// the below values are regardless of orientation : for UIImages from Camera, width>height (landscape)
//	CGSize  srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which is dependant on the imageOrientation)!
//    
//    /* Don't resize if we already meet the required destination size. */
//    if (CGSizeEqualToSize(srcSize, dstSize)) {
//        return self;
//    }
//    
//	CGFloat scaleRatio = dstSize.width / srcSize.width;
//	UIImageOrientation orient = self.imageOrientation;
//	CGAffineTransform transform = CGAffineTransformIdentity;
//	switch(orient) {
//            
//		case UIImageOrientationUp: //EXIF = 1
//			transform = CGAffineTransformIdentity;
//			break;
//            
//		case UIImageOrientationUpMirrored: //EXIF = 2
//			transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
//			transform = CGAffineTransformScale(transform, -1.0, 1.0);
//			break;
//            
//		case UIImageOrientationDown: //EXIF = 3
//			transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
//			transform = CGAffineTransformRotate(transform, M_PI);
//			break;
//            
//		case UIImageOrientationDownMirrored: //EXIF = 4
//			transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
//			transform = CGAffineTransformScale(transform, 1.0, -1.0);
//			break;
//            
//		case UIImageOrientationLeftMirrored: //EXIF = 5
//			dstSize = CGSizeMake(dstSize.height, dstSize.width);
//			transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
//			transform = CGAffineTransformScale(transform, -1.0, 1.0);
//			transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
//			break;
//            
//		case UIImageOrientationLeft: //EXIF = 6
//			dstSize = CGSizeMake(dstSize.height, dstSize.width);
//			transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
//			transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
//			break;
//            
//		case UIImageOrientationRightMirrored: //EXIF = 7
//			dstSize = CGSizeMake(dstSize.height, dstSize.width);
//			transform = CGAffineTransformMakeScale(-1.0, 1.0);
//			transform = CGAffineTransformRotate(transform, M_PI_2);
//			break;
//            
//		case UIImageOrientationRight: //EXIF = 8
//			dstSize = CGSizeMake(dstSize.height, dstSize.width);
//			transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
//			transform = CGAffineTransformRotate(transform, M_PI_2);
//			break;
//            
//		default:
//			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
//            
//	}
//    
//	/////////////////////////////////////////////////////////////////////////////
//	// The actual resize: draw the image on a new context, applying a transform matrix
//	UIGraphicsBeginImageContextWithOptions(dstSize, NO, self.scale);
//    
//	CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    if (!context) {
//        return nil;
//    }
//    
//	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
//		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
//		CGContextTranslateCTM(context, -srcSize.height, 0);
//	} else {
//		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
//		CGContextTranslateCTM(context, 0, -srcSize.height);
//	}
//    
//	CGContextConcatCTM(context, transform);
//    
//	// we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
//	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
//	UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//    
//	return resizedImage;
//}
//
//- (UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
//{
//	// get the image size (independant of imageOrientation)
//	CGImageRef imgRef = self.CGImage;
//	CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which depends on the imageOrientation)!
//    
//	// adjust boundingSize to make it independant on imageOrientation too for farther computations
//	UIImageOrientation orient = self.imageOrientation;
//	switch (orient) {
//		case UIImageOrientationLeft:
//		case UIImageOrientationRight:
//		case UIImageOrientationLeftMirrored:
//		case UIImageOrientationRightMirrored:
//			boundingSize = CGSizeMake(boundingSize.height, boundingSize.width);
//			break;
//        default:
//            // NOP
//            break;
//	}
//    
//	// Compute the target CGRect in order to keep aspect-ratio
//	CGSize dstSize;
//    
//	if ( !scale && (srcSize.width < boundingSize.width) && (srcSize.height < boundingSize.height) ) {
//		//NSLog(@"Image is smaller, and we asked not to scale it in this case (scaleIfSmaller:NO)");
//		dstSize = srcSize; // no resize (we could directly return 'self' here, but we draw the image anyway to take image orientation into account)
//	} else {
//		CGFloat wRatio = boundingSize.width / srcSize.width;
//		CGFloat hRatio = boundingSize.height / srcSize.height;
//        
//		if (wRatio < hRatio) {
//			//NSLog(@"Width imposed, Height scaled ; ratio = %f",wRatio);
//			dstSize = CGSizeMake(boundingSize.width, floorf(srcSize.height * wRatio));
//		} else {
//			//NSLog(@"Height imposed, Width scaled ; ratio = %f",hRatio);
//			dstSize = CGSizeMake(floorf(srcSize.width * hRatio), boundingSize.height);
//		}
//	}
//    
//	return [self resizedImageToSize:dstSize];
//}

@end
