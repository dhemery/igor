
#import "Pattern.h"

@class Matcher;
@protocol RelationshipMatcher;

@interface IgorPattern : Pattern

+ (IgorPattern *)forPattern:(NSString *)pattern;
- (id<RelationshipMatcher>)parse;


@end
