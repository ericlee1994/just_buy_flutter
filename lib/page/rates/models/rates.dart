import 'dart:convert' show json;


class Rate_Bean {

  int error_code;
  String reason;
  String resultcode;
  List<Result> result;


  Rate_Bean.fromParams({this.error_code, this.reason, this.resultcode, this.result});

  factory Rate_Bean(jsonStr) => jsonStr is String ? Rate_Bean.fromJson(json.decode(jsonStr)) : Rate_Bean.fromJson(jsonStr);

  Rate_Bean.fromJson(jsonRes) {
    error_code = jsonRes['error_code'];
    reason = jsonRes['reason'];
    resultcode = jsonRes['resultcode'];
    result = [];

    for (var resultItem in jsonRes['result']){

      result.add(new Result.fromJson(resultItem));
    }


  }

  @override
  String toString() {
    return '{"error_code": $error_code,"reason": ${reason != null?'${json.encode(reason)}':'null'},"resultcode": ${resultcode != null?'${json.encode(resultcode)}':'null'},"result": $result}';
  }
}



class Result {

  Rate data1;
  Rate data10;
  Rate data11;
  Rate data12;
  Rate data13;
  Rate data14;
  Rate data15;
  Rate data16;
  Rate data17;
  Rate data18;
  Rate data19;
  Rate data2;
  Rate data20;
  Rate data21;
  Rate data3;
  Rate data4;
  Rate data5;
  Rate data6;
  Rate data7;
  Rate data8;
  Rate data9;


  Result.fromParams({this.data1, this.data10, this.data11, this.data12, this.data13, this.data14, this.data15, this.data16, this.data17, this.data18, this.data19, this.data2, this.data20, this.data21, this.data3, this.data4, this.data5, this.data6, this.data7, this.data8, this.data9});

  Result.fromJson(jsonRes) {
    data1 = new Rate.fromJson(jsonRes['data1']);
    data10 = new Rate.fromJson(jsonRes['data10']);
    data11 = new Rate.fromJson(jsonRes['data11']);
    data12 = new Rate.fromJson(jsonRes['data12']);
    data13 = new Rate.fromJson(jsonRes['data13']);
    data14 = new Rate.fromJson(jsonRes['data14']);
    data15 = new Rate.fromJson(jsonRes['data15']);
    data16 = new Rate.fromJson(jsonRes['data16']);
    data17 = new Rate.fromJson(jsonRes['data17']);
    data18 = new Rate.fromJson(jsonRes['data18']);
    data19 = new Rate.fromJson(jsonRes['data19']);
    data2 = new Rate.fromJson(jsonRes['data2']);
    data20 = new Rate.fromJson(jsonRes['data20']);
    data21 = new Rate.fromJson(jsonRes['data21']);
    data3 = new Rate.fromJson(jsonRes['data3']);
    data4 = new Rate.fromJson(jsonRes['data4']);
    data5 = new Rate.fromJson(jsonRes['data5']);
    data6 = new Rate.fromJson(jsonRes['data6']);
    data7 = new Rate.fromJson(jsonRes['data7']);
    data8 = new Rate.fromJson(jsonRes['data8']);
    data9 = new Rate.fromJson(jsonRes['data9']);

  }

  @override
  String toString() {
    return '{"data1": $data1,"data10": $data10,"data11": $data11,"data12": $data12,"data13": $data13,"data14": $data14,"data15": $data15,"data16": $data16,"data17": $data17,"data18": $data18,"data19": $data19,"data2": $data2,"data20": $data20,"data21": $data21,"data3": $data3,"data4": $data4,"data5": $data5,"data6": $data6,"data7": $data7,"data8": $data8,"data9": $data9}';
  }
}



class Rate {

  String bankConversionPri;
  String date;
  String fBuyPri;
  String fSellPri;
  String mBuyPri;
  String mSellPri;
  String name;
  String time;


  Rate.fromParams({this.bankConversionPri, this.date, this.fBuyPri, this.fSellPri, this.mBuyPri, this.mSellPri, this.name, this.time});

  Rate.fromJson(jsonRes) {
    bankConversionPri = jsonRes['bankConversionPri'];
    date = jsonRes['date'];
    fBuyPri = jsonRes['fBuyPri'];
    fSellPri = jsonRes['fSellPri'];
    mBuyPri = jsonRes['mBuyPri'];
    mSellPri = jsonRes['mSellPri'];
    name = jsonRes['name'];
    time = jsonRes['time'];

  }

  @override
  String toString() {
    return '{"bankConversionPri": ${bankConversionPri != null?'${json.encode(bankConversionPri)}':'null'},"date": ${date != null?'${json.encode(date)}':'null'},"fBuyPri": ${fBuyPri != null?'${json.encode(fBuyPri)}':'null'},"fSellPri": ${fSellPri != null?'${json.encode(fSellPri)}':'null'},"mBuyPri": ${mBuyPri != null?'${json.encode(mBuyPri)}':'null'},"mSellPri": ${mSellPri != null?'${json.encode(mSellPri)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"time": ${time != null?'${json.encode(time)}':'null'}}';
  }
}
