//
//  ViewController.m
//  SlotMachine
//
//  Created by 해용 이 on 2014. 1. 7..
//  Copyright (c) 2014년 해용 이. All rights reserved.
//

#define MAX_NUM 100

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
    
    // 컨트롤러가 소유한 모델들은 instance 변수로 선언
    
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
    
@property (weak,nonatomic) NSNumber* _money;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

@implementation ViewController

-(void)updateMoney{
    
    NSNumberFormatter* fomatter = [[NSNumberFormatter alloc]init];
    
    [fomatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self._money = [fomatter numberFromString:self.textField.text];
    
}

- (IBAction)betMoney:(id)sender {
    

    [self updateMoney];
    
    [self.textField resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    [self updateMoney];
    
    [self.textField resignFirstResponder];
    
    return YES;
    
}



#if 1

-(NSInteger)match:(NSInteger)x : (NSInteger)y : (NSInteger)z {
    
    NSInteger _x = x%11;
    
    NSInteger _y = y%11;
    
    NSInteger _z = z%11;
    
    if ((_x == _y)&&(_y == _z)) {
        
        return 100*self._money.intValue;
    }
    else if ((_x ==_y)||(_y==_z)||(_z==_x))
    {
        
        return 10*self._money.intValue;
    }
    
    return 0;
    
}

#endif

#if 1
-(IBAction)startMachine:(id)sender{
    
    NSInteger value;
    
    int r1 = arc4random()%MAX_NUM;
    
    [self.picker selectRow:r1 inComponent:0 animated:YES];
    
    
    int r2 = arc4random()%MAX_NUM;
    
    [self.picker selectRow:r2 inComponent:1 animated:YES];
    
    int r3 = arc4random()%MAX_NUM;
    
    [self.picker selectRow:r3 inComponent:2 animated:YES];
    
    
    value = [self match:r1 :r2 :r3 ];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"You Win %ld",value];
    
    
    
}
#endif


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    return MAX_NUM;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 64;
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    NSString *imagePath = [NSString stringWithFormat:@"flag%ld.jpeg",row%11];
    
    UIImage *image = [UIImage imageNamed:imagePath];
    
    UIImageView *imageView;
    
    if (nil == view) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 100, 60);
        
    }
    else{
        
        imageView = (UIImageView *)view;
        imageView.image = image;
        
    }
    
    return imageView;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
