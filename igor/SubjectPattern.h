#import "Pattern.h"

@protocol RelationshipMatcher;

@interface SubjectPattern : Pattern

+ (SubjectPattern *)forScanner:(PatternScanner *)scanner;
- (id<RelationshipMatcher>)parse;

@end
