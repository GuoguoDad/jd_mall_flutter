import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jd_mall_flutter/common/util/color_util.dart';
import 'package:jd_mall_flutter/redux/action/wel_page_action.dart';
import 'package:jd_mall_flutter/redux/app_state.dart';

import '../../../redux/state/wel_page_state.dart';

final List<Map<String, dynamic>> menuData = [
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/102632/18/20350/13255/61e131feE788947ef/c391b8590cdf427e.png!q70.jpg",
    "menuName": "超市",
    "menuCode": "m01"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/172178/32/9487/10851/609d18e0Ed273eec1/a1e099f1601c8cc2.png!q70.jpg",
    "menuName": "服饰",
    "menuCode": "m03"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/193038/4/3881/13295/60a4b6a7E4124dc9e/fdd2934e97eab3ac.png!q70.jpg",
    "menuName": "免费水果",
    "menuCode": "m04"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/181856/30/3968/10274/609e3d99E07c63af4/cb0d5b21c461b07f.png!q70.jpg",
    "menuName": "喜喜",
    "menuCode": "m05"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/91538/20/21166/8105/61e128b9E06558f00/2c9273cdee9b2e3d.png!q70.jpg",
    "menuName": "生活缴费",
    "menuCode": "m06"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/185536/13/17333/14522/6108a9f0E62572408/8222cc8a66134776.png!q70.jpg",
    "menuName": "领豆",
    "menuCode": "m07"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/175369/35/26446/17302/61e12945E09ef2a2f/87b391aff2da560a.png!q70.jpg",
    "menuName": "领券",
    "menuCode": "m08"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/127505/17/20504/10647/61e112b0E4f382c96/7a042862fc7c479e.png!q70.jpg",
    "menuName": "领金贴",
    "menuCode": "m09"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/107776/17/21311/9709/61e12b6eEa79cbefa/bd0bb902e126fafb.png!q70.jpg",
    "menuName": "会员",
    "menuCode": "m10"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/104637/39/25735/190791/622f3682E168960d2/2dbfbaf4147134c1.gif",
    "menuName": "国际",
    "menuCode": "m11"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/146216/7/22157/182757/622f37e8Ec2445bac/658b95154cb12771.gif",
    "menuName": "电器",
    "menuCode": "m02"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/189533/37/5319/12852/60b05d59Eb3b3fd29/4c478e3347507e51.png!q70.jpg",
    "menuName": "生鲜",
    "menuCode": "m13"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/129902/19/16911/11005/60b05dd8Edad29a3f/ca6b3ea0f67e1826.png!q70.jpg",
    "menuName": "沃尔玛",
    "menuCode": "m14"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/192361/9/5316/11815/60b05d25Eec7f6b5e/5555dcc59d99428d.png!q70.jpg",
    "menuName": "旅行",
    "menuCode": "m15"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/109159/13/17721/9654/60b05d73Eefa154db/3a4a46ef2755c622.png!q70.jpg",
    "menuName": "看病购药",
    "menuCode": "m16"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/188405/35/3707/11116/60a26055Ef91c306d/1ba7aa3b9328e35e.png!q70.jpg",
    "menuName": "拍拍二手",
    "menuCode": "m17"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/177688/12/4847/7352/60a39a9bEe0a7e4f8/1a8efe458d1c3ee2.png!q70.jpg",
    "menuName": "种豆得豆",
    "menuCode": "m18"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/184718/8/4051/11977/609e5222Ea2816259/d29fec6d4d8558f1.png!q70.jpg",
    "menuName": "萌宠",
    "menuCode": "m19"
  },
  {
    "menuIcon": "https://m15.360buyimg.com/mobilecms/jfs/t1/126310/38/18675/7912/60b05e32E736cb5fe/2bb8508e955b88ee.png!q70.jpg",
    "menuName": "更多频道",
    "menuCode": "m20"
  }
];

const rowNum = 5;
const pageNum = rowNum * 2;

Widget menuSlider(BuildContext context) {
  return SliverToBoxAdapter(
      child: Container(
          color: Colors.white,
          height: 185,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: menuPageList(context)
              ),
              Container(
                height: 15,
                alignment: Alignment.center,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: (menuData.length % pageNum) > 0 ? (menuData.length ~/ pageNum) + 1 : (menuData.length ~/ pageNum),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: const Alignment(0, .5),
                        height: 10,
                        width: 10,
                        child:  StoreConnector<AppState, WelPageState>(
                            converter: (store) {
                            return store.state.welPageState;
                          },
                          builder: (context, state) {
                              return CircleAvatar(
                                radius: 3,
                                backgroundColor: state.menuSliderIndex == index ? ColorUtil('#FE0F22') : Colors.grey,
                                child: Container(
                                  alignment: const Alignment(0, .5),
                                  width: 10,
                                  height: 10,
                                ),
                              );
                          }
                        )
                      );
                    }),
              )
            ],
          )
      )
  );
}

Widget menuPageList(BuildContext context) {
  return
    StoreBuilder<AppState>(
      builder: (context, store) {
        return PageView.builder(
          itemCount: (menuData.length % pageNum ) > 0 ? (menuData.length ~/ pageNum) + 1 : (menuData.length ~/ pageNum),
          onPageChanged: (index) {
            store.dispatch(SetMenuSliderIndex(index));
          },
          itemBuilder: (BuildContext context, int index) {
            return GridView.builder(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (index < (menuData.length ~/ pageNum)) ? pageNum : (menuData.length % pageNum),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowNum,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, position){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(menuData[index * pageNum + position]['menuIcon'].toString(),
                        width: 40,
                        height: 40,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          menuData[index * pageNum + position]['menuName'].toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  );
                }
            );
          },
        );
      }
    );
}