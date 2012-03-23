
#import "Pattern.h"

@class Matcher;

@interface IgorPattern : Pattern

+ (IgorPattern *)forPattern:(NSString *)pattern;
- (Matcher *)parse;


@end
