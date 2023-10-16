// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Project imports:
import 'package:jd_mall_flutter/common/util/screen_util.dart';
import 'package:jd_mall_flutter/component/common_header.dart';
import 'package:jd_mall_flutter/component/persistentHeader/sliver_header_builder.dart';

List list = [
  {
    "groupName": "A",
    "groupList": [
      {"name": "A徐军"},
      {"name": "A王强"},
      {"name": "A吕军"},
      {"name": "A易艳"},
      {"name": "A袁秀兰"},
      {"name": "A杨涛"},
      {"name": "A姚洋"},
      {"name": "A萧刚"}
    ]
  },
  {
    "groupName": "B",
    "groupList": [
      {"name": "B彭磊"},
      {"name": "B丁明"},
      {"name": "B姚涛"},
      {"name": "B方磊"},
      {"name": "B高娟"},
      {"name": "B罗娜"},
      {"name": "B彭军"},
      {"name": "B董刚"}
    ]
  },
  {
    "groupName": "C",
    "groupList": [
      {"name": "C于娜"},
      {"name": "C汤平"},
      {"name": "C孙秀兰"},
      {"name": "C邱平"},
      {"name": "C廖霞"},
      {"name": "C彭芳"},
      {"name": "C陈敏"},
      {"name": "C陆勇"}
    ]
  },
  {
    "groupName": "D",
    "groupList": [
      {"name": "D于娜"},
      {"name": "D汤平"},
      {"name": "D孙秀兰"},
      {"name": "D邱平"},
      {"name": "D廖霞"},
      {"name": "D彭芳"},
      {"name": "D陈敏"},
      {"name": "D陆勇"}
    ]
  },
  {
    "groupName": "H",
    "groupList": [
      {"name": "H于娜"},
      {"name": "H汤平"},
      {"name": "H孙秀兰"},
      {"name": "H邱平"},
      {"name": "H廖霞"},
      {"name": "H彭芳"},
      {"name": "H陈敏"},
      {"name": "H陆勇"}
    ]
  },
  {
    "groupName": "L",
    "groupList": [
      {"name": "L于娜"},
      {"name": "L汤平"},
      {"name": "L孙秀兰"},
      {"name": "L邱平"},
      {"name": "L廖霞"},
      {"name": "L彭芳"},
      {"name": "L陈敏"},
      {"name": "L陆勇"}
    ]
  },
  {
    "groupName": "P",
    "groupList": [
      {"name": "P郭伟"},
      {"name": "P于涛"},
      {"name": "P彭娜"},
      {"name": "P黄娟"},
      {"name": "P彭磊"},
      {"name": "P陈娟"},
      {"name": "P顾丽"},
      {"name": "P戴磊"}
    ]
  },
  {
    "groupName": "R",
    "groupList": [
      {"name": "R邵娟"},
      {"name": "R毛娟"},
      {"name": "R宋刚"},
      {"name": "R李刚"},
      {"name": "R黄艳"},
      {"name": "R傅军"},
      {"name": "R廖秀兰"},
      {"name": "R崔静"}
    ]
  },
  {
    "groupName": "S",
    "groupList": [
      {"name": "S文平"},
      {"name": "S陈娜"},
      {"name": "S胡洋"},
      {"name": "S谢艳"},
      {"name": "S沈敏"},
      {"name": "S贾军"},
      {"name": "S邓芳"},
      {"name": "S谭明"}
    ]
  },
  {
    "groupName": "T",
    "groupList": [
      {"name": "T张磊"},
      {"name": "T林明"},
      {"name": "T程军"},
      {"name": "T杨明"},
      {"name": "T宋磊"},
      {"name": "T赵杰"},
      {"name": "T徐霞"},
      {"name": "T段芳"}
    ]
  },
  {
    "groupName": "U",
    "groupList": [
      {"name": "U锺刚"},
      {"name": "U叶平"},
      {"name": "U张强"},
      {"name": "U康桂英"},
      {"name": "U袁磊"},
      {"name": "U孟桂英"},
      {"name": "U易敏"},
      {"name": "U蒋强"}
    ]
  },
  {
    "groupName": "V",
    "groupList": [
      {"name": "V林霞"},
      {"name": "V杨明"},
      {"name": "V雷霞"},
      {"name": "V赵敏"},
      {"name": "V蒋勇"},
      {"name": "V江霞"},
      {"name": "V孔磊"},
      {"name": "V方秀兰"}
    ]
  },
  {
    "groupName": "W",
    "groupList": [
      {"name": "W林勇"},
      {"name": "W贾艳"},
      {"name": "W邹杰"},
      {"name": "W顾静"},
      {"name": "W马娟"},
      {"name": "W罗杰"},
      {"name": "W韩磊"},
      {"name": "W黎静"}
    ]
  },
  {
    "groupName": "Y",
    "groupList": [
      {"name": "Y林勇"},
      {"name": "Y贾艳"},
      {"name": "Y邹杰"},
      {"name": "Y顾静"},
      {"name": "Y马娟"},
      {"name": "Y罗杰"},
      {"name": "Y韩磊"},
      {"name": "Y黎静"}
    ]
  },
  {
    "groupName": "Z",
    "groupList": [
      {"name": "Z林勇"},
      {"name": "Z贾艳"},
      {"name": "Z邹杰"},
      {"name": "Z顾静"},
      {"name": "Z马娟"},
      {"name": "Z罗杰"},
      {"name": "Z韩磊"},
      {"name": "Z黎静"}
    ]
  }
];
const sideBarItemHeight = 30.0;

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late final ScrollController _scrollController;

  Map<String, GlobalKey> keys = {};

  @override
  void initState() {
    _scrollController = ScrollController();
    for (var value in list) {
      keys[value["groupName"]] = GlobalKey(debugLabel: 'contact_${value["groupName"]}');
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              commonHeader(context, title: "联系人"),
              Expanded(
                flex: 1,
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: list.map((e) {
                    return SliverMainAxisGroup(
                      slivers: [
                        SliverPersistentHeader(
                          key: keys[e["groupName"]],
                          pinned: true,
                          delegate: SliverHeaderDelegate.fixedHeight(
                            height: 32,
                            child: GroupItem(data: e),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: (e["groupList"] as List).length,
                            (BuildContext context, int index) {
                              return UserItem(
                                data: e,
                                index: index,
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Positioned(
            right: 10,
            child: SizedBox(
              width: 34,
              height: getScreenHeight(context),
              child: Center(
                child: Container(
                  width: 34,
                  height: sideBarItemHeight * list.length + 20,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey.shade500,
                  ),
                  child: GestureDetector(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      String indexBar = getIndexString(context, details.localPosition);
                      scroll2PositionBySlide(indexBar);
                    },
                    onVerticalDragDown: (DragDownDetails details) {
                      String indexBar = getIndexString(context, details.localPosition);
                      scroll2PositionBySlide(indexBar);
                    },
                    child: Column(
                      children: list.map((e) {
                        return SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              e["groupName"],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void scroll2PositionBySlide(String char) {
    RenderSliverMainAxisGroup? keyRenderObject = keys[char]?.currentContext?.findAncestorRenderObjectOfType<RenderSliverMainAxisGroup>();
    if (keyRenderObject != null) {
      _scrollController.position.ensureVisible(keyRenderObject, duration: const Duration(milliseconds: 200), curve: Curves.ease);
    }
  }
}

String getIndexString(BuildContext context, Offset localPosition) {
  // 点击的坐标点在当前部件中的y坐标
  double y = localPosition.dy;
  // 计算是第几个字符
  int index = (y ~/ sideBarItemHeight).clamp(0, list.length - 1);
  // 当前选中的字符
  String str = list[index]["groupName"];
  return str;
}

class GroupItem extends StatelessWidget {
  dynamic data;

  GroupItem({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: getScreenWidth(context),
      color: Colors.grey.shade300,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 24),
      child: Text(
        data["groupName"],
        style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  dynamic data;
  int index;

  UserItem({
    required this.data,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 10.0),
            child: FlutterLogo(size: 30),
          ),
          Text(
            (data["groupList"] as List)[index]["name"],
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
