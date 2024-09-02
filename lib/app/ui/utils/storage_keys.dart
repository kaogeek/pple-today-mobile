class StorageKeys {
  StorageKeys._();

  static String get isDarkMode => 'IS_DARK_MODE';
  static String get isLoading => 'IS_LOADING';

  static String get isGoogle => 'isLoginGoogle';
  static String get isFacebook => 'isLoginFacebook';
  static String get isTwitter => 'isLoginTwitter';
  static String get isApple => 'isLoginApple';

  static String get eula => 'EULA';
  static String get isNotUpdate => 'IS_NOT_UPDATE';
  static String get tokenFCM => 'TOKENFCM';
  static String get initLink => 'INIT_LINK';

  static String get checkOfflineApp => 'CHECK_OFFLINE_APP';
  static String get disablesUpdate => 'DISABLES_UPDATE';
  static String get checkVersionUpdate => 'CHECK_VERSION_UPDATE';
  static String get loginWithSocial => 'LOGIN_WITH_SOCIAL';
  static String get menuItems => 'MENU_ITEMS';

  static String get uid => 'UID';
  static String get uidAct => 'UID_ACT';
  static String get imagePath => 'IMAGE_PATH';
  static String get imageURL => 'IMAGEURL';
  static String get displayName => 'DISPLAYNAME';
  static String get token => 'TOKEN';
  static String get mode => 'MODE';
  static String get memberShip => 'MEMBER_SHIP';
  static String get authMemberShip => 'AUTH_MEMBER_SHIP';
  static String get popUpMemberShip => 'POP_UP_MEMBER_SHIP';
  static String get whiteList => 'WHITE_LIST';
  static String get allowCreate => 'ALLOW_CREATE';
  static String get blockUser => 'BLOCKUSER';
  static String get pageList => 'PAGELIST';
  static String get voteObjId => 'VOTEOBJID';

  /// All keys for the local storage
  static List<String> get allKeys => [
        isDarkMode,
        isLoading,
        isGoogle,
        isFacebook,
        isTwitter,
        isApple,
        eula,
        isNotUpdate,
        tokenFCM,
        initLink,
        checkOfflineApp,
        disablesUpdate,
        checkVersionUpdate,
        loginWithSocial,
        menuItems,
        uid,
        uidAct,
        imagePath,
        imageURL,
        displayName,
        token,
        mode,
        memberShip,
        authMemberShip,
        popUpMemberShip,
        whiteList,
        allowCreate,
        blockUser,
        pageList,
      ];

  /// Keys logout
  static List<String> get keysLogout => [
        uid,
        uidAct,
        token,
        imagePath,
        imageURL,
        displayName,
        mode,
        memberShip,
        authMemberShip,
        popUpMemberShip,
        whiteList,
        allowCreate,
        blockUser,
        pageList,
      ];
}
