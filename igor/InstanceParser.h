#import "InstanceMatcher.h"
@class IgorQueryScanner;

@interface InstanceParser

+ (InstanceMatcher *)parse:(IgorQueryScanner *)query;

@end
