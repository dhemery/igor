@protocol DEQueryScanner;
@protocol DEPatternParser;

@interface DEIgor : NSObject

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;
- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTrees:(NSArray *)trees;
+ (DEIgor *)igor;
+ (DEIgor *)igorWithParser:(id <DEPatternParser>)parser;

@end
