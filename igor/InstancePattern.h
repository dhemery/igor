#import "Pattern.h"

@class InstanceMatcher;

@interface InstancePattern : Pattern

+ (InstancePattern *)forScanner:(PatternScanner *)scanner;

- (InstanceMatcher *)parse;

@end
