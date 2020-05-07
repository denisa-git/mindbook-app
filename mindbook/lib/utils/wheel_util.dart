class WheelUtil {
  Set<Map> _wheel;

  WheelUtil() {
    _wheel = {
      {
        "primary": "disgust",
        "secondary": "avoidance",
        "tertiary": "hesitant",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "avoidance",
        "tertiary": "aversion",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "awful",
        "tertiary": "detestable",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "awful",
        "tertiary": "revulsion",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "disappointed",
        "tertiary": "revolted",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "disappointed",
        "tertiary": "repugnant",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "disapproval",
        "tertiary": "loathing",
        "selected": false
      },
      {
        "primary": "disgust",
        "secondary": "disapproval",
        "tertiary": "judgmental",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "critical",
        "tertiary": "sarcastic",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "critical",
        "tertiary": "skeptical",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "distant",
        "tertiary": "suspicious",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "distant",
        "tertiary": "withdrawn",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "frustrated",
        "tertiary": "irritated",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "frustrated",
        "tertiary": "infuriate",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "aggressive",
        "tertiary": "hostile",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "aggressive",
        "tertiary": "provoked",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "mad",
        "tertiary": "enraged",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "mad",
        "tertiary": "furious",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "hateful",
        "tertiary": "violated",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "hateful",
        "tertiary": "resentful",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "threatened",
        "tertiary": "jealous",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "threatened",
        "tertiary": "insecure",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "hurt",
        "tertiary": "devastated",
        "selected": false
      },
      {
        "primary": "anger",
        "secondary": "hurt",
        "tertiary": "embarrassed",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "humiliated",
        "tertiary": "ridiculed",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "humiliated",
        "tertiary": "disrespected",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "rejected",
        "tertiary": "alienated",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "rejected",
        "tertiary": "inadequate",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "submissive",
        "tertiary": "insignificant",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "submissive",
        "tertiary": "worthless",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "insecure",
        "tertiary": "inferior",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "insecure",
        "tertiary": "inadequate",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "anxious",
        "tertiary": "worried",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "anxious",
        "tertiary": "overwhelmed",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "scared",
        "tertiary": "frightened",
        "selected": false
      },
      {
        "primary": "fear",
        "secondary": "scared",
        "tertiary": "terrified",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "startled",
        "tertiary": "shocked",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "startled",
        "tertiary": "dismayed",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "confused",
        "tertiary": "disillusioned",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "confused",
        "tertiary": "perplexed",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "amazed",
        "tertiary": "astonished",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "amazed",
        "tertiary": "awe",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "excited",
        "tertiary": "eager",
        "selected": false
      },
      {
        "primary": "surprise",
        "secondary": "excited",
        "tertiary": "energetic",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "joyful",
        "tertiary": "liberated",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "joyful",
        "tertiary": "ecstatic",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "interested",
        "tertiary": "amused",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "interested",
        "tertiary": "inquisitive",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "proud",
        "tertiary": "important",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "proud",
        "tertiary": "confident",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "accepted",
        "tertiary": "respected",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "accepted",
        "tertiary": "fulfilled",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "powerful",
        "tertiary": "courageous",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "powerful",
        "tertiary": "provocative",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "peaceful",
        "tertiary": "loving",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "peaceful",
        "tertiary": "hopeful",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "intimate",
        "tertiary": "sensitive",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "intimate",
        "tertiary": "playful",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "optimistic",
        "tertiary": "open",
        "selected": false
      },
      {
        "primary": "happy",
        "secondary": "optimistic",
        "tertiary": "inspired",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "bored",
        "tertiary": "indifferent",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "bored",
        "tertiary": "apathetic",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "lonely",
        "tertiary": "isolated",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "lonely",
        "tertiary": "abandoned",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "depressed",
        "tertiary": "empty",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "depressed",
        "tertiary": "inferior",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "despair",
        "tertiary": "vulnerable",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "despair",
        "tertiary": "powerless",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "abandoned",
        "tertiary": "victimized",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "abandoned",
        "tertiary": "ignored",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "guilty",
        "tertiary": "ashamed",
        "selected": false
      },
      {
        "primary": "sad",
        "secondary": "guilty",
        "tertiary": "remorseful",
        "selected": false
      }
    };
  }

  // List<dynamic> getPrimaryList() {
  //   return _wheel.map((e) => {
  //     String index = _wh
  //   }).toList();
  // }

  // List<dynamic> getSecondaryList(String primary) {
  //   return _wheel.where((element) => element.containsValue(primary)).toList();
  // }

  //   List<dynamic> getTertiaryList(String secondary) {
  //   return _wheel.keys.toList();
  // }


  // List<dynamic> getRingTwo(String emotionOne, String emotionTwo) {
  //   return _wheel[emotionOne][emotionTwo].keys.toList();
  // }
}
