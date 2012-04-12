@class IgorQueryStringScanner;
@protocol IgorQueryScanner;

@interface ClassParser

+ (void)addClassMatcherFromQuery:(id<IgorQueryScanner>)query toArray:(NSMutableArray*)array;

@end
