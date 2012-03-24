#import "Pattern.h"

@class PredicateMatcher;

@interface PredicatePattern : Pattern

+ (PredicatePattern *)forScanner:(PatternScanner *)scanner;

- (PredicateMatcher *)parse;

@end
