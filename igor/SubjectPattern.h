#import "Pattern.h"

@class Matcher;

@interface SubjectPattern : Pattern

+ (SubjectPattern *)forScanner:(NSScanner *)scanner;
- (Matcher *)parse;

@end
