#import "Pattern.h"

@class ClassMatcher;
@class PatternScanner;

@interface ClassPattern : Pattern

+ (ClassPattern *)forScanner:(PatternScanner *)scanner;

- (ClassMatcher *)parse;

@end
