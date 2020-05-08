import 'package:mindbook/models/emotion.dart';

class WheelUtil {
  Set<Map> _wheelSet;
  List<Emotion> _wheel;

  WheelUtil() {
    _wheelSet = {
      {
        "primary": "disgust",
        "secondary": "avoidance",
        "tertiary": "hesitant",
      },
      {
        "primary": "disgust",
        "secondary": "avoidance",
        "tertiary": "aversion",
      },
      {
        "primary": "disgust",
        "secondary": "awful",
        "tertiary": "detestable",
      },
      {
        "primary": "disgust",
        "secondary": "awful",
        "tertiary": "revulsion",
      },
      {
        "primary": "disgust",
        "secondary": "disappointed",
        "tertiary": "revolted",
      },
      {
        "primary": "disgust",
        "secondary": "disappointed",
        "tertiary": "repugnant",
      },
      {
        "primary": "disgust",
        "secondary": "disapproval",
        "tertiary": "loathing",
      },
      {
        "primary": "disgust",
        "secondary": "disapproval",
        "tertiary": "judgmental",
      },
      {
        "primary": "anger",
        "secondary": "critical",
        "tertiary": "sarcastic",
      },
      {
        "primary": "anger",
        "secondary": "critical",
        "tertiary": "skeptical",
      },
      {
        "primary": "anger",
        "secondary": "distant",
        "tertiary": "suspicious",
      },
      {
        "primary": "anger",
        "secondary": "distant",
        "tertiary": "withdrawn",
      },
      {
        "primary": "anger",
        "secondary": "frustrated",
        "tertiary": "irritated",
      },
      {
        "primary": "anger",
        "secondary": "frustrated",
        "tertiary": "infuriate",
      },
      {
        "primary": "anger",
        "secondary": "aggressive",
        "tertiary": "hostile",
      },
      {
        "primary": "anger",
        "secondary": "aggressive",
        "tertiary": "provoked",
      },
      {
        "primary": "anger",
        "secondary": "mad",
        "tertiary": "enraged",
      },
      {
        "primary": "anger",
        "secondary": "mad",
        "tertiary": "furious",
      },
      {
        "primary": "anger",
        "secondary": "hateful",
        "tertiary": "violated",
      },
      {
        "primary": "anger",
        "secondary": "hateful",
        "tertiary": "resentful",
      },
      {
        "primary": "anger",
        "secondary": "threatened",
        "tertiary": "jealous",
      },
      {
        "primary": "anger",
        "secondary": "threatened",
        "tertiary": "insecure",
      },
      {
        "primary": "anger",
        "secondary": "hurt",
        "tertiary": "devastated",
      },
      {
        "primary": "anger",
        "secondary": "hurt",
        "tertiary": "embarrassed",
      },
      {
        "primary": "fear",
        "secondary": "humiliated",
        "tertiary": "ridiculed",
      },
      {
        "primary": "fear",
        "secondary": "humiliated",
        "tertiary": "disrespected",
      },
      {
        "primary": "fear",
        "secondary": "rejected",
        "tertiary": "alienated",
      },
      {
        "primary": "fear",
        "secondary": "rejected",
        "tertiary": "inadequate",
      },
      {
        "primary": "fear",
        "secondary": "submissive",
        "tertiary": "insignificant",
      },
      {
        "primary": "fear",
        "secondary": "submissive",
        "tertiary": "worthless",
      },
      {
        "primary": "fear",
        "secondary": "insecure",
        "tertiary": "inferior",
      },
      {
        "primary": "fear",
        "secondary": "insecure",
        "tertiary": "inadequate",
      },
      {
        "primary": "fear",
        "secondary": "anxious",
        "tertiary": "worried",
      },
      {
        "primary": "fear",
        "secondary": "anxious",
        "tertiary": "overwhelmed",
      },
      {
        "primary": "fear",
        "secondary": "scared",
        "tertiary": "frightened",
      },
      {
        "primary": "fear",
        "secondary": "scared",
        "tertiary": "terrified",
      },
      {
        "primary": "surprise",
        "secondary": "startled",
        "tertiary": "shocked",
      },
      {
        "primary": "surprise",
        "secondary": "startled",
        "tertiary": "dismayed",
      },
      {
        "primary": "surprise",
        "secondary": "confused",
        "tertiary": "disillusioned",
      },
      {
        "primary": "surprise",
        "secondary": "confused",
        "tertiary": "perplexed",
      },
      {
        "primary": "surprise",
        "secondary": "amazed",
        "tertiary": "astonished",
      },
      {
        "primary": "surprise",
        "secondary": "amazed",
        "tertiary": "awe",
      },
      {
        "primary": "surprise",
        "secondary": "excited",
        "tertiary": "eager",
      },
      {
        "primary": "surprise",
        "secondary": "excited",
        "tertiary": "energetic",
      },
      {
        "primary": "happy",
        "secondary": "joyful",
        "tertiary": "liberated",
      },
      {
        "primary": "happy",
        "secondary": "joyful",
        "tertiary": "ecstatic",
      },
      {
        "primary": "happy",
        "secondary": "interested",
        "tertiary": "amused",
      },
      {
        "primary": "happy",
        "secondary": "interested",
        "tertiary": "inquisitive",
      },
      {
        "primary": "happy",
        "secondary": "proud",
        "tertiary": "important",
      },
      {
        "primary": "happy",
        "secondary": "proud",
        "tertiary": "confident",
      },
      {
        "primary": "happy",
        "secondary": "accepted",
        "tertiary": "respected",
      },
      {
        "primary": "happy",
        "secondary": "accepted",
        "tertiary": "fulfilled",
      },
      {
        "primary": "happy",
        "secondary": "powerful",
        "tertiary": "courageous",
      },
      {
        "primary": "happy",
        "secondary": "powerful",
        "tertiary": "provocative",
      },
      {
        "primary": "happy",
        "secondary": "peaceful",
        "tertiary": "loving",
      },
      {
        "primary": "happy",
        "secondary": "peaceful",
        "tertiary": "hopeful",
      },
      {
        "primary": "happy",
        "secondary": "intimate",
        "tertiary": "sensitive",
      },
      {
        "primary": "happy",
        "secondary": "intimate",
        "tertiary": "playful",
      },
      {
        "primary": "happy",
        "secondary": "optimistic",
        "tertiary": "open",
      },
      {
        "primary": "happy",
        "secondary": "optimistic",
        "tertiary": "inspired",
      },
      {
        "primary": "sad",
        "secondary": "bored",
        "tertiary": "indifferent",
      },
      {
        "primary": "sad",
        "secondary": "bored",
        "tertiary": "apathetic",
      },
      {
        "primary": "sad",
        "secondary": "lonely",
        "tertiary": "isolated",
      },
      {
        "primary": "sad",
        "secondary": "lonely",
        "tertiary": "abandoned",
      },
      {
        "primary": "sad",
        "secondary": "depressed",
        "tertiary": "empty",
      },
      {
        "primary": "sad",
        "secondary": "depressed",
        "tertiary": "inferior",
      },
      {
        "primary": "sad",
        "secondary": "despair",
        "tertiary": "vulnerable",
      },
      {
        "primary": "sad",
        "secondary": "despair",
        "tertiary": "powerless",
      },
      {
        "primary": "sad",
        "secondary": "abandoned",
        "tertiary": "victimized",
      },
      {
        "primary": "sad",
        "secondary": "abandoned",
        "tertiary": "ignored",
      },
      {
        "primary": "sad",
        "secondary": "guilty",
        "tertiary": "ashamed",
      },
      {
        "primary": "sad",
        "secondary": "guilty",
        "tertiary": "remorseful",
      }
    };
    _wheel = _wheelSet.map((e) => Emotion.fromSet(e.cast())).toList();
  }

  List<String> getPrimaryList() {
    return _wheel.map((e) => e.primary).toSet().toList();
  }

  List<String> getSecondaryList(List<String> primaries) {
    if (primaries == null) {
      return [];
    }
    return _wheel
        .where((element) => primaries.contains(element.primary))
        .map((e) => e.secondary)
        .toSet()
        .toList();
  }

  List<String> getTertiaryList(List<String> secondaries) {
    if (secondaries == null) {
      return [];
    }
    return _wheel
        .where((element) => secondaries.contains(element.secondary))
        .map((e) => e.tertiary)
        .toSet()
        .toList();
  }
  
}
