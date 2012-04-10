@protocol ClassMatcher;
@class IgorQueryScanner;

@interface ClassParser

+ (id<ClassMatcher>)parse:(IgorQueryScanner *)query;

@end
