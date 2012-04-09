#import "Pattern.h"

@protocol RelationshipMatcher;

@interface RelationshipPattern : Pattern

+ (RelationshipPattern *)forScanner:(PatternScanner *)scanner;

- (id <RelationshipMatcher>)parse;

@end
