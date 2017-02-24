//
//  ViewController.m
//  CollectionViewTest
//
//  Created by wenjie hua on 2017/2/23.
//  Copyright © 2017年 jingcheng. All rights reserved.
//

#import "ViewController.h"
#import "ColorCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *cvTest;
@property (nonatomic, strong) NSMutableArray *marrData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.cvTest registerNib:[UINib nibWithNibName:@"ColorCell" bundle:nil] forCellWithReuseIdentifier:@"ColorCell"];
    [self.view addSubview:self.cvTest];
}

#pragma mark - Event Methods
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            NSIndexPath *indexPath = [self.cvTest indexPathForItemAtPoint:[longGesture locationInView:self.cvTest]];
            if (indexPath == nil) {
                break;
            }
            [self.cvTest beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            [self.cvTest updateInteractiveMovementTargetPosition:[longGesture locationInView:self.cvTest]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.cvTest endInteractiveMovement];
            break;
        default:
            [self.cvTest cancelInteractiveMovement];
            break;
    }
}

#pragma mark - UICollectionViewDataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.marrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ColorCell" forIndexPath:indexPath];
    NSNumber *number = self.marrData[indexPath.row];
    [cell setTitle:[NSString stringWithFormat:@"%@",number]];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - UICollectionViewDelegate Methods
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [self.marrData objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.marrData removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.marrData insertObject:objc atIndex:destinationIndexPath.item];
}

#pragma mark - setter and getter Methods
- (UICollectionView *)cvTest{
    if (_cvTest == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((kScreenWidth - 4)/3, (kScreenWidth - 2)/3*2);
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cvTest = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        //此处给其增加长按手势，用此手势触发cell移动效果
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [_cvTest addGestureRecognizer:longGesture];
        _cvTest.delegate = self;
        _cvTest.dataSource = self;
    }
    return _cvTest;
}

- (NSMutableArray *)marrData{
    if (_marrData == nil) {
        _marrData = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i++) {
            [_marrData addObject:@(i)];
        }
    }
    return _marrData;
}

@end
