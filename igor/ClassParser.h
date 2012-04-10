@protocol ClassMatcher;
@class IgorQueryScanner;

@interface ClassParser

+ (void)parse:(IgorQueryScanner *)query intoArray:(NSMutableArray*)array;

@end
