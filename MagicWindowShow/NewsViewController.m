//
//  NewsViewController.m
//  MagicWIndowShow
//
//  Created by 刘家飞 on 15/12/10.
//  Copyright © 2015年 cafei. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import <MagicWindowSDK/MWApi.h>
#import "GlobalDefine.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"

@interface NewsViewController ()
{
    NSInteger _currentIndex;
    NSDictionary *_list;
    NSMutableDictionary *_mwkeyDic;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentIndex = 0;
    NSArray *arr1 = @[@{@"t":@"国产手机出海赴美该如何应对专利围剿？",@"d":@"小米、华为等国产手机进军美国市场，面临的最大诉讼压力未必是来自同业竞争对手，而更多是NPE机构，那该如何应对呢？",@"u":@"http://tech.163.com/15/1209/09/BACPOIPC000948V8.html"},
                      @{@"t":@"O2O创业的死亡率为什么那么高？",@"d":@"创业门槛的不断下探，让很多人为创业的春天欢呼，不过雪莱的名言反过来也成立，春天来了，冬天还会远吗？",@"u":@"http://m.sohu.com/n/426311864/?_trans_=000115_3w"},
                      @{@"t":@"银联、腾讯和阿里的支付战争悄然重启",@"d":@"在支付宝和微信支付涉足线下之前，其一直是银联一家的地盘——依靠着商户与消费者之间的连接和一份7：2：1（发卡行、收单行、银联）的分成协议，躺着赚钱。",@"u":@"http://m.baidu.com/from=844b/bd_page_type=1/ssid=0/uid=0/pu=usm%400%2Csz%401320_1001%2Cta%40iphone_2_4.3_3_534/baiduid=183CD62E5BB148FDB76D73755C304488/w=0_10_yinlian+tengxun+he+alide/t=iphone/l=3/tc?ref=www_iphone&lid=11260265755614846804&order=1&vit=osres&tj=www_normal_1_0_10_title&m=8&srd=1&cltj=cloud_title&dict=30&title=%E9%98%BF%E9%87%8C%E8%85%BE%E8%AE%AF%E5%92%8C%E9%93%B6%E8%81%94%E7%9A%84%E6%94%AF%E4%BB%98%E6%88%98%E5%86%8D%E6%89%93%E5%93%8D_%E5%88%9B%E4%BA%8B%E8%AE%B0_%E6%96%B0..._%E6%96%B0%E6%B5%AA%E7%A7%91%E6%8A%80&sec=8671&di=60caaf646bbf7b9b&bdenc=1&tch=124.0.0.0.0.0&nsrc=IlPT2AEptyoA_yixCFOxXnANedT62v3IEh3SLWBH_zSv95qshbrgHhEsRCnz2Sm5E5basCPQpslYhCXyQ8EobslOrxpms7oa6nzbePz5dhPsXMt29AlkQgaSGHJmyPjz&eqid=9c44800b97eb20001000000256726002&wd="},
                      @{@"t":@"社群经济是自媒体大号的未来吗？",@"d":@"社群，是运营驱动的模式，而且对运营的投入，远远超过作为一个媒体对运营的投入。 所有人，都尚在探索。",@"u":@"http://xw.qq.com/cul/20151208049795"},
                      @{@"t":@"互联网＋时代， 如何规制分享经济？",@"d":@"“我为人人，人人为我。”大仲马（法）在《三个火枪手》的这句话可谓点出了分享经济的真谛。",@"u":@"http://m.opinion.caixin.com/m/2015-12-08/100883319.html"},
                      @{@"t":@"中联通4G+对用户补贴450亿，你真的在乎吗？",@"d":@"中联通4G+策略出炉，此前中电信4G+、中移动4G+至少进行了100多天。中联通4G+与前两者最大亮点是对用户450亿补贴，产业链和用户是否买账？",@"u":@"http://m.sohu.com/n/430422488/?_trans_=000115_3w"}];
    
    NSArray *arr2 = @[@{@"t":@"科比加内特！NBA两尊傲骨 再嗅一嗅熟悉的硝烟",@"d":@"谁知老卧江湖上，犹枕当年虎骷髅。科比和加内特，NBA会永远记住他们的故事。",@"u":@"http://money.163.com/15/1211/00/BAH15M0I00253B0H.html"},
                      @{@"t":@"勇士跨季27连胜平13热火 33连胜？就是对骑士!",@"d":@"勇士跨赛季27连胜，已经追平了2012-13赛季的热火。下一个目标就是NBA历史最长的33连胜。",@"u":@"http://sports.sina.com.cn/basketball/nba/2015-12-09/doc-ifxmnurf8474922.shtml"},
                      @{@"t":@"欧冠夺冠赔率：巴萨独占榜首 英超3强被看衰",@"d":@"16强产生后，欧冠夺冠赔率榜更新，巴萨1赔3.25独占第一，拜仁、皇马分居二、三位，英超3强则全部被看衰。",@"u":@"http://sports.sina.com.cn/l/2015-12-10/doc-ifxmisxu6382943.shtml?cre=sinapc&mod=g&loc=18&r=u&rfunc=5"},
                      @{@"t":@"神奇反转！吉鲁帽子戏法 阿森纳3-0晋级",@"d":@"2015/16欧冠F组第6比赛日一场焦点战在卡莱斯卡基斯球场展开争夺，阿森纳客场3比0完胜奥林匹亚科斯，吉鲁帽子戏法",@"u":@"http://sports.sina.com.cn/g/pl/2015-12-10/doc-ifxmpnqm2996245.shtml"},
                      @{@"t":@"孙悦罚球绝杀！北京加时胜广东终结3连败",@"d":@"CBA第15轮全面开战，京粤大战激情上演。此前三连败的卫冕冠军北京队回到了万事达通过加时战以106-104战胜了广东队，孙悦上演罚球绝杀。",@"u":@"http://sports.sina.com.cn/cba/2015-12-09/doc-ifxmpnqm2984210.shtml"},
                      @{@"t":@"恒大提交世俱杯23人大名单：6外援报名 没带雷内",@"d":@"2015年世界俱乐部杯比赛将在12月中旬举行，日前亚洲冠军广州恒大方面提交了最终的23人参赛名单，恒大报上了6位外援，雷内没有在参赛名单之中。",@"u":@"http://sports.sina.com.cn/china/j/2015-11-29/doc-ifxmazmy2240003.shtml"}];
    
    NSArray *arr3 = @[@{@"t":@"内地电影票房将破400亿 票房前十是哪几部",@"d":@"截至目前，票房前三甲分别是《捉妖记》《速度与激情7》以及《港囧》。在票房前十的影片中，国产影片占到6部，在这6部影片中喜剧片占到一半。",@"u":@"http://cnews.chinadaily.com.cn/2015-12/10/content_22680095_2.htm"},
                      @{@"t":@"陈伟霆李治廷为什么拼不过鹿晗、吴亦凡？",@"d":@"因为耳机放着李治廷的尼古拉，想着李治廷的颜值，演技和学历，为什么他就没火起来呢？反观棒子国回来的鹿晗、吴亦凡基本都有一比一的电影圈资源。真的让人很费解。",@"u":@"http://tech.xinmin.cn/internet/2015/12/10/29084538.html"},
                      @{@"t":@"主持人欧弟升级当爸爸 妻子郑云灿产下爱女",@"d":@"湖南卫视工作人员“潇湘卧龙”也在微博发文向欧弟道贺，证实了欧弟的妻子郑云灿顺利产下爱女。",@"u":@"http://www.sc.xinhuanet.com/content/2015-12/10/c_1117413845.htm"},
                      @{@"t":@"《芈月传》高云翔：导演真坏！勾出我全部狂野",@"d":@"也许是习惯了高云翔给人的最初印象——特别帅气的阳光大男孩，所以当他在《芈月传》中初登场，嘶吼着冲出，一路策马扬鞭狂追芈月时，一时间居然没认出来。",@"u":@"http://et.21cn.com/webfocus/a/2015/1209/17/30358613.shtml"},
                      @{@"t":@"陈晓自曝已经与陈妍希同居",@"d":@"新房正在进行装修，称新房正在装修；还透露爱吃补肾食物山药和秋葵。",@"u":@"http://fun.youth.cn/2015/1214/3185403.shtml"},
                      @{@"t":@"《万万没想到》上海首映 韩寒被曝遭保安打",@"d":@"将于贺岁档上映的奇幻喜剧《万万没想到》在沪首映，导演叫兽易小星、韩寒与主演杨子姗、白客、陈柏霖等到场。现场，韩寒被曝拍戏过程中，为抱孔连顺遭保安痛打。",@"u":@"http://ent.qq.com/a/20151209/069249.htm"}];
    
    _list = @{@1:arr1,@2:arr2,@3:arr3};
    
    _mwkeyDic = [[NSMutableDictionary alloc] init];
    NSArray *list = [MWApi mwkeysWithActiveCampign:@[News_internet_01,News_internet_02,News_internet_03,News_sport_01,News_sport_02,News_sport_03,News_fun_01,News_fun_02,News_fun_03]];
    if (list == nil || list.count == 0)
    {
        return;
    }
    else
    {
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_mwkeyDic setObject:obj forKey:obj];
        }];
    }
    
}

- (void)tabSelect:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    _currentIndex = segment.selectedSegmentIndex;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"NewsCell";
    //不复用cell
    NewsCell *cell = (NewsCell *)[[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
    
    NSString *mwkey;
    if (_currentIndex == 0)
    {
        switch (indexPath.row) {
            case 0:
            {
                mwkey = News_internet_01;
                break;
            }
            case 1:
            {
                mwkey = News_internet_02;
                break;
            }
            case 2:
            {
                mwkey = News_internet_03;
                break;
            }
                
            default:
                break;
        }
    }
    else if (_currentIndex == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                mwkey = News_sport_01;
                break;
            }
            case 1:
            {
                mwkey = News_sport_02;
                break;
            }
            case 2:
            {
                mwkey = News_sport_03;
                break;
            }
                
            default:
                break;
        }
    }
    else if (_currentIndex == 2)
    {
        switch (indexPath.row) {
            case 0:
            {
                mwkey = News_fun_01;
                break;
            }
            case 1:
            {
                mwkey = News_fun_02;
                break;
            }
            case 2:
            {
                mwkey = News_fun_03;
                break;
            }
                
            default:
                break;
        }
    }
    if ([_mwkeyDic objectForKey:mwkey] != nil)
    {
        [MWApi configAdViewWithKey:[_mwkeyDic objectForKey:mwkey] withTarget:cell success:^(NSString * _Nonnull key, UIView * _Nonnull view, MWCampaignConfig * _Nonnull campaignConfig) {
            //
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:campaignConfig.imageUrl] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"news0%li-%li",_currentIndex+1,indexPath.row+1]]];
            cell.titleLabel.text = campaignConfig.title;
            cell.desc.text = campaignConfig.desc;
            
        } failure:^(NSString * _Nonnull key, UIView * _Nonnull view, NSString * _Nullable errorMessage) {
            //
            NSLog(@"key:%@,error:%@",[_mwkeyDic objectForKey:mwkey],errorMessage);
        }];
    }
    else
    {
        cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"news0%li-%li",_currentIndex+1,indexPath.row+1]];
        NSArray *arr = _list[@(_currentIndex+1)];
        NSDictionary *dic = arr[indexPath.row];
        cell.titleLabel.text = dic[@"t"];
        cell.desc.text = dic[@"d"];
    }
    
    return cell;
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
    NSArray *arr = _list[@(_currentIndex+1)];
    NSDictionary *dic = arr[indexPath.row];
    webVC.url = dic[@"u"];
    [self.navigationController pushViewController:webVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
