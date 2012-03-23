#import "Pattern.h"

@class PredicateMatcher;

@interface PredicatePattern : Pattern

+ (PredicatePattern *)forScanner:(NSScanner *)scanner;
- (PredicateMatcher *)parse;

@end
