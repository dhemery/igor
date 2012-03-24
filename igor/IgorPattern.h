#import "Pattern.h"

@protocol RelationshipMatcher;

@interface IgorPattern : Pattern

+ (IgorPattern *)forPattern:(NSString *)pattern;

- (id <RelationshipMatcher>)parse;


@end
