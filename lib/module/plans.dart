class Plan {
  final id;
  final cPlan;
  final nVirtualNumber;
  final nTalktime;
  final nData;
  final nStartsFrom;
  List<JSubscription> jSubscription;

  Plan({
    required this.id,
    required this.cPlan,
    required this.nVirtualNumber,
    required this.nTalktime,
    required this.nData,
    required this.nStartsFrom,
    required this.jSubscription,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["_id"],
        cPlan: json["c_Plan"],
        nVirtualNumber: json["n_VirtualNumber"],
        nTalktime: json["n_Talktime"],
        nData: json["c_Data"],
        nStartsFrom: json["n_StartsFrom"],
        jSubscription: List<JSubscription>.from(
            json["j_Terms"].map((x) => JSubscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "c_Plan": cPlan,
        "n_VirtualNumber": nVirtualNumber,
        "n_Talktime": nTalktime,
        "c_Data": nData,
        "n_StartsFrom": nStartsFrom,
        "j_Subscription":
            List<dynamic>.from(jSubscription.map((x) => x.toJson())),
      };
}

class JSubscription {
  final id;
  final cTerm;
  final nAmount;

  JSubscription({
    required this.id,
    required this.cTerm,
    required this.nAmount,
  });

  factory JSubscription.fromJson(Map<String, dynamic> json) => JSubscription(
        id: json["_id"],
        cTerm: json["c_Term"],
        nAmount: json["n_Amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "c_Term": cTerm,
        "n_Amount": nAmount,
      };
}
