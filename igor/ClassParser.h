@class IgorQueryScanner;

@interface ClassParser

+ (void)addClassMatcherFromQuery:(IgorQueryScanner *)query toArray:(NSMutableArray*)array;

@end
