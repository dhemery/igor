#import "SelectorEngineRegistry.h"

@protocol InstanceChainParser;
@protocol IgorQueryScanner;
@protocol IgorQueryParser;

@interface Igor : NSObject <SelectorEngine>

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;

+ (Igor *)igor;
+ (Igor *)igorWithParser:(id<IgorQueryParser>)parser;

@end
