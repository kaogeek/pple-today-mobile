import 'package:flutter/material.dart';

import '../../ui/utils/colors.dart';

class MenuAboutModel {
  Menu? menu;

  MenuAboutModel({this.menu});

  MenuAboutModel.fromJson(Map<String, dynamic> json) {
    menu = json["menu"] == null ? null : Menu.fromJson(json["menu"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (menu != null) {
      _data["menu"] = menu?.toJson();
    }
    return _data;
  }
}

class Menu {
  List<ListItem>? listItem;
  List<GridItem>? gridItem;

  Menu({this.listItem, this.gridItem});

  Menu.fromJson(Map<String, dynamic> json) {
    listItem = json["listItem"] == null ? null : (json["listItem"] as List).map((e) => ListItem.fromJson(e)).toList();
    gridItem = json["gridItem"] == null ? null : (json["gridItem"] as List).map((e) => GridItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (listItem != null) {
      _data["listItem"] = listItem?.map((e) => e.toJson()).toList();
    }
    if (gridItem != null) {
      _data["gridItem"] = gridItem?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class GridItem {
  String? title;
  String? imagePath;
  String? url;

  GridItem({this.title, this.imagePath, this.url});

  GridItem.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    imagePath = json["imagePath"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["imagePath"] = imagePath;
    _data["url"] = url;
    return _data;
  }
}

class ListItem {
  Color? backgroundColor;
  Color? textColor;
  String? leadingIcon;
  String? title;
  String? detail;
  String? imagePath;
  String? url;
  Other? other;

  ListItem(
      {this.backgroundColor,
      this.textColor,
      this.leadingIcon,
      this.title,
      this.detail,
      this.imagePath,
      this.url,
      this.other});

  ListItem.fromJson(Map<String, dynamic> json) {
    backgroundColor = json["backgroundColor"] == null ? null : colorContain(json["backgroundColor"]);
    textColor = json["textColor"] == null ? null : colorContain(json["textColor"]);
    leadingIcon = json["leadingIcon"];
    title = json["title"];
    detail = json["detail"];
    imagePath = json["imagePath"];
    url = json["url"];
    other = json["other"] == null ? null : Other.fromJson(json["other"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["backgroundColor"] = backgroundColor;
    _data["textColor"] = textColor;
    _data["leadingIcon"] = leadingIcon;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["imagePath"] = imagePath;
    _data["url"] = url;
    if (other != null) {
      _data["other"] = other?.toJson();
    }
    return _data;
  }
}

class Other {
  String? url;
  String? leadingIcon;
  String? title;
  String? detail;
  Color? textColor;
  String? imagePath;

  Other({this.url, this.leadingIcon, this.title, this.detail, this.textColor, this.imagePath});

  Other.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    leadingIcon = json["leadingIcon"];
    title = json["title"];
    detail = json["detail"];
    textColor = json["textColor"] == null ? null : colorContain(json["textColor"]);
    imagePath = json["imagePath"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["leadingIcon"] = leadingIcon;
    _data["title"] = title;
    _data["detail"] = detail;
    _data["textColor"] = textColor;
    _data["imagePath"] = imagePath;
    return _data;
  }
}

Color colorContain(String color) {
  switch (color) {
    case 'kPrimaryColor':
      return kPrimaryColor;

    case 'primaryBlue':
      return primaryBlue;

    case 'white':
      return Colors.white;

    case 'black':
      return Colors.black;

    default:
      return kPrimaryColor;
  }
}
