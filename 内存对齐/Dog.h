//
//  Dog.h
//  内存对齐
//
//  Created by CYAX_BOY on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *nickName;
@property(nonatomic,assign)int age;

@end

NS_ASSUME_NONNULL_END
