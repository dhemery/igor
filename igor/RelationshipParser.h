@protocol SubjectMatcher;
@class IgorQueryScanner;

@interface RelationshipParser

+ (id <SubjectMatcher>)parse:(IgorQueryScanner *)query;

@end
