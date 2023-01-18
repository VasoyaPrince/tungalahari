import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocaleString extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
      'en_US':{
        'Title' : 'Title',
        'Total Songs' :'Total Songs',
      'Album Title' : 'Album Title',
      'Song Name' : 'Song Name',
      'subtitle' : 'subtitle',
      'Subtitle' : 'Subtitle',
      'Singer Name' : 'Singer Name',

    },
    'hi_IN':{
        'Title' : 'शीर्षक',
      'Total Songs' :'कुल गीत',
      'Album Title' : 'एल्बम का शीर्षक',
      'Song Name' : 'गाने का नाम',
      'subtitle' : 'उपशीर्षक',
      'Subtitle' : 'उपशीर्षक',
      'Singer Name' : 'गायक का नाम',
    },
    'kn_IN':{
      'Title' : 'ಶೀರ್ಷಿಕೆ',
      'Total Songs' :'ಒಟ್ಟು ಹಾಡುಗಳು',
      'Album Title' : 'ಆಲ್ಬಮ್ ಶೀರ್ಷಿಕೆ',
      'Song Name' : 'ಹಾಡಿನ ಹೆಸರು',
      'subtitle' : 'ಉಪಶೀರ್ಷಿಕೆ',
      'Subtitle' : 'ಉಪಶೀರ್ಷಿಕೆ',
      'Singer Name' : 'ಗಾಯಕನ ಹೆಸರು',
    },
    'tm_IN':{
      'Title' : 'தலைப்பு',
      'Total Songs' :'மொத்த பாடல்கள்',
      'Album Title' : 'ஆல்பத்தின் தலைப்பு',
      'Song Name' : 'பாடல் பெயர்',
      'subtitle' : 'வசன வரிகள்',
      'Subtitle' : 'வசன வரிகள்',
      'Singer Name' : 'பாடகர் பெயர்',
    },
    'tg_IN':{
      'Title' : 'శీర్షిక',
      'Total Songs' :'మొత్తం పాటలు',
      'Album Title' : 'ఆల్బమ్ శీర్షిక',
      'Song Name' : 'పాట పేరు',
      'subtitle' : 'ఉపశీర్షిక',
      'Subtitle' : 'ఉపశీర్షిక',
      'Singer Name' : 'గాయకుడి పేరు ',
    },

  };

}