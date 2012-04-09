#import "Pattern.h"

@protocol ClassMatcher;
@class PatternScanner;

@interface ClassPattern : Pattern

+ (ClassPattern *)forScanner:(PatternScanner *)scanner;

- (id<ClassMatcher>)parse;

@end
