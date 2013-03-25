@interface ViewFactory : NSObject

+ (Class)classForButton;

+ (Class)classForControl;

+ (Class)classForLabel;

+ (Class)classForView;

+ (Class)classForWindow;

+ (id)button;

+ (id)control;

+ (id)view;

+ (id)viewWithName:(NSString *)name;

+ (id)window;

@end

