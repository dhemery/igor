#import "InstanceMatcher.h"
@protocol IgorQueryScanner;

@interface InstanceParser

+ (InstanceMatcher *)instanceMatcherFromQuery:(id<IgorQueryScanner>)query;

@end
