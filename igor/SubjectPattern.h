#import "Pattern.h"

@class Matcher;
@protocol RelationshipMatcher;

@interface SubjectPattern : Pattern

+ (SubjectPattern *)forScanner:(PatternScanner *)scanner;
- (id<RelationshipMatcher>)parse;

@end
