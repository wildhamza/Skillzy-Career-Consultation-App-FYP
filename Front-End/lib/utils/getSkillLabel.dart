String getSkillLabel(String value, int index) {
  int val = int.tryParse(value) ?? 0;

  if (index == 20) {
    switch (val) {
      case 1:
        return 'Not at all';
      case 2:
        return 'Slightly';
      case 3:
        return 'Somewhat';
      case 4:
        return 'Moderately';
      case 5:
        return 'Quite a bit';
      case 6:
        return 'Very';
      case 7:
        return 'Extremely';
      default:
        return 'Unknown';
    }
  }
  if (index == 21) {
    switch (val) {
      case 1:
        return "I don't handle it at all";
      case 2:
        return "I struggle significantly";
      case 3:
        return "I usually get overwhelmed";
      case 4:
        return "I manage with difficulty";
      case 5:
        return "I handle it decently";
      case 6:
        return "I manage it well";
      case 7:
        return "I thrive under pressure";
      default:
        return 'Unknown';
    }
  }
  if (index == 22) {
    switch (val) {
      case 1:
        return "Extremely uncomfortable";
      case 2:
        return "Very uncomfortable";
      case 3:
        return "Somewhat uncomfortable";
      case 4:
        return "Neutral / Sometimes comfortable";
      case 5:
        return "Somewhat comfortable";
      case 6:
        return "Very comfortable";
      case 7:
        return "Extremely comfortable and confident";
      default:
        return 'Unknown';
    }
  }
  if (index == 23) {
    switch (val) {
      case 1:
        return "Strongly resist change";
      case 2:
        return "Resist change";
      case 3:
        return "Prefer stability over change";
      case 4:
        return "Neutral / Depends on the situation";
      case 5:
        return "Somewhat open to change";
      case 6:
        return "Open to change";
      case 7:
        return "Embrace and seek out change";
      default:
        return 'Unknown';
    }
  }
  if (index == 24) {
    switch (val) {
      case 1:
        return "Strongly prioritize work over fun";
      case 2:
        return "Mostly prioritize work";
      case 3:
        return "Lean toward work, but value fun";
      case 4:
        return "Balance work and fun equally";
      case 5:
        return "Lean toward fun, but respect work";
      case 6:
        return "Mostly prioritize fun";
      case 7:
        return "Strongly prioritize fun over work";
      default:
        return 'Unknown';
    }
  }

  if (index >= 0 && index <= 10) {
    // Technical Skills
    switch (val) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Novice';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Competent';
      case 5:
        return 'Proficient';
      case 6:
        return 'Advanced';
      case 7:
        return 'Expert';
      default:
        return 'Unknown';
    }
  } else if (index >= 11 && index <= 16) {
    // Soft Skills
    switch (val) {
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Below Average';
      case 4:
        return 'Average';
      case 5:
        return 'Above Average';
      case 6:
        return 'Strong';
      case 7:
        return 'Very Strong';
      default:
        return 'Unknown';
    }
  } else if (index >= 17 && index <= 21) {
    // Personality Traits
    switch (val) {
      case 1:
        return 'Never';
      case 2:
        return 'Rarely';
      case 3:
        return 'Occasionally';
      case 4:
        return 'Sometimes';
      case 5:
        return 'Often';
      case 6:
        return 'Very Often';
      case 7:
        return 'Always';
      default:
        return 'Unknown';
    }
  } else if (index >= 22 && index <= 26) {
    // Values & Preferences
    switch (val) {
      case 1:
        return 'Not Important';
      case 2:
        return 'Slightly Important';
      case 3:
        return 'Somewhat Important';
      case 4:
        return 'Moderately Important';
      case 5:
        return 'Important';
      case 6:
        return 'Very Important';
      case 7:
        return 'Extremely Important';
      default:
        return 'Unknown';
    }
  } else {
    // Default case
    return 'Unknown';
  }
}