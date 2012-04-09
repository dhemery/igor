#import "Pattern.h"

@protocol RelationshipMatcher;

@interface IgorQuery : Pattern

+ (IgorQuery *)forPattern:(NSString *)pattern;

- (id <RelationshipMatcher>)parse;


@end
