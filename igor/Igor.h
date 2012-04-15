#import "SelectorEngineRegistry.h"

@protocol IgorQueryScanner;
@protocol IgorQueryParser;

@interface Igor : NSObject <SelectorEngine>

@property(strong) id <IgorQueryParser> parser;

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;

+ (Igor *)igor;

+ (Igor *)igorWithParser:(id <IgorQueryParser>)parser;

@end
