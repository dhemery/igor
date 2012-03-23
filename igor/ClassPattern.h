#import "Pattern.h"

@class ClassMatcher;

@interface ClassPattern : Pattern

+ (ClassPattern *)forScanner:(NSScanner *)scanner;
- (ClassMatcher *)parse;

@end
