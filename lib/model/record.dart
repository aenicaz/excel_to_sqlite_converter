class Record{
  int? id;
  String? buhName /*= "undefined"*/;
  String? model /*= "undefined"*/;
  String? serialNumber /*= "undefined"*/;
  String? productNumber /*= "undefined"*/;
  String? buhNumber /*= "undefined"*/;
  String? invNumber /*= "undefined"*/;
  String? userName /*= "undefined"*/;
  String? storage /*= "undefined"*/;
  String? sealNumber /*= "undefined"*/;
  String? cleanDate /*= "undefined"*/;
  String? comment /*= "undefined"*/;

  Record({
    this.id,
    this.model,
    this.buhName,
    this.serialNumber,
    this.productNumber,
    this.buhNumber,
    this.invNumber,
    this.userName,
    this.storage,
    this.sealNumber,
    this.cleanDate,
    this.comment,
  });

  int p1rint(){
    print(''''
id => ${this.id}
model => ${this.model}
buhName => ${this.buhName}
serialNumber => ${this.serialNumber}
productNumber => ${this.productNumber}
buhNumber => ${this.buhNumber}
invNumber => ${this.invNumber}
userName => ${this.userName}
storage => ${this.storage}
sealNumber => ${this.sealNumber}
cleanDate => ${this.cleanDate}
comment => ${this.comment}
    ''');

    return 1;
  }
}