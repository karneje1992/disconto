//
//  DTableViewQuestController.m
//  Disconto
//
//  Created by Ross on 22.05.16.
//  Copyright © 2016 Disconto. All rights reserved.
//

#import "DTableViewQuestController.h"

@interface DTableViewQuestController ()

@property DQuestModel *quest;
@property NSArray *cells;
@property CGFloat headerSize;
@end

@implementation DTableViewQuestController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andQuest:(DQuestModel *)quest {
    self = [super init];
    if (self) {
        
        self.quest = quest;
        self.headerSize = 200;
    }
    return self;
}

+ (instancetype)showQuest:(DQuestModel *)quest{
    
    return [[DTableViewQuestController alloc] initWithNibName:NSStringFromClass([DTableViewQuestController class]) bundle:nil andQuest:quest];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerSize = 200;
    SHOW_PROGRESS;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.cells = [self getCellWithTableView:self.tableView andQuest:self.quest];
    [self.tableView reloadData];
    HIDE_PROGRESS;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((self.quest.questType == fact && self.quest.questMessage.length < 3)) {
        
        return self.tableView.bounds.size.height;
    }else
    
        if(self.quest.questImageURL.absoluteString.length && indexPath.row == 0){
        
            return isnan(_headerSize) ? 0 : _headerSize;
        }
        else{
        
            return UITableViewAutomaticDimension;
        }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cells.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cells[indexPath.row];
}

- (NSArray *)getCellWithTableView:(UITableView *)tableView andQuest:(DQuestModel *)quest {
    
    NSMutableArray *array= @[].mutableCopy;
    switch (quest.questType) {
            case fact:{
                
                if (quest.questImageURL) {
                    DProductHeaderCell *header = [DProductHeaderCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DProductHeaderCell class])];
                    [header.favoriteButton setAlpha:0];
                    [header.statusImageView setAlpha:0];
                    [header.favoriteCount setAlpha:0];
                    [header.unlocedCountLabel setAlpha:0];
                    [header.productImageView sd_setImageWithURL:self.quest.questImageURL placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        _headerSize = self.view.bounds.size.width/image.size.width*image.size.height;
                        [self.tableView reloadData];
                        
                    }];
                    [array addObject:header];
                }
                
                DDescriptionCell *cell = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
                [cell.descriptionLabel setText:self.quest.questMessage];
                cell.descriptionLabel.textAlignment = NSTextAlignmentLeft;
                [array addObject:cell];
            }
            break;
            
        default:{
            
            if (self.quest.questImageURL.absoluteString.length) {
                
                DProductHeaderCell *header = [DProductHeaderCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DProductHeaderCell class])];
                [header.favoriteButton setAlpha:0];
                [header.statusImageView setAlpha:0];
                [header.favoriteCount setAlpha:0];
                [header.unlocedCountLabel setAlpha:0];
                [header.productImageView sd_setImageWithURL:self.quest.questImageURL placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                    _headerSize = self.view.bounds.size.width/image.size.width*image.size.height;
                    [self.tableView reloadData];
                    
                }];
                [array addObject:header];
            }
            
            DDescriptionCell *cell = [DDescriptionCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DDescriptionCell class])];
            [cell.descriptionLabel setText:self.quest.questMessage];
            cell.descriptionLabel.textAlignment = NSTextAlignmentLeft;
            [array addObject:cell];
            for (DAnswerModel *item in self.quest.answerArray) {
                
                DAnswerCell *cell = [DAnswerCell getCellForTableView:tableView andClassCellString:NSStringFromClass([DAnswerCell class])];
                [cell.answerLabel setText:item.answerText];
                cell.delegate = self;
                cell.isChak = item.chack;
                [array addObject:cell];
            }
            
        }
            break;
    }
    return array;
}

- (void)isChakingCell:(id)cell chack:(BOOL)chack{
    
    if ([cell isKindOfClass:[DAnswerCell class]]) {
        
        DAnswerCell *answerCell = cell;
        
        for (DAnswerModel *obj in self.quest.answerArray) {
            
            obj.chack = [self.quest.answerArray indexOfObject:obj] == [self.cells indexOfObject:answerCell] - (self.cells.count - self.quest.answerArray.count);
        }

        self.cells = [self getCellWithTableView:self.tableView andQuest:self.quest];
        [self.tableView reloadData];
        [self.delegate answerComplit];
    }

}

@end
