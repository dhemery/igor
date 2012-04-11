#import "InstanceMatcher.h"
@class IgorQueryScanner;

@interface InstanceParser

+ (InstanceMatcher *)instanceMatcherFromQuery:(IgorQueryScanner *)query;

@end
