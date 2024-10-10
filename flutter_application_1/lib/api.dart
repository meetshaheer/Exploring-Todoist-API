// ignore_for_file: unnecessary_this

class taskApiModel {
  String? id;
  String? projectId;
  int? order;
  String? content;
  String? description;
  bool? isCompleted;
  List<Null>? labels;
  int? priority;
  int? commentCount;
  String? creatorId;
  String? createdAt;
  Null? due;
  String? url;
  Null? duration;
  Null? deadline;

  taskApiModel(
      {this.id,
      this.projectId,
      this.order,
      this.content,
      this.description,
      this.isCompleted,
      this.labels,
      this.priority,
      this.commentCount,
      this.creatorId,
      this.createdAt,
      this.due,
      this.url,
      this.duration,
      this.deadline});

  taskApiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    order = json['order'];
    content = json['content'];
    description = json['description'];
    isCompleted = json['is_completed'];
    if (json['labels'] != null) {
      labels = <Null>[];
      json['labels'].forEach((v) {});
    }
    priority = json['priority'];
    commentCount = json['comment_count'];
    creatorId = json['creator_id'];
    createdAt = json['created_at'];
    url = json['url'];
    duration = json['duration'];
    deadline = json['deadline'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_id'] = this.projectId;
    data['order'] = this.order;
    data['content'] = this.content;
    data['description'] = this.description;
    data['is_completed'] = this.isCompleted;
    if (this.labels != null) {
      data['labels'] = this.labels!.map((v) => toJson()).toList();
    }
    data['priority'] = this.priority;
    data['comment_count'] = this.commentCount;
    data['creator_id'] = this.creatorId;
    data['created_at'] = this.createdAt;
    data['due'] = this.due;
    data['url'] = this.url;
    data['duration'] = this.duration;
    data['deadline'] = this.deadline;
    return data;
  }
}
