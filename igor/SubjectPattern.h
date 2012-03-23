#import "Pattern.h"

@class Matcher;

@interface SubjectPattern : Pattern

+ (SubjectPattern *)forScanner:(PatternScanner *)scanner;
- (Matcher *)parse;

@end
