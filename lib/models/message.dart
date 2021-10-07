class MessageModel {
  String text, senderId, receiverId, image;
  var dateTime;

  MessageModel(
    this.text,
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.image,
  );

  MessageModel.fromJson(json) {
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    image = json['image'];
  }

  toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'image': image,
    };
  }
}
