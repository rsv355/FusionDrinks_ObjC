//
//  SpicesViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "SpicesViewController.h"
#import "SpicesTableViewCell.h"

@interface SpicesViewController ()
{
    SpicesTableViewCell *cell;
    NSArray *titlesArr,*descriptionArr;
}
@end

@implementation SpicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDataArr];
    self.tableView.backgroundView = [UIView new];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITableView Datasource and Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titlesArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor blackColor];
    cell=(SpicesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    cell.layer.borderWidth=2.0f;
//    cell.layer.borderColor=[UIColor whiteColor].CGColor;
    
    cell.lblSpicesName.text=[titlesArr objectAtIndex:indexPath.row];
    cell.lblSpicesDesc.text=[descriptionArr objectAtIndex:indexPath.row];
       return cell;
}
- (NSUInteger)numberOfWordsInString:(NSString *)str {
    __block NSUInteger count = 0;
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length])
                            options:NSStringEnumerationByWords|NSStringEnumerationSubstringNotRequired
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                             count++;
                         }];
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    //CGFloat cellHeight1;

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"1"])
    {
        if (indexPath.row==0) {
            cellHeight=200.0f;
        }
        else if (indexPath.row==1) {
            cellHeight=185.0f;
        }
        else if(indexPath.row==2){
            cellHeight=190.0f;
        }
        else if(indexPath.row==3){
            cellHeight=150.0f;
        }
        else if(indexPath.row==4){
            cellHeight=200.0f;
        }
        else if(indexPath.row==5){
            cellHeight=190.0f;
        }
        else if(indexPath.row==6){
            cellHeight=190.0f;
        }
        else if(indexPath.row==7){
            cellHeight=185.0f;
        }
            
        
    }
    else  if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"2"])
    {
        if (indexPath.row==0) {
            cellHeight=220.0f;
        }
        else if (indexPath.row==1) {
            cellHeight=220.0f;
        }
        else if(indexPath.row==2){
            cellHeight=210.0f;
        }
        else if(indexPath.row==3){
            cellHeight=190.0f;
        }
        else if(indexPath.row==4){
            cellHeight=220.0f;
        }
        else if(indexPath.row==5){
            cellHeight=200.0f;
        }
        else if(indexPath.row==6){
            cellHeight=220.0f;
        }
        else if(indexPath.row==7){
            cellHeight=200.0f;
        }

    }
    return cellHeight;
}
-(void)setDataArr
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"1"]) {
        titlesArr=[[NSArray alloc]initWithObjects:@"Ginger", @"Cardamom", @"Cinnamon",@"Fennel seed",@"Clove",@"Vanilla",@"Black tea", @"Rooibos", nil];
        
        descriptionArr=[[NSArray alloc]initWithObjects:@"For over 3000 years, ginger has been renowned in the Far East not only as a spice but according to Ayurveda, also for its healing properties. With its distinctive smell and citrusy- aroma, it stimulates the appetite and is sometimes referred to as a cold remedy. It is known to increase blood circulation, reduce blood pressure and expel toxins. The tuber can allegedly also spark Agni, the inner, divine fire",@"According to Ayurvedic teachings, cardamom can improve one’s memory and is an aphrodisiac. The taste is reminiscent of ginger, lemon and eucalyptus. The dried cardamom seed pods are considered to be one of the oldest and finest ever, and form a major component of Indian Masalas. Cardamom smells intensely sweet and its consumption is said to illuminate the mind.",@"Cassia cinnamon has been an important remedy in traditional Chinese medicine for about 5000 years. Today, the somewhat finer and more familiar Ceylon cinnamon comes from Sri Lanka, where the fragrant, sweet bark grows. Because of the warming nature of cinnamon, it is highly valued in Ayurvedic teachings for its ability to improve digestion and raise serotonin levels.",@"For thousands of years, fennel seeds have played an important role in naturopathy. It has a strong aniseed flavor and is added to many Indian Masalas. Its sweetish aroma is refreshing and also aids digestion. The essential oil of fennel is said to have anti-inflammatory effects.",@"For centuries, cloves were a precious trading commodity. Their intense and warming aroma gives them a distinctive character. Like cardamom and aniseed, cloves are often used for baking at Christmas time in Europe. In Ayurvedic cooking one uses it for rice and potato dishes as well as curries and chutneys. Cloves act as an antioxidant and as protection against free radicals.",@"The home of vanilla, the fragrant fruit of the climbing orchid, is Mexico. In as far back as the Aztec civilization it was a popular spice and has since been used in the perfume industry for its aphrodisiac effect. Vanilla is calming and balancing. In addition to its heart-strengthening properties it also helps remove anxiety and fatigue.",@"The fermented leaves of the tea plant are the basis for black tea. In contrast to green tea, the leaves are wilted and machine-rolled, thereby oxidizing the ingredients to give them their characteristic flavor. The caffeine content stimulates the central nervous system and promotes concentration; the tannins also have a calming effect on the gastrointestinal tract.",@"According to records, the original inhabitants of the Cape in South Africa brewed a tea-like infusion from the leaves of this wild legume. Rooibos has many health-inducing properties and has a positive influence on the happiness hormone, serotonin. It is therefore particularly well suited as a remedy for depression, nervousness, sleep problems and headaches.", nil];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"2"]) {
        titlesArr=[[NSArray alloc]initWithObjects:@"Ingwer", @"Kardamom", @"Zimt",@"Fenchelsamen",@"Nelke",@"Vanille",@"Schwarzer Tee", @"Rooibos", nil];
        
        descriptionArr=[[NSArray alloc]initWithObjects:@"Seit mehr als 3000 Jahren ange Ingwer wurde im Fernen Osten nicht nur als Gewürz berühmt , sondern nach Ayurveda, auch für seine heilenden Eigenschaften . Mit seinem unverwechselbaren Geruch und citrusy- Aroma , regt es den Appetit und wird manchmal als Erkältungsmittel bezeichnet . Es ist bekannt, die Blutzirkulation zu erhöhen , den Blutdruck  senken und Giftstoffe zu vertreiben . Die Knolle kann angeblich auch funken Agni, die innere , göttliche Feuer.",@"Nach ayurvedischer Lehre , Kardamom kann man das Gedächtnis verbessern und ist ein Aphrodisiakum . Der Geschmack erinnert an Ingwer, Zitrone und Eukalyptus. Die getrockneten Kardamomsamenkapseln werden als eine der ältesten und schönsten jemals zu sein, und ein wichtiger Bestandteil der indischen Masalas bilden. Kardamom riecht intensiv süß und sein Verbrauch wird gesagt, um den Geist zu beleuchten.",@"Cassia-Zimt ist seit etwa 5000 Jahren ein wichtiges Heilmittel in der traditionellen chinesischen Medizin. Heute ist die etwas feiner und besser vertraut Ceylon-Zimt stammt aus Sri Lanka, wo die duftende , süße Rinde wächst . Aufgrund der Erwärmung der Natur von Zimt , ist es sehr in der ayurvedischen Lehre für seine Fähigkeit geschätzt Verdauung zu verbessern und den Serotoninspiegel erhöhen.",@"Seit Tausenden von Jahren , Fenchelsamen haben eine wichtige Rolle in der Naturheilkunde  gespielt. Es hat eine starke Anisgeschmack und wird zu vielen indischen Masalas hinzugefügt . Sein süßlicher Duft ist erfrischend und auch fördert die Verdauung . Das ätherische Öl von Fenchel gesagt wird eine entzündungshemmende  Wirkung haben.",@"Seit Jahrhunderten waren Nelken ein kostbares Handelsgut . Ihre intensive und wärmende Aroma verleiht ihnen einen unverwechselbaren Charakter. Wie Kardamom und Anis , Nelken werden häufig zum Backen in der Weihnachtszeit in Europa verwendet. In der ayurvedischen Küche verwendet man es für Reis und Kartoffelgerichte sowie Currys und Chutneys . Gewürznelken wirken als Antioxidans und als Schutz vor freien Radikalen.",@"Die Heimat der Vanille, die duftende Frucht der Kletterorchidee ist Mexiko . In so weit zurück wie die Zivilisation der Azteken war es ein beliebtes Gewürz und wurde in der Parfümindustrie für seine aphrodisierende Wirkung, da verwendet . Vanilla ist beruhigend und ausgleichend. Zusätzlich zu seiner herzstärkenden  Eigenschaften hilft es auch Angst und Müdigkeit entfernen.",@"Die fermentierten Blätter der Teepflanze sind die Basis für schwarzen Tee. Im Gegensatz zu grünem Tee werden die Blätter welk und maschinell gerollt , wodurch die Bestandteile oxidieren sie ihren charakteristischen Geschmack zu geben . Der Koffeingehalt stimuliert das zentrale Nervensystem und fördert die Konzentration ; die Tannine haben auch eine beruhigende Wirkung auf den Magen-Darm- Trakt.",@"Nach den Aufzeichnungen , gebraut die ursprünglichen Bewohner der Cape in Südafrika eine teeartigen Infusion aus den Blättern dieser wilden Leguminosen . Rooibos hat viele gesundheitliche auslösenden Eigenschaften und hat einen positiven Einfluss auf das Glückshormon Serotonin . Es ist daher besonders gut als Mittel gegen Depressionen, Nervosität , Schlafstörungen und Kopfschmerzen geeignet.", nil];
    }

}
/*  NSUInteger cWords=[self numberOfWordsInString:[descriptionArr objectAtIndex:indexPath.row]];
 NSLog(@"---Index:: %ld---%ld",indexPath.row, cWords);
if (cWords>=1&&cWords<=20) {
 cellHeight=70.0f;
 }
 else if (cWords>=20&&cWords<=40) {
 cellHeight=170.0f;
 }
 else if (cWords>40&&cWords<=60) {
 cellHeight=200.0f;
 }
 else if (cWords>60&&cWords<=80) {
 cellHeight=220.0f;
 }
 else  {
 cellHeight=260.0f;
 }
 if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"1"])
 {
 cellHeight1=cellHeight;
 }
 else  if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"2"])
 {
 cellHeight1=cellHeight+30.0f;
 }*/

@end
