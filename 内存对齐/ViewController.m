//
//  ViewController.m
//  内存对齐
//
//  Created by CYAX_BOY on 2021/3/1.
//

#import "ViewController.h"
#import "Test.h"
#import <objc/runtime.h>

struct S {
    char a;
    long b;
    int c;
    float d;
}S1;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //a _ _ _ _ _ _ _ b b b b b b b b c c c c d d
    //内存对齐 结构体或者union里第一个成员是冲offset为0的位置开始的，其后成员根据所占字节或者所占字节的倍数开始往后排。。。。。。最后结构的内存对齐是以结构体内最大成员所占字节的倍数，如上分析char占1自己从0开始，long在64位操作系统下占8自己，所以从8的倍数开始（0，8，16，24.。。。，这里前面有个char成员，所以b从8开始，前面1-7空着），b占8-15，c占4字节（从0，4，8，12，16.。。开始），同上从16开始（16-19），d占2字节（从0，2，4，6，8，10.。。开始），所以从20开始，20-21，最后相加8+8+4+2=22，但是结构体内存对齐以最大成员所占自己的倍数，其中最大是long 8位，所以是8的倍数24
    NSLog(@"-----%ld",sizeof(S1));//24
    
    
    //Test类没有任何成员（其实内部有个isa指针，指针占8字节），所以下面打印，可以给他加几个属性等测试内存对齐
    Test *te = [Test new];
    NSLog(@"test所占内存==%ld",class_getInstanceSize([te class]));
}


@end
