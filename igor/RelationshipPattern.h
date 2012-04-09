#import "Pattern.h"

@protocol SubjectMatcher;

@interface RelationshipPattern : Pattern

+ (RelationshipPattern *)forScanner:(PatternScanner *)scanner;

- (id <SubjectMatcher>)parse;

@end
